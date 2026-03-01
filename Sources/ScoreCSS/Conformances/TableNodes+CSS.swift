import ScoreCore

/// Enables CSS collection for `Table` nodes.
extension Table: CSSWalkable {
    /// Walks into the table's child content.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Enables CSS collection for `TableCaption` nodes.
extension TableCaption: CSSWalkable {
    /// Walks into the caption's child content.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Enables CSS collection for `TableHead` nodes.
extension TableHead: CSSWalkable {
    /// Walks into the table head's child rows.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Enables CSS collection for `TableBody` nodes.
extension TableBody: CSSWalkable {
    /// Walks into the table body's child rows.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Enables CSS collection for `TableFooter` nodes.
extension TableFooter: CSSWalkable {
    /// Walks into the table footer's child rows.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Enables CSS collection for `TableRow` nodes.
extension TableRow: CSSWalkable {
    /// Walks into the row's child cells.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Enables CSS collection for `TableHeaderCell` nodes.
extension TableHeaderCell: CSSWalkable {
    /// Walks into the header cell's child content.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Enables CSS collection for `TableCell` nodes.
extension TableCell: CSSWalkable {
    /// Walks into the data cell's child content.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Enables CSS collection for `TableColumnGroup` nodes.
extension TableColumnGroup: CSSWalkable {
    /// Walks into the column group's child `<col>` nodes.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Leaf node — `<col>` is a void element with no children.
extension TableColumn: CSSWalkable {
    /// No-op; `TableColumn` is a void element with no child nodes.
    func walkChildren(collector: inout CSSCollector) {}
}
