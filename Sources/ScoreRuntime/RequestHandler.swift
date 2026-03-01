import Foundation
import HTTPTypes
import Logging
import NIOCore
import NIOHTTP1
import ScoreCore
import ScoreRouter

/// NIO channel handler that processes HTTP/1.1 requests for the Score server.
///
/// `RequestHandler` accumulates the full request (head + body), resolves
/// incoming requests against a ``RouteTable``, renders pages via
/// ``PageRenderer``, invokes controller handlers with a ``RequestContext``,
/// and produces appropriate HTTP responses including 404 and 405 error pages.
final class RequestHandler: ChannelInboundHandler, Sendable {
    typealias InboundIn = HTTPServerRequestPart
    typealias OutboundOut = HTTPServerResponsePart

    private let routeTable: RouteTable
    private let pages: [String: any Page]
    private let metadata: (any Metadata)?
    private let theme: (any Theme)?
    private let staticDirectory: String?
    private let middlewares: [HTTPMiddleware]
    private let logger: Logger

    // Request accumulation state. Safe because NIO calls channelRead
    // on the same event loop thread for a given channel.
    nonisolated(unsafe) private var requestHead: HTTPRequestHead?
    nonisolated(unsafe) private var bodyBuffer: ByteBuffer?

    init(
        routeTable: RouteTable,
        pages: [String: any Page],
        metadata: (any Metadata)?,
        theme: (any Theme)?,
        staticDirectory: String? = nil,
        middlewares: [HTTPMiddleware] = [],
        logger: Logger = Logger(label: "dev.allegro.score.server")
    ) {
        self.routeTable = routeTable
        self.pages = pages
        self.metadata = metadata
        self.theme = theme
        self.staticDirectory = staticDirectory
        self.middlewares = middlewares
        self.logger = logger
    }

    func channelRead(context: ChannelHandlerContext, data: NIOAny) {
        let part = unwrapInboundIn(data)

        switch part {
        case .head(let head):
            requestHead = head
            bodyBuffer = context.channel.allocator.buffer(capacity: 0)

        case .body(var buffer):
            bodyBuffer?.writeBuffer(&buffer)

        case .end:
            guard let head = requestHead else { return }
            let start = ContinuousClock.now
            dispatch(head: head, body: bodyBuffer, context: context, start: start)
            requestHead = nil
            bodyBuffer = nil
        }
    }

    private func dispatch(
        head: HTTPRequestHead,
        body: ByteBuffer?,
        context: ChannelHandlerContext,
        start: ContinuousClock.Instant
    ) {
        let uri = head.uri
        let path = uri.split(separator: "?", maxSplits: 1).first.map(String.init) ?? uri
        let method = httpMethod(from: head.method)

        // Static file serving — checked before route resolution.
        if let staticDir = staticDirectory, path.hasPrefix("/static/") {
            let relativePath = String(path.dropFirst("/static/".count))
            if let (data, contentType) = StaticFileHandler.serve(relativePath: relativePath, from: staticDir) {
                respondWithData(context: context, status: .ok, contentType: contentType, body: data)
                logRequest(method: head.method, path: path, status: .ok, start: start)
            } else {
                respond(context: context, status: .notFound, contentType: "text/plain", body: "Not Found")
                logRequest(method: head.method, path: path, status: .notFound, start: start)
            }
            return
        }

        do {
            let resolved = try routeTable.resolve(method: method, path: path)

            if resolved.isPage, let page = pages[resolved.pattern] {
                let html = PageRenderer.render(page: page, metadata: metadata, theme: theme)
                respond(context: context, status: .ok, contentType: "text/html; charset=utf-8", body: html)
                logRequest(method: head.method, path: path, status: .ok, start: start)
            } else if let handler = resolved.handler {
                let queryParameters = RequestContext.parseQuery(uri)
                let headers = Dictionary(
                    head.headers.map { ($0.name.lowercased(), $0.value) },
                    uniquingKeysWith: { first, _ in first }
                )
                var bodyData: Data?
                if var buf = body, buf.readableBytes > 0 {
                    if let bytes = buf.readBytes(length: buf.readableBytes) {
                        bodyData = Data(bytes)
                    }
                }
                let requestContext = RequestContext(
                    method: method,
                    path: path,
                    pathParameters: resolved.parameters,
                    queryParameters: queryParameters,
                    headers: headers,
                    body: bodyData
                )

                let eventLoop = context.eventLoop
                let promise = eventLoop.makePromise(of: Response.self)

                let mws = self.middlewares
                promise.completeWithTask {
                    let baseHandler: @Sendable (RequestContext) async throws -> Response = { ctx in
                        let result = try await handler(ctx as any Sendable)
                        if let response = result as? Response {
                            return response
                        }
                        return Response.text(String(describing: result))
                    }
                    let pipeline = HTTPMiddleware.compose(mws, handler: baseHandler)
                    return try await pipeline(requestContext)
                }

                nonisolated(unsafe) let ctx = context
                let startCopy = start
                let pathCopy = path
                let methodCopy = head.method
                promise.futureResult.whenComplete { [self] result in
                    switch result {
                    case .success(let response):
                        self.respondWithResponse(context: ctx, response: response)
                        self.logRequest(method: methodCopy, path: pathCopy, status: self.nioStatus(from: response.status), start: startCopy)
                    case .failure:
                        self.respond(context: ctx, status: .internalServerError, contentType: "text/plain", body: "Internal Server Error")
                        self.logRequest(method: methodCopy, path: pathCopy, status: .internalServerError, start: startCopy)
                    }
                }
                return
            } else {
                respond(context: context, status: .ok, contentType: "text/plain", body: "OK")
                logRequest(method: head.method, path: path, status: .ok, start: start)
            }
        } catch let error as RoutingError {
            switch error {
            case .notFound:
                respond(context: context, status: .notFound, contentType: "text/plain", body: "Not Found")
                logRequest(method: head.method, path: path, status: .notFound, start: start)
            case .methodNotAllowed(_, let allowed):
                let allowHeader = allowed.map(\.rawValue).joined(separator: ", ")
                respond(
                    context: context,
                    status: .methodNotAllowed,
                    contentType: "text/plain",
                    body: "Method Not Allowed",
                    extraHeaders: [("Allow", allowHeader)]
                )
                logRequest(method: head.method, path: path, status: .methodNotAllowed, start: start)
            }
        } catch {
            respond(context: context, status: .internalServerError, contentType: "text/plain", body: "Internal Server Error")
            logRequest(method: head.method, path: path, status: .internalServerError, start: start)
        }
    }

    // MARK: - Response Helpers

    private func respond(
        context: ChannelHandlerContext,
        status: HTTPResponseStatus,
        contentType: String,
        body: String,
        extraHeaders: [(String, String)] = []
    ) {
        let bodyData = ByteBuffer(string: body)
        var headers = HTTPHeaders()
        headers.add(name: "Content-Type", value: contentType)
        headers.add(name: "Content-Length", value: String(bodyData.readableBytes))
        for (name, value) in extraHeaders {
            headers.add(name: name, value: value)
        }

        let head = HTTPResponseHead(version: .http1_1, status: status, headers: headers)
        context.write(wrapOutboundOut(.head(head)), promise: nil)
        context.write(wrapOutboundOut(.body(.byteBuffer(bodyData))), promise: nil)
        context.writeAndFlush(wrapOutboundOut(.end(nil)), promise: nil)
    }

    private func respondWithData(
        context: ChannelHandlerContext,
        status: HTTPResponseStatus,
        contentType: String,
        body: Data
    ) {
        var buffer = context.channel.allocator.buffer(capacity: body.count)
        buffer.writeBytes(body)
        var headers = HTTPHeaders()
        headers.add(name: "Content-Type", value: contentType)
        headers.add(name: "Content-Length", value: String(body.count))

        let head = HTTPResponseHead(version: .http1_1, status: status, headers: headers)
        context.write(wrapOutboundOut(.head(head)), promise: nil)
        context.write(wrapOutboundOut(.body(.byteBuffer(buffer))), promise: nil)
        context.writeAndFlush(wrapOutboundOut(.end(nil)), promise: nil)
    }

    private func respondWithResponse(context: ChannelHandlerContext, response: Response) {
        let status = nioStatus(from: response.status)
        var buffer = context.channel.allocator.buffer(capacity: response.body.count)
        buffer.writeBytes(response.body)

        var headers = HTTPHeaders()
        for (name, value) in response.headers {
            headers.add(name: name, value: value)
        }
        headers.replaceOrAdd(name: "Content-Length", value: String(response.body.count))

        let head = HTTPResponseHead(version: .http1_1, status: status, headers: headers)
        context.write(wrapOutboundOut(.head(head)), promise: nil)
        context.write(wrapOutboundOut(.body(.byteBuffer(buffer))), promise: nil)
        context.writeAndFlush(wrapOutboundOut(.end(nil)), promise: nil)
    }

    // MARK: - Logging

    private func logRequest(
        method: NIOHTTP1.HTTPMethod,
        path: String,
        status: HTTPResponseStatus,
        start: ContinuousClock.Instant
    ) {
        let duration = ContinuousClock.now - start
        logger.info("\(method) \(path) \(status.code) \(duration)")
    }

    // MARK: - Conversions

    private func httpMethod(from nioMethod: NIOHTTP1.HTTPMethod) -> HTTPRequest.Method {
        switch nioMethod {
        case .GET: return .get
        case .POST: return .post
        case .PUT: return .put
        case .DELETE: return .delete
        case .PATCH: return .patch
        case .HEAD: return .head
        case .OPTIONS: return .options
        default: return .get
        }
    }

    private func nioStatus(from status: HTTPResponse.Status) -> HTTPResponseStatus {
        HTTPResponseStatus(statusCode: status.code)
    }
}
