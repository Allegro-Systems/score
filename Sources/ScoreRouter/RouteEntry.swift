import ScoreCore

/// A compiled route definition stored inside a `RouteTable`.
///
/// `RouteEntry` captures the normalized information needed during route
/// resolution so request matching can work from pre-split path segments rather
/// than reprocessing route definitions each time.
struct RouteEntry: Sendable {

    /// The HTTP method this route accepts.
    let method: RouteMethod

    /// The original route pattern string.
    let pattern: String

    /// The route pattern split into path segments for matching.
    let segments: [String]

    /// The type-erased handler associated with the route, if any.
    let handler: (@Sendable (any Sendable) async throws -> any Sendable)?

    /// Whether the route was registered from a page definition.
    let isPage: Bool
}
