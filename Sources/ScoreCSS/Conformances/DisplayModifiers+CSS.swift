import ScoreCore

/// Enables CSS emission for `DisplayModifier` modifiers.
extension DisplayModifier: CSSRepresentable {
    /// Converts this modifier into one or more CSS declarations.
    func cssDeclarations() -> [CSSDeclaration] {
        [.init(property: "display", value: mode.rawValue)]
    }
}

/// Enables CSS emission for `OverflowModifier` modifiers.
extension OverflowModifier: CSSRepresentable {
    /// Converts this modifier into one or more CSS declarations.
    func cssDeclarations() -> [CSSDeclaration] {
        var result: [CSSDeclaration] = []
        if let x { result.append(.init(property: "overflow-x", value: x.rawValue)) }
        if let y { result.append(.init(property: "overflow-y", value: y.rawValue)) }
        return result
    }
}
