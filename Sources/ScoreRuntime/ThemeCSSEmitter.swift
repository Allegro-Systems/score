import ScoreCSS
import ScoreCore

/// Converts a ``Theme`` and its variants into CSS custom property declarations.
///
/// The emitter produces a `:root` block containing design-token custom
/// properties derived from the theme's color roles, font families, type
/// scale, spacing, and radius values. When the theme provides a `dark`
/// patch, a `@media (prefers-color-scheme: dark)` block is emitted.
/// Named theme variants produce `[data-theme="<name>"]` scoped blocks.
///
/// ### Example
///
/// ```swift
/// let css = ThemeCSSEmitter.emit(theme)
/// // :root {
/// //   --color-surface: oklch(0.99 0.0 0);
/// //   --font-sans: system-ui;
/// //   --type-scale-base: 16px;
/// //   --spacing-unit: 4px;
/// //   --radius-base: 4px;
/// // }
/// //
/// // [data-theme="ocean"] {
/// //   --color-accent: oklch(0.6 0.15 220);
/// // }
/// ```
public enum ThemeCSSEmitter: Sendable {

    /// Emits CSS custom properties for the given theme.
    ///
    /// - Parameter theme: The theme to convert to CSS custom properties.
    /// - Returns: A CSS string containing `:root` declarations, an optional
    ///   dark-mode `@media` block, and `[data-theme]` blocks for named variants.
    public static func emit(_ theme: some Theme) -> String {
        var output = ":root {\n"
        appendColorRoles(theme.colorRoles, to: &output)
        appendFontFamilies(theme.fontFamilies, to: &output)
        output.append("  --type-scale-base: \(theme.typeScaleBase.cssLength);\n")
        output.append("  --type-scale-ratio: \(theme.typeScaleRatio.trimmed);\n")
        output.append("  --spacing-unit: \(theme.spacingUnit.cssLength);\n")
        output.append("  --radius-base: \(theme.radiusBase.cssLength);\n")
        output.append("}\n")

        if let dark = theme.dark {
            output.append("@media (prefers-color-scheme: dark) {\n")
            output.append("  :root {\n")
            appendPatch(dark, to: &output, indent: "    ")
            output.append("  }\n")
            output.append("}\n")
        }

        for name in theme.named.keys.sorted() {
            guard let patch = theme.named[name] else { continue }
            output.append("[data-theme=\"\(name)\"] {\n")
            appendPatch(patch, to: &output, indent: "  ")
            output.append("}\n")
        }

        return output
    }

    private static func appendPatch(
        _ patch: some ThemePatch,
        to output: inout String,
        indent: String
    ) {
        if let roles = patch.colorRoles {
            appendColorRoles(roles, to: &output, indent: indent)
        }
        if let fonts = patch.fontFamilies {
            appendFontFamilies(fonts, to: &output, indent: indent)
        }
        if let base = patch.typeScaleBase {
            output.append("\(indent)--type-scale-base: \(base.cssLength);\n")
        }
        if let ratio = patch.typeScaleRatio {
            output.append("\(indent)--type-scale-ratio: \(ratio.trimmed);\n")
        }
        if let spacing = patch.spacingUnit {
            output.append("\(indent)--spacing-unit: \(spacing.cssLength);\n")
        }
        if let radius = patch.radiusBase {
            output.append("\(indent)--radius-base: \(radius.cssLength);\n")
        }
    }

    private static func appendColorRoles(
        _ roles: [String: ColorToken],
        to output: inout String,
        indent: String = "  "
    ) {
        for key in roles.keys.sorted() {
            guard let token = roles[key] else { continue }
            output.append("\(indent)--color-\(key): \(token.resolvedCSSValue);\n")
        }
    }

    private static func appendFontFamilies(
        _ families: [String: String],
        to output: inout String,
        indent: String = "  "
    ) {
        for key in families.keys.sorted() {
            guard let value = families[key] else { continue }
            output.append("\(indent)--font-\(key): \(value);\n")
        }
    }
}

extension ColorToken {

    /// Resolves the token to a concrete CSS color value for theme emission.
    ///
    /// Unlike ``cssValue`` which emits `var()` references for semantic tokens,
    /// this property emits the literal value suitable for defining the custom
    /// property itself.
    var resolvedCSSValue: String {
        switch self {
        case .oklch(let l, let c, let h):
            return "oklch(\(l) \(c) \(h))"
        case .neutral(let s): return "var(--color-neutral-\(s))"
        case .blue(let s): return "var(--color-blue-\(s))"
        case .red(let s): return "var(--color-red-\(s))"
        case .green(let s): return "var(--color-green-\(s))"
        case .amber(let s): return "var(--color-amber-\(s))"
        case .sky(let s): return "var(--color-sky-\(s))"
        case .slate(let s): return "var(--color-slate-\(s))"
        case .cyan(let s): return "var(--color-cyan-\(s))"
        case .emerald(let s): return "var(--color-emerald-\(s))"
        case .custom(let name, let shade): return "var(--color-\(name)-\(shade))"
        case .surface: return "var(--color-surface)"
        case .text: return "var(--color-text)"
        case .border: return "var(--color-border)"
        case .accent: return "var(--color-accent)"
        case .muted: return "var(--color-muted)"
        case .destructive: return "var(--color-destructive)"
        case .success: return "var(--color-success)"
        }
    }
}

extension Double {

    fileprivate var cssLength: String {
        "\(trimmed)px"
    }

    fileprivate var trimmed: String {
        truncatingRemainder(dividingBy: 1) == 0
            ? String(format: "%.0f", self)
            : String(self)
    }
}
