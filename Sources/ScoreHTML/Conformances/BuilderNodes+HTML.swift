import ScoreCore

/// Produces no HTML output.
extension EmptyNode: HTMLRenderable {
    /// Emits nothing.
    func renderHTML(into output: inout String, renderer: HTMLRenderer) {}
}

/// Renders escaped text content directly into the output stream.
extension TextNode: HTMLRenderable {
    /// Appends the text content with `<`, `>`, `&`, and `"` escaped.
    func renderHTML(into output: inout String, renderer: HTMLRenderer) {
        output.append(content.htmlEscaped)
    }
}

/// Passes through to the wrapped content, discarding modifier metadata.
extension ModifiedNode: HTMLRenderable {
    /// Renders the underlying content node, ignoring any attached modifiers.
    func renderHTML(into output: inout String, renderer: HTMLRenderer) {
        renderer.write(content, to: &output)
    }
}

/// Renders all children in declaration order via parameter pack expansion.
extension TupleNode: HTMLRenderable {
    /// Emits each child using `repeat each children`.
    func renderHTML(into output: inout String, renderer: HTMLRenderer) {
        repeat renderer.write(each children, to: &output)
    }
}

/// Renders the active branch of an `if`/`else` builder expression.
extension ConditionalNode: HTMLRenderable {
    /// Emits the `.first` or `.second` branch depending on which was chosen at build time.
    func renderHTML(into output: inout String, renderer: HTMLRenderer) {
        switch storage {
        case .first(let content): renderer.write(content, to: &output)
        case .second(let content): renderer.write(content, to: &output)
        }
    }
}

/// Renders an optional node, producing no output when `nil`.
extension OptionalNode: HTMLRenderable {
    /// Emits the wrapped node if present; otherwise writes nothing.
    func renderHTML(into output: inout String, renderer: HTMLRenderer) {
        if let wrapped { renderer.write(wrapped, to: &output) }
    }
}

/// Renders each item produced by a data-driven loop.
extension ForEachNode: HTMLRenderable {
    /// Iterates `data`, applying `content` to each element and emitting the result.
    func renderHTML(into output: inout String, renderer: HTMLRenderer) {
        for element in data {
            renderer.write(content(element), to: &output)
        }
    }
}

/// Renders a runtime array of heterogeneous nodes.
extension ArrayNode: HTMLRenderable {
    /// Emits each child node in order.
    func renderHTML(into output: inout String, renderer: HTMLRenderer) {
        for child in children {
            renderer.write(child, to: &output)
        }
    }
}
