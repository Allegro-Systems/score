import ScoreCore

/// Renders as the appropriate `<h1>`–`<h6>` heading element.
extension Heading: HTMLRenderable {
    /// Wraps content in the heading tag corresponding to `level`.
    func renderHTML(into output: inout String, renderer: HTMLRenderer) {
        renderer.tag("h\(level.rawValue)", content: content, to: &output)
    }
}

/// Renders as a `<p>` paragraph element.
extension Paragraph: HTMLRenderable {
    /// Wraps content in a `<p>` element.
    func renderHTML(into output: inout String, renderer: HTMLRenderer) {
        renderer.tag("p", content: content, to: &output)
    }
}

/// Renders transparently, emitting children with no wrapper element.
extension Text: HTMLRenderable {
    /// Emits content directly, producing no surrounding tag of its own.
    func renderHTML(into output: inout String, renderer: HTMLRenderer) {
        renderer.write(content, to: &output)
    }
}

/// Renders as a `<strong>` importance element.
extension Strong: HTMLRenderable {
    /// Wraps content in a `<strong>` element.
    func renderHTML(into output: inout String, renderer: HTMLRenderer) {
        renderer.tag("strong", content: content, to: &output)
    }
}

/// Renders as an `<em>` emphasis element.
extension Emphasis: HTMLRenderable {
    /// Wraps content in an `<em>` element.
    func renderHTML(into output: inout String, renderer: HTMLRenderer) {
        renderer.tag("em", content: content, to: &output)
    }
}

/// Renders as a `<small>` side-comment element.
extension Small: HTMLRenderable {
    /// Wraps content in a `<small>` element.
    func renderHTML(into output: inout String, renderer: HTMLRenderer) {
        renderer.tag("small", content: content, to: &output)
    }
}

/// Renders as a `<mark>` highlight element.
extension Mark: HTMLRenderable {
    /// Wraps content in a `<mark>` element.
    func renderHTML(into output: inout String, renderer: HTMLRenderer) {
        renderer.tag("mark", content: content, to: &output)
    }
}

/// Renders as a `<code>` inline code element.
extension Code: HTMLRenderable {
    /// Wraps content in a `<code>` element.
    func renderHTML(into output: inout String, renderer: HTMLRenderer) {
        renderer.tag("code", content: content, to: &output)
    }
}

/// Renders as a `<pre>` preformatted text element.
extension Preformatted: HTMLRenderable {
    /// Wraps content in a `<pre>` element, preserving whitespace.
    func renderHTML(into output: inout String, renderer: HTMLRenderer) {
        renderer.tag("pre", content: content, to: &output)
    }
}

/// Renders as a `<blockquote>` element.
extension Blockquote: HTMLRenderable {
    /// Wraps content in a `<blockquote>` element.
    func renderHTML(into output: inout String, renderer: HTMLRenderer) {
        renderer.tag("blockquote", content: content, to: &output)
    }
}

/// Renders as an `<address>` contact information element.
extension Address: HTMLRenderable {
    /// Wraps content in an `<address>` element.
    func renderHTML(into output: inout String, renderer: HTMLRenderer) {
        renderer.tag("address", content: content, to: &output)
    }
}

/// Renders as the `<hr>` void element.
extension HorizontalRule: HTMLRenderable {
    /// Emits a self-closing `<hr>` tag.
    func renderHTML(into output: inout String, renderer: HTMLRenderer) {
        output.append("<hr>")
    }
}

/// Renders as the `<br>` void element.
extension LineBreak: HTMLRenderable {
    /// Emits a self-closing `<br>` tag.
    func renderHTML(into output: inout String, renderer: HTMLRenderer) {
        output.append("<br>")
    }
}
