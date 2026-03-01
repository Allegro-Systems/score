/// A concrete middleware type for HTTP request processing.
///
/// `HTTPMiddleware` wraps a closure that intercepts a ``RequestContext``
/// and produces a ``Response``, optionally delegating to the next handler
/// in the pipeline.
///
/// ### Example
///
/// ```swift
/// let logging = HTTPMiddleware { request, next in
///     print("→ \(request.method) \(request.path)")
///     let response = try await next(request)
///     print("← \(response.status)")
///     return response
/// }
/// ```
public struct HTTPMiddleware: Sendable {

    /// The middleware handler closure.
    public let handle:
        @Sendable (
            RequestContext,
            @Sendable (RequestContext) async throws -> Response
        ) async throws -> Response

    /// Creates an HTTP middleware from the given handler closure.
    ///
    /// - Parameter handle: A closure that receives the request and a `next`
    ///   function to call the next handler in the pipeline.
    public init(
        _ handle:
            @escaping @Sendable (
                RequestContext,
                @Sendable (RequestContext) async throws -> Response
            ) async throws -> Response
    ) {
        self.handle = handle
    }

    /// Composes an ordered list of middleware around a base handler.
    ///
    /// Middlewares execute in order: the first middleware in the array is the
    /// outermost wrapper and runs first. Each middleware calls `next` to
    /// delegate to the next middleware or the base handler.
    ///
    /// - Parameters:
    ///   - middlewares: The middleware stack to compose.
    ///   - handler: The base handler to invoke after all middleware.
    /// - Returns: A composed handler function.
    public static func compose(
        _ middlewares: [HTTPMiddleware],
        handler: @escaping @Sendable (RequestContext) async throws -> Response
    ) -> @Sendable (RequestContext) async throws -> Response {
        var next = handler
        for middleware in middlewares.reversed() {
            let currentNext = next
            let mw = middleware
            next = { request in
                try await mw.handle(request, currentNext)
            }
        }
        return next
    }
}
