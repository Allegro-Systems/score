/// A modifier that applies a CSS filter effect to a node.
///
/// `FilterModifier` accepts a raw CSS filter string, giving full access to all
/// CSS filter functions such as `blur()`, `brightness()`, `contrast()`,
/// `grayscale()`, `hue-rotate()`, `invert()`, `saturate()`, `sepia()`, and
/// `drop-shadow()`. Multiple filter functions can be chained in a single string.
///
/// ### Example
///
/// ```swift
/// Image("photo")
///     .filter("grayscale(100%)")
///
/// Image("logo")
///     .filter("blur(4px) brightness(0.8)")
/// ```
///
/// ### CSS Mapping
///
/// Maps to the CSS `filter` property on the rendered element.
public struct FilterModifier: ModifierValue {
    /// The raw CSS filter string, such as `"grayscale(1)"` or `"blur(4px) contrast(110%)"`.
    public let value: String

    /// Creates a filter modifier with the given CSS filter string.
    ///
    /// - Parameter value: A CSS filter function string (e.g., `"blur(4px)"`, `"grayscale(100%) brightness(0.9)"`).
    public init(_ value: String) {
        self.value = value
    }
}

/// A modifier that applies a CSS backdrop filter to a node.
///
/// `BackdropFilterModifier` applies filter effects to the area behind a node,
/// creating frosted-glass and similar effects. The node itself must have some
/// degree of transparency for the backdrop filter to be visible.
///
/// Common values include `blur()`, `brightness()`, `contrast()`, and `saturate()`.
///
/// ### Example
///
/// ```swift
/// Panel()
///     .backdropFilter("blur(12px) brightness(0.9)")
///     .opacity(0.85)
///
/// Overlay()
///     .backdropFilter("saturate(180%) blur(8px)")
/// ```
///
/// ### CSS Mapping
///
/// Maps to the CSS `backdrop-filter` (and `-webkit-backdrop-filter`) property
/// on the rendered element.
///
/// - Important: The element must have a non-opaque background for the backdrop
///   filter to be visible through it.
public struct BackdropFilterModifier: ModifierValue {
    /// The raw CSS backdrop filter string, such as `"blur(10px)"` or `"blur(8px) brightness(0.8)"`.
    public let value: String

    /// Creates a backdrop filter modifier with the given CSS filter string.
    ///
    /// - Parameter value: A CSS filter function string applied to the area behind this node.
    public init(_ value: String) {
        self.value = value
    }
}

/// A modifier that controls how a node's colors are composited with the layers below it.
///
/// `BlendModeModifier` sets the CSS `mix-blend-mode` property, which determines
/// how a node's pixel colors combine with the colors of elements that it overlaps.
///
/// Common values include `"multiply"`, `"screen"`, `"overlay"`, `"darken"`,
/// `"lighten"`, `"color-dodge"`, `"color-burn"`, and `"normal"`.
///
/// ### Example
///
/// ```swift
/// Image("texture")
///     .blendMode("multiply")
///
/// ColorOverlay()
///     .blendMode("screen")
///     .opacity(0.6)
/// ```
///
/// ### CSS Mapping
///
/// Maps to the CSS `mix-blend-mode` property on the rendered element.
public struct BlendModeModifier: ModifierValue {
    /// The raw CSS blend mode value, such as `"multiply"` or `"overlay"`.
    public let value: String

    /// Creates a blend mode modifier with the given CSS blend mode value.
    ///
    /// - Parameter value: A CSS `mix-blend-mode` keyword (e.g., `"multiply"`, `"screen"`, `"normal"`).
    public init(_ value: String) {
        self.value = value
    }
}

extension Node {
    /// Applies a CSS filter effect to this node.
    ///
    /// Use standard CSS filter functions such as `blur()`, `brightness()`,
    /// `contrast()`, `grayscale()`, `saturate()`, and `drop-shadow()`.
    /// Multiple functions can be combined in a single string.
    ///
    /// ### Example
    ///
    /// ```swift
    /// Image("photo")
    ///     .filter("grayscale(100%)")
    ///
    /// Image("avatar")
    ///     .filter("blur(2px) opacity(0.7)")
    /// ```
    ///
    /// ### CSS Mapping
    ///
    /// Maps to the CSS `filter` property on the rendered element.
    ///
    /// - Parameter value: A CSS filter function string.
    /// - Returns: A `ModifiedNode` with the filter modifier applied.
    public func filter(_ value: String) -> ModifiedNode<Self> {
        ModifiedNode(content: self, modifiers: [FilterModifier(value)])
    }

    /// Applies a CSS backdrop filter to the area behind this node.
    ///
    /// The node should have some transparency for the effect to be visible.
    /// Common uses include frosted-glass overlays and blurred panel backgrounds.
    ///
    /// ### Example
    ///
    /// ```swift
    /// FloatingPanel()
    ///     .backdropFilter("blur(16px) brightness(0.95)")
    ///     .background(.surfaceTranslucent)
    ///
    /// ModalOverlay()
    ///     .backdropFilter("blur(8px) saturate(150%)")
    /// ```
    ///
    /// ### CSS Mapping
    ///
    /// Maps to the CSS `backdrop-filter` property on the rendered element.
    ///
    /// - Parameter value: A CSS filter function string applied to content behind this node.
    /// - Returns: A `ModifiedNode` with the backdrop filter modifier applied.
    public func backdropFilter(_ value: String) -> ModifiedNode<Self> {
        ModifiedNode(content: self, modifiers: [BackdropFilterModifier(value)])
    }

    /// Controls how this node's colors are composited with overlapping layers below it.
    ///
    /// ### Example
    ///
    /// ```swift
    /// Image("texture")
    ///     .blendMode("multiply")
    ///
    /// Highlight()
    ///     .blendMode("overlay")
    ///     .opacity(0.5)
    /// ```
    ///
    /// ### CSS Mapping
    ///
    /// Maps to the CSS `mix-blend-mode` property on the rendered element.
    ///
    /// - Parameter value: A CSS `mix-blend-mode` keyword such as `"multiply"`, `"screen"`, or `"normal"`.
    /// - Returns: A `ModifiedNode` with the blend mode modifier applied.
    public func blendMode(_ value: String) -> ModifiedNode<Self> {
        ModifiedNode(content: self, modifiers: [BlendModeModifier(value)])
    }
}
