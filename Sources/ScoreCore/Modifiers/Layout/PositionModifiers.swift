/// The positioning scheme applied to an element.
///
/// `PositionMode` determines how an element is positioned within its containing
/// block and whether it participates in the normal document flow.
///
/// ### CSS Mapping
///
/// Maps to the CSS `position` property.
public enum PositionMode: String, Sendable {

    /// The element is positioned according to the normal document flow.
    ///
    /// Offset properties (`top`, `bottom`, `leading`, `trailing`) have no effect.
    /// This is the default browser behaviour. Equivalent to CSS `static`.
    case `static`

    /// The element is positioned according to the normal flow, then offset from that position.
    ///
    /// The element remains in the document flow and the offset does not affect
    /// neighbouring elements. Equivalent to CSS `relative`.
    case relative

    /// The element is removed from the normal flow and positioned relative to
    /// its nearest positioned ancestor.
    ///
    /// If no positioned ancestor exists, the element is positioned relative to
    /// the initial containing block. Equivalent to CSS `absolute`.
    case absolute

    /// The element is removed from the normal flow and positioned relative to the viewport.
    ///
    /// The element remains in the same place even when the page is scrolled.
    /// Equivalent to CSS `fixed`.
    case fixed

    /// The element is positioned according to the normal flow until a scroll threshold
    /// is reached, then it sticks in place within its scrolling container.
    ///
    /// Equivalent to CSS `sticky`.
    case sticky
}

/// A modifier that sets the positioning mode and offsets of an element.
///
/// `PositionModifier` applies the CSS `position` property together with optional
/// inset offsets — `top`, `bottom`, `left` (leading), and `right` (trailing) —
/// to precisely control where the element appears within its containing block.
///
/// ### Example
///
/// ```swift
/// Div {
///     Text("Pinned to top-right")
/// }
/// .position(.absolute, top: 16, trailing: 16)
/// ```
///
/// ### CSS Mapping
///
/// Maps to the CSS `position`, `top`, `bottom`, `left`, and `right` properties
/// on the rendered element.
public struct PositionModifier: ModifierValue {

    /// The positioning scheme to apply.
    ///
    /// Equivalent to CSS `position`.
    public let mode: PositionMode

    /// The distance from the top edge of the containing block in points.
    ///
    /// When `nil`, the CSS `top` property is not set. Equivalent to CSS `top`.
    public let top: Double?

    /// The distance from the bottom edge of the containing block in points.
    ///
    /// When `nil`, the CSS `bottom` property is not set. Equivalent to CSS `bottom`.
    public let bottom: Double?

    /// The distance from the leading (left) edge of the containing block in points.
    ///
    /// When `nil`, the CSS `left` property is not set. Equivalent to CSS `left`.
    public let leading: Double?

    /// The distance from the trailing (right) edge of the containing block in points.
    ///
    /// When `nil`, the CSS `right` property is not set. Equivalent to CSS `right`.
    public let trailing: Double?

    /// Creates a position modifier.
    ///
    /// - Parameters:
    ///   - mode: The positioning scheme to apply.
    ///   - top: The offset from the top edge in points. Defaults to `nil`.
    ///   - bottom: The offset from the bottom edge in points. Defaults to `nil`.
    ///   - leading: The offset from the leading edge in points. Defaults to `nil`.
    ///   - trailing: The offset from the trailing edge in points. Defaults to `nil`.
    public init(
        _ mode: PositionMode,
        top: Double? = nil,
        bottom: Double? = nil,
        leading: Double? = nil,
        trailing: Double? = nil
    ) {
        self.mode = mode
        self.top = top
        self.bottom = bottom
        self.leading = leading
        self.trailing = trailing
    }
}

/// A modifier that controls the stacking order of a positioned element.
///
/// `ZIndexModifier` applies the CSS `z-index` property, determining how elements
/// overlap when they share the same positioning context. Higher values appear in
/// front of lower values.
///
/// ### Example
///
/// ```swift
/// Div {
///     Text("Modal overlay")
/// }
/// .position(.fixed, top: 0, leading: 0)
/// .zIndex(100)
/// ```
///
/// ### CSS Mapping
///
/// Maps to the CSS `z-index` property on the rendered element.
///
/// - Important: `z-index` only takes effect on elements with a `position` value
///   other than `static`.
public struct ZIndexModifier: ModifierValue {

    /// The stacking order value.
    ///
    /// Higher integers appear in front. Negative values place the element behind
    /// its containing block. Equivalent to CSS `z-index`.
    public let value: Int

    /// Creates a z-index modifier.
    ///
    /// - Parameter value: The stacking order integer.
    public init(_ value: Int) {
        self.value = value
    }
}

extension Node {

    /// Sets the positioning scheme and optional inset offsets of the element.
    ///
    /// Use `.position(.relative)` to establish a new positioning context for
    /// absolutely positioned descendants. Use `.position(.absolute, ...)` or
    /// `.position(.fixed, ...)` to remove the element from the normal flow and
    /// place it at exact coordinates.
    ///
    /// ### Example
    ///
    /// ```swift
    /// Div {
    ///     Text("Sticky header")
    /// }
    /// .position(.sticky, top: 0)
    ///
    /// Div {
    ///     Text("Tooltip")
    /// }
    /// .position(.absolute, top: 8, leading: 8)
    /// ```
    ///
    /// ### CSS Mapping
    ///
    /// Maps to the CSS `position`, `top`, `bottom`, `left`, and `right` properties.
    ///
    /// - Parameters:
    ///   - mode: The positioning scheme to apply.
    ///   - top: The offset from the top edge in points. Defaults to `nil`.
    ///   - bottom: The offset from the bottom edge in points. Defaults to `nil`.
    ///   - leading: The offset from the leading edge in points. Defaults to `nil`.
    ///   - trailing: The offset from the trailing edge in points. Defaults to `nil`.
    /// - Returns: A modified node with the position styles applied.
    public func position(
        _ mode: PositionMode,
        top: Double? = nil,
        bottom: Double? = nil,
        leading: Double? = nil,
        trailing: Double? = nil
    ) -> ModifiedNode<Self> {
        let mod = PositionModifier(mode, top: top, bottom: bottom, leading: leading, trailing: trailing)
        return ModifiedNode(content: self, modifiers: [mod])
    }

    /// Sets the stacking order of the element within its positioning context.
    ///
    /// Elements with a higher z-index value are rendered in front of those with
    /// lower values when they overlap. This modifier only has an effect on elements
    /// that have a `position` other than `static`.
    ///
    /// ### Example
    ///
    /// ```swift
    /// Div {
    ///     Text("Dropdown menu")
    /// }
    /// .position(.absolute, top: 48)
    /// .zIndex(50)
    /// ```
    ///
    /// ### CSS Mapping
    ///
    /// Maps to the CSS `z-index` property.
    ///
    /// - Parameter value: The stacking order integer.
    /// - Returns: A modified node with the z-index style applied.
    public func zIndex(_ value: Int) -> ModifiedNode<Self> {
        ModifiedNode(content: self, modifiers: [ZIndexModifier(value)])
    }
}
