import ScoreCore

/// Renders as a `<ul>` unordered list element.
extension UnorderedList: HTMLRenderable {
    /// Wraps content in a `<ul>` element.
    func renderHTML(into output: inout String, renderer: HTMLRenderer) {
        renderer.tag("ul", content: content, to: &output)
    }
}

/// Renders as an `<ol>` ordered list element.
extension OrderedList: HTMLRenderable {
    /// Emits an `<ol>` with optional `start` and `reversed` attributes.
    func renderHTML(into output: inout String, renderer: HTMLRenderer) {
        var a: [(String, String)] = []
        if let v = start { a.append(("start", String(v))) }
        if reversed { a.append(("reversed", "")) }
        renderer.tag("ol", a, content: content, to: &output)
    }
}

/// Renders as a `<li>` list item element.
extension ListItem: HTMLRenderable {
    /// Wraps content in a `<li>` element.
    func renderHTML(into output: inout String, renderer: HTMLRenderer) {
        renderer.tag("li", content: content, to: &output)
    }
}

/// Renders as a `<dl>` description list element.
extension DescriptionList: HTMLRenderable {
    /// Wraps content in a `<dl>` element.
    func renderHTML(into output: inout String, renderer: HTMLRenderer) {
        renderer.tag("dl", content: content, to: &output)
    }
}

/// Renders as a `<dt>` description term element.
extension DescriptionTerm: HTMLRenderable {
    /// Wraps content in a `<dt>` element.
    func renderHTML(into output: inout String, renderer: HTMLRenderer) {
        renderer.tag("dt", content: content, to: &output)
    }
}

/// Renders as a `<dd>` description details element.
extension DescriptionDetails: HTMLRenderable {
    /// Wraps content in a `<dd>` element.
    func renderHTML(into output: inout String, renderer: HTMLRenderer) {
        renderer.tag("dd", content: content, to: &output)
    }
}
