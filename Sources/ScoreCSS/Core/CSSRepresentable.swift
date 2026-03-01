import ScoreCore

/// A modifier value that can produce its own CSS declarations.
///
/// Types conforming to `CSSRepresentable` are dispatched directly by
/// `CSSEmitter` without a central switch statement. All built-in Score
/// modifier types adopt this protocol via extensions in the ScoreCSS module.
///
/// Conformances are added retroactively in `Sources/ScoreCSS/Conformances/`
/// so that ScoreCore remains free of any rendering dependencies.
protocol CSSRepresentable {
    func cssDeclarations() -> [CSSDeclaration]
}
