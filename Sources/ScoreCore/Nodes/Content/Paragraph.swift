/// A node that renders a paragraph of text content.
///
/// `Paragraph` wraps its children in an HTML `<p>` element, representing a
/// discrete block of prose. Browsers typically add vertical margin above and
/// below a paragraph, visually separating it from surrounding content.
///
/// Use `Paragraph` whenever you want to present a self-contained block of
/// running text. For shorter inline text fragments that should not introduce
/// a block boundary, use ``Text`` instead.
///
/// Renders as the HTML `<p>` element.
///
/// ### Example — simple paragraph
///
/// ```swift
/// Paragraph {
///     Text(verbatim: "Score makes it easy to build HTML documents in Swift.")
/// }
/// ```
///
/// ### Example — paragraph with inline formatting
///
/// ```swift
/// Paragraph {
///     Text(verbatim: "Install the package, then import ")
///     Code { Text(verbatim: "ScoreCore") }
///     Text(verbatim: " in your Swift file.")
/// }
/// ```
public struct Paragraph<Content: Node>: Node {

    /// The child node that provides the paragraph's rendered content.
    public let content: Content

    /// Creates a paragraph node from a node-builder closure.
    ///
    /// Supply inline nodes — such as ``Text``, ``Strong``, ``Emphasis``,
    /// or ``Code`` — inside the closure to form the paragraph's content.
    ///
    /// ### Example
    ///
    /// ```swift
    /// Paragraph {
    ///     Text(verbatim: "This is a ")
    ///     Strong { Text(verbatim: "bold") }
    ///     Text(verbatim: " statement.")
    /// }
    /// ```
    ///
    /// - Parameter content: A `@NodeBuilder` closure that produces the
    ///   child node rendered inside the `<p>` element.
    public init(@NodeBuilder content: () -> Content) {
        self.content = content()
    }

    /// The body of this node.
    ///
    /// - Important: `Paragraph` is a primitive node and does not have a
    ///   composable body. Accessing this property will cause a fatal error
    ///   at runtime and is reserved for the Score rendering engine.
    public var body: Never { fatalError() }
}
