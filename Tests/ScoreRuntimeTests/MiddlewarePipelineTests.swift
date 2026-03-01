import Foundation
import HTTPTypes
import Testing

@testable import ScoreRuntime

@Test func emptyMiddlewareCallsHandlerDirectly() async throws {
    let handler: @Sendable (RequestContext) async throws -> Response = { _ in
        Response.text("base")
    }
    let composed = HTTPMiddleware.compose([], handler: handler)
    let ctx = RequestContext(method: .get, path: "/")
    let response = try await composed(ctx)
    #expect(String(data: response.body, encoding: .utf8) == "base")
}

@Test func singleMiddlewareWrapsHandler() async throws {
    let mw = HTTPMiddleware { request, next in
        var response = try await next(request)
        response.headers["x-middleware"] = "applied"
        return response
    }
    let handler: @Sendable (RequestContext) async throws -> Response = { _ in
        Response.text("ok")
    }
    let composed = HTTPMiddleware.compose([mw], handler: handler)
    let ctx = RequestContext(method: .get, path: "/")
    let response = try await composed(ctx)
    #expect(response.headers["x-middleware"] == "applied")
    #expect(String(data: response.body, encoding: .utf8) == "ok")
}

@Test func middlewaresExecuteInOrder() async throws {
    let first = HTTPMiddleware { request, next in
        var response = try await next(request)
        let existing = response.headers["x-order"] ?? ""
        response.headers["x-order"] = existing + "1"
        return response
    }
    let second = HTTPMiddleware { request, next in
        var response = try await next(request)
        let existing = response.headers["x-order"] ?? ""
        response.headers["x-order"] = existing + "2"
        return response
    }
    let handler: @Sendable (RequestContext) async throws -> Response = { _ in
        Response.text("ok")
    }
    // First middleware is outermost, so second runs closer to handler.
    // Handler runs, second appends "2", first appends "1" → "21"
    let composed = HTTPMiddleware.compose([first, second], handler: handler)
    let ctx = RequestContext(method: .get, path: "/")
    let response = try await composed(ctx)
    #expect(response.headers["x-order"] == "21")
}

@Test func middlewareCanShortCircuit() async throws {
    let mw = HTTPMiddleware { _, _ in
        Response.text("blocked", status: .forbidden)
    }
    let handler: @Sendable (RequestContext) async throws -> Response = { _ in
        Response.text("should not reach")
    }
    let composed = HTTPMiddleware.compose([mw], handler: handler)
    let ctx = RequestContext(method: .get, path: "/")
    let response = try await composed(ctx)
    #expect(response.status == .forbidden)
    #expect(String(data: response.body, encoding: .utf8) == "blocked")
}
