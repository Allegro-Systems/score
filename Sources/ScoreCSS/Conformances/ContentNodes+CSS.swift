import ScoreCore

/// Enables CSS collection for `Heading` nodes.
extension Heading: CSSWalkable {
    /// Walks into the heading's child content.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Enables CSS collection for `Paragraph` nodes.
extension Paragraph: CSSWalkable {
    /// Walks into the paragraph's child content.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Enables CSS collection for `Text` nodes.
extension Text: CSSWalkable {
    /// Walks into the text wrapper's child content.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Enables CSS collection for `Strong` nodes.
extension Strong: CSSWalkable {
    /// Walks into the strong element's child content.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Enables CSS collection for `Emphasis` nodes.
extension Emphasis: CSSWalkable {
    /// Walks into the emphasis element's child content.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Enables CSS collection for `Small` nodes.
extension Small: CSSWalkable {
    /// Walks into the small element's child content.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Enables CSS collection for `Mark` nodes.
extension Mark: CSSWalkable {
    /// Walks into the mark element's child content.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Enables CSS collection for `Code` nodes.
extension Code: CSSWalkable {
    /// Walks into the code element's child content.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Enables CSS collection for `Preformatted` nodes.
extension Preformatted: CSSWalkable {
    /// Walks into the preformatted element's child content.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Enables CSS collection for `Blockquote` nodes.
extension Blockquote: CSSWalkable {
    /// Walks into the blockquote's child content.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Enables CSS collection for `Address` nodes.
extension Address: CSSWalkable {
    /// Walks into the address element's child content.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Leaf node — `<hr>` has no children to walk.
extension HorizontalRule: CSSWalkable {
    /// No-op; `HorizontalRule` is a void element with no child nodes.
    func walkChildren(collector: inout CSSCollector) {}
}

/// Leaf node — `<br>` has no children to walk.
extension LineBreak: CSSWalkable {
    /// No-op; `LineBreak` is a void element with no child nodes.
    func walkChildren(collector: inout CSSCollector) {}
}
