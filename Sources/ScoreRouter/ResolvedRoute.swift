import HTTPTypes
import ScoreCore

/// The result of successfully matching an incoming request against a route table.
///
/// `ResolvedRoute` carries the matched route's metadata, extracted path
/// parameters, and handler closure so the runtime can invoke the handler
/// without re-examining the routing table.
///
/// ### Example
///
/// ```swift
/// let table = RouteTable(app)
/// let resolved = try table.resolve(method: .get, path: "/users/42")
/// // resolved.parameters == ["id": "42"]
/// ```
public struct ResolvedRoute: Sendable {

    /// The HTTP method of the matched route.
    public let method: RouteMethod

    /// The original pattern string that matched (e.g., `"/users/:id"`).
    public let pattern: String

    /// Path parameters extracted from the request URL.
    ///
    /// Keys are parameter names without the leading `:`. For a pattern
    /// `"/users/:id"` matched against `"/users/42"`, this dictionary
    /// contains `["id": "42"]`.
    public let parameters: [String: String]

    /// The type-erased handler to invoke for this route.
    public let handler: (@Sendable (any Sendable) async throws -> any Sendable)?

    /// Whether this route was registered from a `Page` rather than a `Controller`.
    public let isPage: Bool
}
