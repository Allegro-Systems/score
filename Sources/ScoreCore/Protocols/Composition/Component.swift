/// A protocol that marks a type as a reusable, composable UI building block.
///
/// `Component` refines `Node` to represent self-contained pieces of user
/// interface that encapsulate their own structure, layout, and styling.
/// Components are the primary abstraction for building modular, reusable UI
/// in Score.
///
/// Because `Component` inherits from `Node`, every component has a `body`
/// property built with `@NodeBuilder` that describes its internal node
/// hierarchy. Components may nest other nodes or components arbitrarily deep.
///
/// Typical uses include:
/// - Encapsulating a card, list item, or navigation bar into a named type
/// - Sharing common UI patterns across multiple pages
/// - Accepting configuration via stored properties
///
/// ### Example
///
/// ```swift
/// struct UserCard: Component {
///     let username: String
///     let avatarURL: String
///
///     var body: some Node {
///         Stack {
///             Image(src: avatarURL, alt: username)
///             Text(username)
///         }
///         .flex(direction: .row)
///     }
/// }
///
/// struct ProfilePage: Page {
///     static var path: String { "/profile" }
///
///     var body: some Node {
///         UserCard(username: "alice", avatarURL: "/avatars/alice.png")
///     }
/// }
/// ```
///
/// ### Protocol Conformance Requirements
///
/// A type conforming to `Component` must:
/// - Implement `var body: Body { get }` (inherited from `Node`), where `Body`
///   is any concrete `Node` type, typically expressed as `some Node`.
/// - Satisfy `Sendable` (inherited transitively through `Node`).
public protocol Component: Node {}
