import ScoreCore

/// Renders a Score `Node` tree into an HTML string.
///
/// `HTMLRenderer` recursively walks a node tree, dispatching on concrete
/// primitive node types to produce deterministic, diffable HTML output.
/// Composite nodes (those whose `Body` is not `Never`) are expanded by
/// calling their `body` property until a primitive is reached.
///
/// The renderer handles HTML entity escaping for text content and attribute
/// values, ensuring the output is safe for embedding in an HTML document.
///
/// ### Example
///
/// ```swift
/// let renderer = HTMLRenderer()
/// let html = renderer.render(
///     Stack {
///         Heading(.one) { Text(verbatim: "Hello") }
///         Paragraph { Text(verbatim: "Welcome to Score.") }
///     }
/// )
/// // html == "<div><h1>Hello</h1><p>Welcome to Score.</p></div>"
/// ```
///
/// - Note: `HTMLRenderer` is designed for server-side use and produces
///   static HTML. Interactive behaviour requires the Score runtime.
public struct HTMLRenderer: Sendable {

    /// Creates a new HTML renderer.
    public init() {}

    /// Renders the given node tree into an HTML string.
    ///
    /// - Parameter node: The root node of the tree to render.
    /// - Returns: A string containing the rendered HTML.
    public func render(_ node: some Node) -> String {
        var output = ""
        write(node, to: &output)
        return output
    }

    /// Writes a node to `output`, dispatching via `HTMLRenderable` or falling back to `body`.
    func write(_ node: some Node, to output: inout String) {
        if let renderable = node as? HTMLRenderable {
            renderable.renderHTML(into: &output, renderer: self)
            return
        }

        if node.body is Never { return }
        write(node.body, to: &output)
    }

    /// Emits an opening tag, recursively renders `content`, then emits the closing tag.
    func tag(_ name: String, _ attributes: [(String, String)] = [], content: some Node, to output: inout String) {
        output.append("<\(name)")
        writeAttributes(attributes, to: &output)
        output.append(">")
        write(content, to: &output)
        output.append("</\(name)>")
    }

    /// Emits a self-closing void element tag with no content.
    func voidTag(_ name: String, _ attributes: [(String, String)], to output: inout String) {
        output.append("<\(name)")
        writeAttributes(attributes, to: &output)
        output.append(">")
    }

    /// Appends each attribute to `output`; boolean attributes (empty value) are emitted without a value.
    func writeAttributes(_ attributes: [(String, String)], to output: inout String) {
        for (key, value) in attributes {
            if value.isEmpty {
                output.append(" \(key)")
            } else {
                output.append(" \(key)=\"\(value.attributeEscaped)\"")
            }
        }
    }

}
