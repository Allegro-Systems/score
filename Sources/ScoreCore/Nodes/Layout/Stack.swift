/// A generic layout container that groups child nodes into a block-level stack.
///
/// `Stack` renders as the HTML `<div>` element and is the fundamental building
/// block for composing layouts in Score. It places its children in document
/// order, stacking them vertically by default (subject to any CSS applied in
/// the rendered output).
///
/// Use `Stack` when none of the semantic containers (such as `Main`, `Section`,
/// or `Article`) accurately describes the content being grouped — for example,
/// when you need a purely presentational wrapper to apply styling.
///
/// ### Example
///
/// ```swift
/// Stack {
///     Text("Hello")
///     Text("World")
/// }
/// ```
///
/// - Note: Prefer semantic containers such as `Section` or `Article` when the
///   content has meaningful document structure, as they convey intent to both
///   browsers and assistive technologies.
public struct Stack<Content: Node>: Node {

    /// The child nodes contained within this stack.
    public let content: Content

    /// Creates a stack with the given child content.
    ///
    /// - Parameter content: A node builder closure that produces the children to be
    ///     grouped inside the stack.
    public init(@NodeBuilder content: () -> Content) {
        self.content = content()
    }

    /// This node is rendered directly by the Score runtime and does not have a
    /// composable body.
    public var body: Never { fatalError() }
}
