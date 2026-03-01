import ScoreCore

/// Enables CSS emission for `BackgroundModifier` modifiers.
extension BackgroundModifier: CSSRepresentable {
    /// Converts this modifier into one or more CSS declarations.
    func cssDeclarations() -> [CSSDeclaration] {
        [.init(property: "background-color", value: color.cssValue)]
    }
}

/// Enables CSS emission for `BackgroundImageModifier` modifiers.
extension BackgroundImageModifier: CSSRepresentable {
    /// Converts this modifier into one or more CSS declarations.
    func cssDeclarations() -> [CSSDeclaration] {
        var result: [CSSDeclaration] = []
        if let v = image { result.append(.init(property: "background-image", value: v)) }
        if let v = size { result.append(.init(property: "background-size", value: v)) }
        if let v = position { result.append(.init(property: "background-position", value: v)) }
        if let v = repeatMode { result.append(.init(property: "background-repeat", value: v.rawValue)) }
        if let v = clip { result.append(.init(property: "background-clip", value: v)) }
        return result
    }
}
