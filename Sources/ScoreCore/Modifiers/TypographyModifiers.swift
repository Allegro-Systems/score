/// The horizontal alignment of text within its container.
///
/// `TextAlign` controls the inline axis alignment of text content, mapping
/// directly to the CSS `text-align` property values.
///
/// ### CSS Mapping
///
/// Maps to the CSS `text-align` property.
public enum TextAlign: String, Sendable {
    /// Text is aligned to the start edge of the container, respecting writing direction.
    ///
    /// CSS equivalent: `text-align: start`.
    case start

    /// Text is centered horizontally within the container.
    ///
    /// CSS equivalent: `text-align: center`.
    case center

    /// Text is aligned to the end edge of the container, respecting writing direction.
    ///
    /// CSS equivalent: `text-align: end`.
    case end

    /// Text is stretched to fill the full line width, creating even left and right edges.
    ///
    /// CSS equivalent: `text-align: justify`.
    case justify
}

/// A transformation applied to text characters before rendering.
///
/// `TextTransform` allows text to be visually converted to uppercase, lowercase,
/// or title case without altering the underlying string value.
///
/// ### CSS Mapping
///
/// Maps to the CSS `text-transform` property.
public enum TextTransform: String, Sendable {
    /// No transformation is applied; text renders as-is.
    ///
    /// CSS equivalent: `text-transform: none`.
    case none

    /// All characters are converted to uppercase.
    ///
    /// CSS equivalent: `text-transform: uppercase`.
    case uppercase

    /// All characters are converted to lowercase.
    ///
    /// CSS equivalent: `text-transform: lowercase`.
    case lowercase

    /// The first character of each word is converted to uppercase.
    ///
    /// CSS equivalent: `text-transform: capitalize`.
    case capitalize
}

/// A decorative line applied to text content.
///
/// `TextDecoration` is used to draw attention to or de-emphasize text through
/// visual line decorations such as underlines or strikethroughs.
///
/// ### CSS Mapping
///
/// Maps to the CSS `text-decoration` property.
public enum TextDecoration: String, Sendable {
    /// No decoration is applied.
    ///
    /// CSS equivalent: `text-decoration: none`.
    case none

    /// A line is drawn beneath the text.
    ///
    /// CSS equivalent: `text-decoration: underline`.
    case underline

    /// A line is drawn through the middle of the text.
    ///
    /// CSS equivalent: `text-decoration: line-through`.
    case lineThrough = "line-through"

    /// A line is drawn above the text.
    ///
    /// CSS equivalent: `text-decoration: overline`.
    case overline
}

/// The wrapping behavior applied to text that exceeds its container's width.
///
/// `TextWrap` provides control over how the browser breaks text into multiple
/// lines when it overflows its layout boundary.
///
/// ### CSS Mapping
///
/// Maps to the CSS `text-wrap` property.
public enum TextWrap: String, Sendable {
    /// Text wraps onto new lines when it reaches the container boundary.
    ///
    /// CSS equivalent: `text-wrap: wrap`.
    case wrap

    /// Text does not wrap; it continues on a single line, potentially overflowing.
    ///
    /// CSS equivalent: `text-wrap: nowrap`.
    case nowrap

    /// The browser balances line lengths for improved readability in multi-line blocks.
    ///
    /// CSS equivalent: `text-wrap: balance`.
    case balance

    /// The browser uses a finer algorithm to avoid orphans and improve overall text appearance.
    ///
    /// CSS equivalent: `text-wrap: pretty`.
    case pretty
}

/// Controls how white space and line breaks within an element are handled.
///
/// `WhiteSpace` determines whether the browser collapses sequences of whitespace,
/// wraps lines, and preserves explicit newlines in the source text.
///
/// ### CSS Mapping
///
/// Maps to the CSS `white-space` property.
public enum WhiteSpace: String, Sendable {
    /// Whitespace is collapsed and lines wrap at the container boundary.
    ///
    /// CSS equivalent: `white-space: normal`.
    case normal

    /// Whitespace is collapsed but lines do not wrap.
    ///
    /// CSS equivalent: `white-space: nowrap`.
    case nowrap

    /// Whitespace and newlines are preserved; lines do not wrap automatically.
    ///
    /// CSS equivalent: `white-space: pre`.
    case pre

    /// Whitespace and newlines are preserved; lines wrap at the container boundary.
    ///
    /// CSS equivalent: `white-space: pre-wrap`.
    case preWrap = "pre-wrap"

    /// Whitespace is collapsed; newlines in the source cause line breaks.
    ///
    /// CSS equivalent: `white-space: pre-line`.
    case preLine = "pre-line"

    /// Like `preWrap`, but the browser may also break at preserved whitespace characters.
    ///
    /// CSS equivalent: `white-space: break-spaces`.
    case breakSpaces = "break-spaces"
}

/// How overflowing text is visually indicated when it cannot fit in its container.
///
/// `TextOverflow` is used in conjunction with `white-space: nowrap` and
/// `overflow: hidden` to clip or truncate text that is too long to display.
///
/// ### CSS Mapping
///
/// Maps to the CSS `text-overflow` property.
public enum TextOverflow: String, Sendable {
    /// Overflowing text is clipped at the container's edge with no indicator.
    ///
    /// CSS equivalent: `text-overflow: clip`.
    case clip

    /// Overflowing text is truncated and an ellipsis (`...`) is appended.
    ///
    /// CSS equivalent: `text-overflow: ellipsis`.
    case ellipsis
}

/// How the browser handles line-break opportunities for text that overflows its container.
///
/// `OverflowWrap` allows long words or unbreakable strings to be split across
/// lines to prevent content from overflowing its container.
///
/// ### CSS Mapping
///
/// Maps to the CSS `overflow-wrap` property.
public enum OverflowWrap: String, Sendable {
    /// Lines may only break at permitted break points (e.g., spaces and hyphens).
    ///
    /// CSS equivalent: `overflow-wrap: normal`.
    case normal

    /// Lines may break mid-word to prevent overflow, as a last resort.
    ///
    /// CSS equivalent: `overflow-wrap: break-word`.
    case breakWord = "break-word"

    /// Lines may break at any character to prevent overflow, adjusting min-content sizing.
    ///
    /// CSS equivalent: `overflow-wrap: anywhere`.
    case anywhere
}

/// Controls how line breaks occur within words.
///
/// `WordBreak` provides fine-grained control over where the browser is permitted
/// to break words when wrapping text, especially for CJK and non-Latin scripts.
///
/// ### CSS Mapping
///
/// Maps to the CSS `word-break` property.
public enum WordBreak: String, Sendable {
    /// The default behavior; breaks only at allowed break points.
    ///
    /// CSS equivalent: `word-break: normal`.
    case normal

    /// Allows breaks between any two characters, including mid-word.
    ///
    /// CSS equivalent: `word-break: break-all`.
    case breakAll = "break-all"

    /// Prevents word breaks for CJK text; non-CJK text behaves like `normal`.
    ///
    /// CSS equivalent: `word-break: keep-all`.
    case keepAll = "keep-all"

    /// Allows breaks mid-word to prevent overflow; deprecated in favor of `overflow-wrap`.
    ///
    /// CSS equivalent: `word-break: break-word`.
    case breakWord = "break-word"
}

/// Controls whether the browser automatically inserts hyphens at line breaks.
///
/// `Hyphens` determines how hyphenation is applied when text wraps to a new line,
/// improving readability for justified or narrow text columns.
///
/// ### CSS Mapping
///
/// Maps to the CSS `hyphens` property.
public enum Hyphens: String, Sendable {
    /// Words are not hyphenated, even where hyphenation characters exist.
    ///
    /// CSS equivalent: `hyphens: none`.
    case none

    /// Words are only hyphenated where a soft hyphen (`&shy;`) is present in the source.
    ///
    /// CSS equivalent: `hyphens: manual`.
    case manual

    /// The browser automatically inserts hyphens at appropriate points when wrapping.
    ///
    /// CSS equivalent: `hyphens: auto`.
    case auto
}

/// A modifier that applies comprehensive text styling properties to a node.
///
/// `TextStyleModifier` consolidates text alignment, transformation, decoration,
/// wrapping, white-space handling, overflow behavior, word breaking, hyphenation,
/// line clamping, and indentation into a single modifier. All properties are
/// optional; only the values you provide will be applied.
///
/// ### Example
///
/// ```swift
/// Paragraph()
///     .textStyle(align: .justify, wrap: .pretty, hyphens: .auto)
///
/// TruncatedLabel()
///     .textStyle(overflow: .ellipsis, wordBreak: .breakAll, lineClamp: 2)
/// ```
///
/// ### CSS Mapping
///
/// Maps to the CSS `text-align`, `text-transform`, `text-decoration`, `text-wrap`,
/// `white-space`, `text-overflow`, `overflow-wrap`, `word-break`, `hyphens`,
/// `-webkit-line-clamp`, and `text-indent` properties on the rendered element.
public struct TextStyleModifier: ModifierValue {
    /// The horizontal alignment of the text.
    ///
    /// When `nil`, alignment is inherited from the parent node.
    public let align: TextAlign?

    /// The case transformation applied to the text.
    ///
    /// When `nil`, no transformation is applied.
    public let transform: TextTransform?

    /// The decorative line applied to the text.
    ///
    /// When `nil`, no decoration is applied.
    public let decoration: TextDecoration?

    /// The line-wrapping behavior of the text.
    ///
    /// When `nil`, wrapping behavior is inherited from the parent node.
    public let wrap: TextWrap?

    /// How whitespace and explicit newlines in the source are handled.
    ///
    /// When `nil`, white-space behavior is inherited from the parent node.
    public let whiteSpace: WhiteSpace?

    /// How overflowing text is visually truncated.
    ///
    /// When `nil`, overflow behavior is inherited from the parent node.
    public let overflow: TextOverflow?

    /// How the browser handles break opportunities for long words.
    ///
    /// When `nil`, overflow-wrap is inherited from the parent node.
    public let overflowWrap: OverflowWrap?

    /// Controls where line breaks may occur within words.
    ///
    /// When `nil`, word-break behavior is inherited from the parent node.
    public let wordBreak: WordBreak?

    /// Controls automatic hyphenation at line breaks.
    ///
    /// When `nil`, hyphenation behavior is inherited from the parent node.
    public let hyphens: Hyphens?

    /// The maximum number of lines to display before clamping with an ellipsis.
    ///
    /// When `nil`, no line clamping is applied.
    public let lineClamp: Int?

    /// The indentation of the first line of text in points.
    ///
    /// When `nil`, no indentation is applied.
    public let indent: Double?

    /// Creates a text style modifier.
    ///
    /// - Parameters:
    ///   - align: Optional horizontal text alignment.
    ///   - transform: Optional text case transformation.
    ///   - decoration: Optional decorative line applied to the text.
    ///   - wrap: Optional line-wrapping behavior.
    ///   - whiteSpace: Optional white-space handling mode.
    ///   - overflow: Optional text overflow handling.
    ///   - overflowWrap: Optional overflow-wrap mode for long words.
    ///   - wordBreak: Optional word-break mode.
    ///   - hyphens: Optional hyphenation mode.
    ///   - lineClamp: Optional maximum number of visible lines.
    ///   - indent: Optional first-line indentation in points.
    public init(
        align: TextAlign? = nil,
        transform: TextTransform? = nil,
        decoration: TextDecoration? = nil,
        wrap: TextWrap? = nil,
        whiteSpace: WhiteSpace? = nil,
        overflow: TextOverflow? = nil,
        overflowWrap: OverflowWrap? = nil,
        wordBreak: WordBreak? = nil,
        hyphens: Hyphens? = nil,
        lineClamp: Int? = nil,
        indent: Double? = nil
    ) {
        self.align = align
        self.transform = transform
        self.decoration = decoration
        self.wrap = wrap
        self.whiteSpace = whiteSpace
        self.overflow = overflow
        self.overflowWrap = overflowWrap
        self.wordBreak = wordBreak
        self.hyphens = hyphens
        self.lineClamp = lineClamp
        self.indent = indent
    }
}

/// A modifier that configures typographic properties of a node's text.
///
/// `FontModifier` consolidates font family, size, weight, letter spacing, line height,
/// and text color into a single modifier. All properties are optional; only the values
/// you provide are applied, leaving others at their inherited or default values.
///
/// ### Example
///
/// ```swift
/// Text("Headline")
///     .font(.sans, size: 24, weight: .bold, color: .primary)
///
/// CodeBlock()
///     .font(.mono, size: 13, weight: .regular)
/// ```
///
/// ### CSS Mapping
///
/// Maps to the CSS `font-family`, `font-size`, `font-weight`, `letter-spacing`,
/// `line-height`, and `color` properties on the rendered element.
public struct FontModifier: ModifierValue {
    /// The font family to use.
    ///
    /// When `nil`, the font family is inherited from the parent node.
    public let family: FontFamily?

    /// The font size in points.
    ///
    /// When `nil`, the font size is inherited from the parent node.
    public let size: Double?

    /// The font weight.
    ///
    /// When `nil`, the font weight is inherited from the parent node.
    public let weight: FontWeight?

    /// The letter spacing (tracking) in points.
    ///
    /// When `nil`, the tracking is inherited from the parent node.
    public let tracking: Double?

    /// The line height as a unitless multiplier or point value.
    ///
    /// When `nil`, the line height is inherited from the parent node.
    public let lineHeight: Double?

    /// The text color applied using a design token.
    ///
    /// When `nil`, the color is inherited from the parent node.
    public let color: ColorToken?

    /// Creates a font modifier with the given typographic properties.
    ///
    /// - Parameters:
    ///   - family: Optional font family. Defaults to `nil` (inherited).
    ///   - size: Optional font size in points.
    ///   - weight: Optional font weight.
    ///   - tracking: Optional letter spacing in points.
    ///   - lineHeight: Optional line height.
    ///   - color: Optional text color as a design token.
    public init(
        _ family: FontFamily? = nil,
        size: Double? = nil,
        weight: FontWeight? = nil,
        tracking: Double? = nil,
        lineHeight: Double? = nil,
        color: ColorToken? = nil
    ) {
        self.family = family
        self.size = size
        self.weight = weight
        self.tracking = tracking
        self.lineHeight = lineHeight
        self.color = color
    }
}

/// The typeface family used to render text within a node.
///
/// `FontFamily` provides semantic aliases for the most common typeface categories
/// as well as a `.custom` case for arbitrary font stacks.
///
/// ### CSS Mapping
///
/// Maps to the CSS `font-family` property. Each case resolves to a design-system
/// font-stack variable or a literal font-family value.
public indirect enum FontFamily: Sendable {
    /// The operating system's default UI font.
    ///
    /// CSS equivalent: typically `system-ui, -apple-system, sans-serif`.
    case system

    /// A sans-serif typeface from the design system's token set.
    ///
    /// CSS equivalent: the design system's sans-serif font-stack variable.
    case sans

    /// A monospaced typeface, suitable for code or tabular data.
    ///
    /// CSS equivalent: the design system's monospace font-stack variable.
    case mono

    /// A serif typeface from the design system's token set.
    ///
    /// CSS equivalent: the design system's serif font-stack variable.
    case serif

    /// The product's brand typeface as defined by the design system.
    ///
    /// CSS equivalent: the design system's brand font-stack variable.
    case brand

    /// A custom font family specified by name, with a fallback family.
    ///
    /// CSS equivalent: `font-family: "CustomName", <fallback>`.
    ///
    /// - Parameters:
    ///   - fontName: The exact name of the custom font.
    ///   - fallback: The `FontFamily` to use if the custom font is unavailable.
    case custom(String, fallback: FontFamily)
}

/// The weight (thickness) of a font's strokes.
///
/// `FontWeight` maps to standard CSS numeric weight values through semantic names,
/// making it easy to apply consistent typographic hierarchy.
///
/// ### CSS Mapping
///
/// Maps to the CSS `font-weight` property.
public enum FontWeight: String, Sendable {
    /// An extremely light stroke weight.
    ///
    /// CSS equivalent: `font-weight: 100`.
    case thin

    /// A light stroke weight, slightly heavier than thin.
    ///
    /// CSS equivalent: `font-weight: 300`.
    case light

    /// The standard, regular stroke weight.
    ///
    /// CSS equivalent: `font-weight: 400`.
    case regular

    /// A medium stroke weight, slightly heavier than regular.
    ///
    /// CSS equivalent: `font-weight: 500`.
    case medium

    /// A semibold stroke weight, between medium and bold.
    ///
    /// CSS equivalent: `font-weight: 600`.
    case semibold

    /// A bold stroke weight, commonly used for emphasis.
    ///
    /// CSS equivalent: `font-weight: 700`.
    case bold

    /// The heaviest stroke weight.
    ///
    /// CSS equivalent: `font-weight: 900`.
    case black
}

extension Node {
    /// Applies comprehensive text styling to this node's text content.
    ///
    /// All parameters are optional; provide only the properties you need to override.
    /// Unspecified properties continue to inherit from the node's parent.
    ///
    /// ### Example
    ///
    /// ```swift
    /// Paragraph()
    ///     .textStyle(align: .justify, wrap: .pretty, hyphens: .auto)
    ///
    /// SingleLineLabel()
    ///     .textStyle(overflow: .ellipsis, whiteSpace: .nowrap, lineClamp: 1)
    /// ```
    ///
    /// ### CSS Mapping
    ///
    /// Maps to the CSS `text-align`, `text-transform`, `text-decoration`, `text-wrap`,
    /// `white-space`, `text-overflow`, `overflow-wrap`, `word-break`, `hyphens`,
    /// `-webkit-line-clamp`, and `text-indent` properties on the rendered element.
    ///
    /// - Parameters:
    ///   - align: Optional horizontal text alignment.
    ///   - transform: Optional text case transformation.
    ///   - decoration: Optional decorative line.
    ///   - wrap: Optional line-wrapping behavior.
    ///   - whiteSpace: Optional white-space handling mode.
    ///   - overflow: Optional text overflow handling.
    ///   - overflowWrap: Optional overflow-wrap mode for long words.
    ///   - wordBreak: Optional word-break mode.
    ///   - hyphens: Optional hyphenation mode.
    ///   - lineClamp: Optional maximum number of visible lines.
    ///   - indent: Optional first-line indentation in points.
    /// - Returns: A `ModifiedNode` with the text style modifier applied.
    public func textStyle(
        align: TextAlign? = nil,
        transform: TextTransform? = nil,
        decoration: TextDecoration? = nil,
        wrap: TextWrap? = nil,
        whiteSpace: WhiteSpace? = nil,
        overflow: TextOverflow? = nil,
        overflowWrap: OverflowWrap? = nil,
        wordBreak: WordBreak? = nil,
        hyphens: Hyphens? = nil,
        lineClamp: Int? = nil,
        indent: Double? = nil
    ) -> ModifiedNode<Self> {
        let mod = TextStyleModifier(
            align: align,
            transform: transform,
            decoration: decoration,
            wrap: wrap,
            whiteSpace: whiteSpace,
            overflow: overflow,
            overflowWrap: overflowWrap,
            wordBreak: wordBreak,
            hyphens: hyphens,
            lineClamp: lineClamp,
            indent: indent
        )
        return ModifiedNode(content: self, modifiers: [mod])
    }

    /// Applies typographic styling to this node's text content.
    ///
    /// All parameters are optional; provide only the values you need to override.
    /// Unspecified properties continue to inherit from the node's parent.
    ///
    /// ### Example
    ///
    /// ```swift
    /// Text("Headline")
    ///     .font(.sans, size: 32, weight: .bold, color: .primary)
    ///
    /// Caption()
    ///     .font(size: 11, weight: .regular, tracking: 0.4, color: .secondary)
    /// ```
    ///
    /// ### CSS Mapping
    ///
    /// Maps to the CSS `font-family`, `font-size`, `font-weight`, `letter-spacing`,
    /// `line-height`, and `color` properties on the rendered element.
    ///
    /// - Parameters:
    ///   - family: Optional font family. Defaults to `nil` (inherited).
    ///   - size: Optional font size in points.
    ///   - weight: Optional font weight.
    ///   - tracking: Optional letter spacing in points.
    ///   - lineHeight: Optional line height.
    ///   - color: Optional text color as a design token.
    /// - Returns: A `ModifiedNode` with the font modifier applied.
    public func font(
        _ family: FontFamily? = nil,
        size: Double? = nil,
        weight: FontWeight? = nil,
        tracking: Double? = nil,
        lineHeight: Double? = nil,
        color: ColorToken? = nil
    ) -> ModifiedNode<Self> {
        let mod = FontModifier(
            family,
            size: size,
            weight: weight,
            tracking: tracking,
            lineHeight: lineHeight,
            color: color
        )
        return ModifiedNode(content: self, modifiers: [mod])
    }
}
