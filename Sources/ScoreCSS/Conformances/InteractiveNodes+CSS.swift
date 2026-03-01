import ScoreCore

/// Enables CSS collection for `Link` nodes.
extension Link: CSSWalkable {
    /// Walks into the link's child content.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Enables CSS collection for `Dialog` nodes.
extension Dialog: CSSWalkable {
    /// Walks into the dialog's child content.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Enables CSS collection for `Menu` nodes.
extension Menu: CSSWalkable {
    /// Walks into the menu's child content.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Enables CSS collection for `Summary` nodes.
extension Summary: CSSWalkable {
    /// Walks into the summary's child content.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Enables CSS collection for `Details` nodes, covering both the summary and body.
extension Details: CSSWalkable {
    /// Walks both the `summary` node and the body `content`.
    func walkChildren(collector: inout CSSCollector) {
        collector.collect(from: summary)
        collector.collect(from: content)
    }
}
