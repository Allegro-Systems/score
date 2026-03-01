import ScoreCore

/// Enables CSS emission for `TransformModifier` modifiers.
extension TransformModifier: CSSRepresentable {
    /// Converts this modifier into one or more CSS declarations.
    func cssDeclarations() -> [CSSDeclaration] {
        [.init(property: "transform", value: value)]
    }
}

/// Enables CSS emission for `TransitionModifier` modifiers.
extension TransitionModifier: CSSRepresentable {
    /// Converts this modifier into one or more CSS declarations.
    func cssDeclarations() -> [CSSDeclaration] {
        var result: [CSSDeclaration] = [
            .init(property: "transition-property", value: property),
            .init(property: "transition-duration", value: CSSEmitter.seconds(duration)),
        ]
        if let v = timing { result.append(.init(property: "transition-timing-function", value: v)) }
        if let v = delay { result.append(.init(property: "transition-delay", value: CSSEmitter.seconds(v))) }
        return result
    }
}

/// Enables CSS emission for `AnimationModifier` modifiers.
extension AnimationModifier: CSSRepresentable {
    /// Converts this modifier into one or more CSS declarations.
    func cssDeclarations() -> [CSSDeclaration] {
        var parts = [name, CSSEmitter.seconds(duration)]
        if let v = timing { parts.append(v) }
        if let v = delay { parts.append(CSSEmitter.seconds(v)) }
        if let v = iterationCount { parts.append(v) }
        if let v = direction { parts.append(v) }
        if let v = fillMode { parts.append(v) }
        return [.init(property: "animation", value: parts.joined(separator: " "))]
    }
}
