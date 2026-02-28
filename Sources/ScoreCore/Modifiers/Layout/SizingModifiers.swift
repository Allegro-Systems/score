/// A modifier that constrains the width and height of an element.
///
/// `SizeModifier` applies any combination of explicit, minimum, and maximum
/// width and height values to a node. Only the properties that are explicitly
/// set are emitted in the rendered CSS output; omitted values are left at their
/// inherited or default browser values.
///
/// ### Example
///
/// ```swift
/// Div {
///     Text("Constrained box")
/// }
/// .size(width: 320, minHeight: 120, maxHeight: 480)
/// ```
///
/// ### CSS Mapping
///
/// Maps to the CSS `width`, `height`, `min-width`, `min-height`, `max-width`,
/// and `max-height` properties on the rendered element.
public struct SizeModifier: ModifierValue {

    /// The explicit width of the element in points.
    ///
    /// When `nil`, the CSS `width` property is not set.
    public let width: Double?

    /// The explicit height of the element in points.
    ///
    /// When `nil`, the CSS `height` property is not set.
    public let height: Double?

    /// The minimum width of the element in points.
    ///
    /// When `nil`, the CSS `min-width` property is not set.
    public let minWidth: Double?

    /// The minimum height of the element in points.
    ///
    /// When `nil`, the CSS `min-height` property is not set.
    public let minHeight: Double?

    /// The maximum width of the element in points.
    ///
    /// When `nil`, the CSS `max-width` property is not set.
    public let maxWidth: Double?

    /// The maximum height of the element in points.
    ///
    /// When `nil`, the CSS `max-height` property is not set.
    public let maxHeight: Double?

    /// Creates a size modifier.
    ///
    /// All parameters are optional. Omit any parameter to leave its corresponding
    /// CSS property unset.
    ///
    /// - Parameters:
    ///   - width: The explicit width in points. Defaults to `nil`.
    ///   - height: The explicit height in points. Defaults to `nil`.
    ///   - minWidth: The minimum width in points. Defaults to `nil`.
    ///   - minHeight: The minimum height in points. Defaults to `nil`.
    ///   - maxWidth: The maximum width in points. Defaults to `nil`.
    ///   - maxHeight: The maximum height in points. Defaults to `nil`.
    public init(
        width: Double? = nil,
        height: Double? = nil,
        minWidth: Double? = nil,
        minHeight: Double? = nil,
        maxWidth: Double? = nil,
        maxHeight: Double? = nil
    ) {
        self.width = width
        self.height = height
        self.minWidth = minWidth
        self.minHeight = minHeight
        self.maxWidth = maxWidth
        self.maxHeight = maxHeight
    }
}

/// A modifier that enforces a fixed aspect ratio on an element.
///
/// `AspectRatioModifier` applies the CSS `aspect-ratio` property, causing the
/// browser to maintain the given width-to-height ratio when only one dimension
/// is explicitly sized. This is especially useful for images, videos, and
/// other embedded media.
///
/// ### Example
///
/// ```swift
/// Image("hero")
///     .aspectRatio(16.0 / 9.0)
/// ```
///
/// ### CSS Mapping
///
/// Maps to the CSS `aspect-ratio` property on the rendered element.
public struct AspectRatioModifier: ModifierValue {

    /// The width-to-height ratio to maintain.
    ///
    /// For example, pass `16.0 / 9.0` for a widescreen ratio, or `1.0` for a square.
    /// Equivalent to CSS `aspect-ratio: <ratio>`.
    public let ratio: Double

    /// Creates an aspect ratio modifier.
    ///
    /// - Parameter ratio: The width-to-height ratio to enforce.
    public init(_ ratio: Double) {
        self.ratio = ratio
    }
}

extension Node {

    /// Sets explicit, minimum, and maximum dimensions for the element.
    ///
    /// Use this modifier when you need fine-grained control over one or more of the
    /// six sizing CSS properties. For simpler cases where you only need to set `width`
    /// and `height`, prefer the `.frame(width:height:)` shorthand.
    ///
    /// ### Example
    ///
    /// ```swift
    /// Div {
    ///     Text("Fluid column")
    /// }
    /// .size(minWidth: 200, maxWidth: 600)
    ///
    /// Div {
    ///     Text("Fixed box")
    /// }
    /// .size(width: 320, height: 240)
    /// ```
    ///
    /// ### CSS Mapping
    ///
    /// Maps to the CSS `width`, `height`, `min-width`, `min-height`, `max-width`,
    /// and `max-height` properties.
    ///
    /// - Parameters:
    ///   - width: The explicit width in points. Defaults to `nil`.
    ///   - height: The explicit height in points. Defaults to `nil`.
    ///   - minWidth: The minimum width in points. Defaults to `nil`.
    ///   - minHeight: The minimum height in points. Defaults to `nil`.
    ///   - maxWidth: The maximum width in points. Defaults to `nil`.
    ///   - maxHeight: The maximum height in points. Defaults to `nil`.
    /// - Returns: A modified node with the sizing styles applied.
    public func size(
        width: Double? = nil,
        height: Double? = nil,
        minWidth: Double? = nil,
        minHeight: Double? = nil,
        maxWidth: Double? = nil,
        maxHeight: Double? = nil
    ) -> ModifiedNode<Self> {
        let mod = SizeModifier(
            width: width,
            height: height,
            minWidth: minWidth,
            minHeight: minHeight,
            maxWidth: maxWidth,
            maxHeight: maxHeight
        )
        return ModifiedNode(content: self, modifiers: [mod])
    }

    /// Sets the explicit width and height of the element.
    ///
    /// This is a convenience shorthand for `.size(width:height:)` that only sets
    /// the explicit dimensions without touching minimum or maximum constraints.
    ///
    /// ### Example
    ///
    /// ```swift
    /// Image("avatar")
    ///     .frame(width: 48, height: 48)
    ///
    /// Div {
    ///     Text("Banner")
    /// }
    /// .frame(width: 800)
    /// ```
    ///
    /// ### CSS Mapping
    ///
    /// Maps to the CSS `width` and `height` properties.
    ///
    /// - Parameters:
    ///   - width: The explicit width in points. Defaults to `nil`.
    ///   - height: The explicit height in points. Defaults to `nil`.
    /// - Returns: A modified node with the width and height styles applied.
    public func frame(width: Double? = nil, height: Double? = nil) -> ModifiedNode<Self> {
        ModifiedNode(content: self, modifiers: [SizeModifier(width: width, height: height)])
    }

    /// Enforces a fixed width-to-height aspect ratio on the element.
    ///
    /// The browser will automatically calculate the missing dimension to maintain
    /// the ratio when only `width` or only `height` is specified. Particularly
    /// useful for responsive images, video embeds, and square thumbnails.
    ///
    /// ### Example
    ///
    /// ```swift
    /// Image("thumbnail")
    ///     .frame(width: 320)
    ///     .aspectRatio(16.0 / 9.0)
    ///
    /// Div {
    ///     Text("Square tile")
    /// }
    /// .aspectRatio(1.0)
    /// ```
    ///
    /// ### CSS Mapping
    ///
    /// Maps to the CSS `aspect-ratio` property.
    ///
    /// - Parameter ratio: The width-to-height ratio to enforce.
    /// - Returns: A modified node with the aspect-ratio style applied.
    public func aspectRatio(_ ratio: Double) -> ModifiedNode<Self> {
        ModifiedNode(content: self, modifiers: [AspectRatioModifier(ratio)])
    }
}
