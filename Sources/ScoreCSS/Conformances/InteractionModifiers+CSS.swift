import ScoreCore

/// Enables CSS emission for `CursorModifier` modifiers.
extension CursorModifier: CSSRepresentable {
    /// Converts this modifier into one or more CSS declarations.
    func cssDeclarations() -> [CSSDeclaration] {
        [.init(property: "cursor", value: style.rawValue)]
    }
}

/// Enables CSS emission for `UserSelectModifier` modifiers.
extension UserSelectModifier: CSSRepresentable {
    /// Converts this modifier into one or more CSS declarations.
    func cssDeclarations() -> [CSSDeclaration] {
        [.init(property: "user-select", value: mode.rawValue)]
    }
}
