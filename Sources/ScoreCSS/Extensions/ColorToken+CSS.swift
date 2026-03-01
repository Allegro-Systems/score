import ScoreCore

extension ColorToken {

    /// Renders this color token as a CSS value string.
    ///
    /// Semantic tokens emit CSS custom property references (e.g. `var(--color-surface)`).
    /// Palette tokens emit shade-specific custom property references
    /// (e.g. `var(--color-blue-500)`). The `.oklch` case emits a literal
    /// `oklch()` function call. The `.custom` case emits a custom-property
    /// reference using the provided name and shade.
    ///
    /// ### Example
    ///
    /// ```swift
    /// ColorToken.surface.cssValue       // "var(--color-surface)"
    /// ColorToken.blue(500).cssValue     // "var(--color-blue-500)"
    /// ColorToken.oklch(0.65, 0.18, 270).cssValue  // "oklch(0.65 0.18 270)"
    /// ```
    ///
    /// - Returns: A CSS-compatible color value string.
    public var cssValue: String {
        switch self {
        case .surface: return "var(--color-surface)"
        case .text: return "var(--color-text)"
        case .border: return "var(--color-border)"
        case .accent: return "var(--color-accent)"
        case .muted: return "var(--color-muted)"
        case .destructive: return "var(--color-destructive)"
        case .success: return "var(--color-success)"
        case .neutral(let shade): return "var(--color-neutral-\(shade))"
        case .blue(let shade): return "var(--color-blue-\(shade))"
        case .red(let shade): return "var(--color-red-\(shade))"
        case .green(let shade): return "var(--color-green-\(shade))"
        case .amber(let shade): return "var(--color-amber-\(shade))"
        case .sky(let shade): return "var(--color-sky-\(shade))"
        case .slate(let shade): return "var(--color-slate-\(shade))"
        case .cyan(let shade): return "var(--color-cyan-\(shade))"
        case .emerald(let shade): return "var(--color-emerald-\(shade))"
        case .oklch(let l, let c, let h): return "oklch(\(l) \(c) \(h))"
        case .custom(let name, let shade): return "var(--color-\(name)-\(shade))"
        }
    }
}
