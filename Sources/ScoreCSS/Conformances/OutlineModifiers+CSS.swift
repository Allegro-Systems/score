import ScoreCore

/// Enables CSS emission for `OutlineModifier` modifiers.
extension OutlineModifier: CSSRepresentable {
    /// Converts this modifier into one or more CSS declarations.
    func cssDeclarations() -> [CSSDeclaration] {
        var result: [CSSDeclaration] = [
            .init(property: "outline", value: "\(CSSEmitter.px(width)) \(style.rawValue) \(color.cssValue)")
        ]
        if let v = offset { result.append(.init(property: "outline-offset", value: CSSEmitter.px(v))) }
        return result
    }
}
