import ScoreCore

/// Enables CSS collection for `UnorderedList` nodes.
extension UnorderedList: CSSWalkable {
    /// Walks into the list's child items.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Enables CSS collection for `OrderedList` nodes.
extension OrderedList: CSSWalkable {
    /// Walks into the list's child items.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Enables CSS collection for `ListItem` nodes.
extension ListItem: CSSWalkable {
    /// Walks into the list item's child content.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Enables CSS collection for `DescriptionList` nodes.
extension DescriptionList: CSSWalkable {
    /// Walks into the description list's term and details children.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Enables CSS collection for `DescriptionTerm` nodes.
extension DescriptionTerm: CSSWalkable {
    /// Walks into the description term's child content.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Enables CSS collection for `DescriptionDetails` nodes.
extension DescriptionDetails: CSSWalkable {
    /// Walks into the description details' child content.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}
