import HTTPTypes
import ScoreCore

/// A compiled lookup table that resolves incoming HTTP requests to route handlers.
///
/// `RouteTable` is built once at startup from an `Application`'s pages and
/// controllers. It stores a flat array of route entries and performs linear
/// scanning to match requests — appropriate for the small route counts typical
/// in Score applications.
///
/// Pages are registered as GET routes before controller routes, giving them
/// first-match-wins priority.
///
/// ### Example
///
/// ```swift
/// let table = RouteTable(app)
/// let resolved = try table.resolve(method: .get, path: "/users/42")
/// let response = try await resolved.handler?(request)
/// ```
public struct RouteTable: Sendable {

    private let entries: [RouteEntry]

    /// Creates a route table from the given application.
    ///
    /// Pages are registered as GET routes first, followed by controller routes.
    ///
    /// - Parameter application: The application whose pages and controllers
    ///   define the routing surface.
    public init(_ application: some Application) {
        var entries: [RouteEntry] = []

        for page in application.pages {
            let pattern = type(of: page).path
            entries.append(
                RouteEntry(
                    method: .get,
                    pattern: pattern,
                    segments: RouteTable.splitSegments(pattern),
                    handler: nil,
                    isPage: true
                ))
        }

        for controller in application.controllers {
            for route in controller.routes {
                let pattern = RouteTable.combinePaths(controller.base, route.path)
                entries.append(
                    RouteEntry(
                        method: route.method,
                        pattern: pattern,
                        segments: RouteTable.splitSegments(pattern),
                        handler: route.handler,
                        isPage: false
                    ))
            }
        }

        self.entries = entries
    }

    /// Resolves an HTTP method and path to a matching route.
    ///
    /// - Parameters:
    ///   - method: The HTTP method of the incoming request.
    ///   - path: The URL path of the incoming request.
    /// - Returns: A `ResolvedRoute` containing the matched handler and
    ///   extracted path parameters.
    /// - Throws: ``RoutingError/notFound(path:)`` if no route matches the path,
    ///   or ``RoutingError/methodNotAllowed(path:allowed:)`` if the path matches
    ///   but not for the given method.
    public func resolve(method: HTTPRequest.Method, path: String) throws -> ResolvedRoute {
        let requestSegments = RouteTable.splitSegments(path)
        var allowedMethods: [HTTPRequest.Method] = []

        for entry in entries {
            guard let parameters = RouteTable.match(pattern: entry.segments, request: requestSegments) else {
                continue
            }

            if entry.method == method {
                return ResolvedRoute(
                    method: entry.method,
                    pattern: entry.pattern,
                    parameters: parameters,
                    handler: entry.handler,
                    isPage: entry.isPage
                )
            }

            allowedMethods.append(entry.method)
        }

        if allowedMethods.isEmpty {
            throw RoutingError.notFound(path: path)
        }

        throw RoutingError.methodNotAllowed(path: path, allowed: allowedMethods)
    }

    static func splitSegments(_ path: String) -> [String] {
        path.split(separator: "/", omittingEmptySubsequences: true).map(String.init)
    }

    static func combinePaths(_ base: String, _ relative: String) -> String {
        let baseSegments = splitSegments(base)
        let relativeSegments = splitSegments(relative)
        let combined = (baseSegments + relativeSegments).joined(separator: "/")
        return combined.isEmpty ? "/" : "/\(combined)"
    }

    static func match(pattern: [String], request: [String]) -> [String: String]? {
        guard pattern.count == request.count else { return nil }

        var parameters: [String: String] = [:]

        for (patternSegment, requestSegment) in zip(pattern, request) {
            if patternSegment.hasPrefix(":") {
                let name = String(patternSegment.dropFirst())
                parameters[name] = requestSegment
            } else if patternSegment != requestSegment {
                return nil
            }
        }

        return parameters
    }
}
