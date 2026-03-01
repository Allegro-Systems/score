import ScoreCore

/// Leaf node — `<img>` is a void element with no children.
extension Image: CSSWalkable {
    /// No-op; `Image` is a void element with no child nodes.
    func walkChildren(collector: inout CSSCollector) {}
}

/// Enables CSS collection for `Figure` nodes.
extension Figure: CSSWalkable {
    /// Walks into the figure's child content.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Enables CSS collection for `FigureCaption` nodes.
extension FigureCaption: CSSWalkable {
    /// Walks into the figcaption's child content.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Leaf node — `<source>` is a void element with no children.
extension Source: CSSWalkable {
    /// No-op; `Source` is a void element with no child nodes.
    func walkChildren(collector: inout CSSCollector) {}
}

/// Leaf node — `<track>` is a void element with no children.
extension Track: CSSWalkable {
    /// No-op; `Track` is a void element with no child nodes.
    func walkChildren(collector: inout CSSCollector) {}
}

/// Enables CSS collection for `Audio` nodes.
extension Audio: CSSWalkable {
    /// Walks into the audio element's child source and track nodes.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Enables CSS collection for `Video` nodes.
extension Video: CSSWalkable {
    /// Walks into the video element's child source and track nodes.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Enables CSS collection for `Picture` nodes.
extension Picture: CSSWalkable {
    /// Walks into the picture element's child source and image nodes.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}

/// Enables CSS collection for `Canvas` nodes.
extension Canvas: CSSWalkable {
    /// Walks into the canvas element's fallback child content.
    func walkChildren(collector: inout CSSCollector) { collector.collect(from: content) }
}
