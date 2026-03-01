import ScoreCore

/// Renders as an `<a>` anchor element.
extension Link: HTMLRenderable {
    /// Emits an `<a href="…">` element pointing to `destination`.
    func renderHTML(into output: inout String, renderer: HTMLRenderer) {
        renderer.tag("a", [("href", destination)], content: content, to: &output)
    }
}

/// Renders as a `<dialog>` modal or non-modal dialog element.
extension Dialog: HTMLRenderable {
    /// Emits a `<dialog>` with an optional `open` attribute when the dialog is shown.
    func renderHTML(into output: inout String, renderer: HTMLRenderer) {
        var a: [(String, String)] = []
        if isOpen { a.append(("open", "")) }
        renderer.tag("dialog", a, content: content, to: &output)
    }
}

/// Renders as a `<menu>` context or toolbar menu element.
extension Menu: HTMLRenderable {
    /// Wraps content in a `<menu>` element.
    func renderHTML(into output: inout String, renderer: HTMLRenderer) {
        renderer.tag("menu", content: content, to: &output)
    }
}

/// Renders as a `<summary>` disclosure heading inside a `<details>` element.
extension Summary: HTMLRenderable {
    /// Wraps content in a `<summary>` element.
    func renderHTML(into output: inout String, renderer: HTMLRenderer) {
        renderer.tag("summary", content: content, to: &output)
    }
}

/// Renders as a `<details>` disclosure widget, placing `summary` before the body content.
extension Details: HTMLRenderable {
    /// Emits `<details>` with an optional `open` attribute, a `<summary>` child, then the body content.
    func renderHTML(into output: inout String, renderer: HTMLRenderer) {
        var a: [(String, String)] = []
        if isOpen { a.append(("open", "")) }
        output.append("<details")
        renderer.writeAttributes(a, to: &output)
        output.append(">")
        renderer.write(summary, to: &output)
        renderer.write(content, to: &output)
        output.append("</details>")
    }
}
