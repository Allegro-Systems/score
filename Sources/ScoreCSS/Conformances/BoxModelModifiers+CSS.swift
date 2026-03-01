import ScoreCore

/// Enables CSS emission for `BoxSizingModifier` modifiers.
extension BoxSizingModifier: CSSRepresentable {
    /// Converts this modifier into one or more CSS declarations.
    func cssDeclarations() -> [CSSDeclaration] {
        [.init(property: "box-sizing", value: value.rawValue)]
    }
}
