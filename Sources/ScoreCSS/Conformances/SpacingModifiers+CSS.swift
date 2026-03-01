import ScoreCore

/// Enables CSS emission for `PaddingModifier` modifiers.
extension PaddingModifier: CSSRepresentable {
    /// Converts this modifier into one or more CSS declarations.
    func cssDeclarations() -> [CSSDeclaration] {
        CSSEmitter.spacingDeclarations("padding", value: value, edges: edges)
    }
}

/// Enables CSS emission for `MarginModifier` modifiers.
extension MarginModifier: CSSRepresentable {
    /// Converts this modifier into one or more CSS declarations.
    func cssDeclarations() -> [CSSDeclaration] {
        CSSEmitter.spacingDeclarations("margin", value: value, edges: edges)
    }
}
