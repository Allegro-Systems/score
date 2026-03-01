import ScoreCore

/// Enables CSS collection for `Stack` nodes.
extension Stack: CSSWalkable {
    /// Walks into the stack's child content.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Enables CSS collection for `Main` nodes.
extension Main: CSSWalkable {
    /// Walks into the main element's child content.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Enables CSS collection for `Section` nodes.
extension Section: CSSWalkable {
    /// Walks into the section's child content.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Enables CSS collection for `Article` nodes.
extension Article: CSSWalkable {
    /// Walks into the article's child content.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Enables CSS collection for `Header` nodes.
extension Header: CSSWalkable {
    /// Walks into the header's child content.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Enables CSS collection for `Footer` nodes.
extension Footer: CSSWalkable {
    /// Walks into the footer's child content.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Enables CSS collection for `Aside` nodes.
extension Aside: CSSWalkable {
    /// Walks into the aside's child content.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Enables CSS collection for `Navigation` nodes.
extension Navigation: CSSWalkable {
    /// Walks into the navigation's child content.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Enables CSS collection for `Group` nodes.
extension Group: CSSWalkable {
    /// Walks into the group's child content.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}
