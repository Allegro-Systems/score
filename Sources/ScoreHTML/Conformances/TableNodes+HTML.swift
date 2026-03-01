import ScoreCore

/// Renders as a `<table>` element.
extension Table: HTMLRenderable {
    /// Wraps content in a `<table>` element.
    func renderHTML(into output: inout String, renderer: HTMLRenderer) {
        renderer.tag("table", content: content, to: &output)
    }
}

/// Renders as a `<caption>` table title element.
extension TableCaption: HTMLRenderable {
    /// Wraps content in a `<caption>` element.
    func renderHTML(into output: inout String, renderer: HTMLRenderer) {
        renderer.tag("caption", content: content, to: &output)
    }
}

/// Renders as a `<thead>` table header group element.
extension TableHead: HTMLRenderable {
    /// Wraps content in a `<thead>` element.
    func renderHTML(into output: inout String, renderer: HTMLRenderer) {
        renderer.tag("thead", content: content, to: &output)
    }
}

/// Renders as a `<tbody>` table body group element.
extension TableBody: HTMLRenderable {
    /// Wraps content in a `<tbody>` element.
    func renderHTML(into output: inout String, renderer: HTMLRenderer) {
        renderer.tag("tbody", content: content, to: &output)
    }
}

/// Renders as a `<tfoot>` table footer group element.
extension TableFooter: HTMLRenderable {
    /// Wraps content in a `<tfoot>` element.
    func renderHTML(into output: inout String, renderer: HTMLRenderer) {
        renderer.tag("tfoot", content: content, to: &output)
    }
}

/// Renders as a `<tr>` table row element.
extension TableRow: HTMLRenderable {
    /// Wraps content in a `<tr>` element.
    func renderHTML(into output: inout String, renderer: HTMLRenderer) {
        renderer.tag("tr", content: content, to: &output)
    }
}

/// Renders as a `<th>` table header cell element.
extension TableHeaderCell: HTMLRenderable {
    /// Emits a `<th>` with an optional `scope` attribute for accessibility.
    func renderHTML(into output: inout String, renderer: HTMLRenderer) {
        var a: [(String, String)] = []
        if let v = scope { a.append(("scope", v.rawValue)) }
        renderer.tag("th", a, content: content, to: &output)
    }
}

/// Renders as a `<td>` table data cell element.
extension TableCell: HTMLRenderable {
    /// Wraps content in a `<td>` element.
    func renderHTML(into output: inout String, renderer: HTMLRenderer) {
        renderer.tag("td", content: content, to: &output)
    }
}

/// Renders as a `<colgroup>` column group element.
extension TableColumnGroup: HTMLRenderable {
    /// Emits a `<colgroup>` with an optional `span` attribute.
    func renderHTML(into output: inout String, renderer: HTMLRenderer) {
        var a: [(String, String)] = []
        if let v = span { a.append(("span", String(v))) }
        renderer.tag("colgroup", a, content: content, to: &output)
    }
}

/// Renders as the `<col>` void element defining a column within a `<colgroup>`.
extension TableColumn: HTMLRenderable {
    /// Emits a self-closing `<col>` with an optional `span` attribute.
    func renderHTML(into output: inout String, renderer: HTMLRenderer) {
        var a: [(String, String)] = []
        if let v = span { a.append(("span", String(v))) }
        renderer.voidTag("col", a, to: &output)
    }
}
