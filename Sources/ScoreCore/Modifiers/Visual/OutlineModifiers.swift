/// A modifier that draws an outline around a node.
///
/// `OutlineModifier` renders an outline outside a node's border box using
/// a configurable width, line style, color, and optional offset. Unlike borders,
/// outlines do not affect the document's layout flow or box model.
///
/// Outlines are most commonly used to indicate keyboard focus states for
/// accessibility, though they can be applied for any visual purpose.
///
/// ### Example
///
/// ```swift
/// Button("Submit")
///     .outline(width: 2, style: .solid, color: .focus)
///
/// TextInput()
///     .outline(width: 2, style: .solid, color: .accent, offset: 2)
/// ```
///
/// ### CSS Mapping
///
/// Maps to the CSS `outline`, `outline-width`, `outline-style`, `outline-color`,
/// and `outline-offset` properties on the rendered element.
///
/// - Important: Outlines do not occupy layout space. Use borders when you need
///   spacing to be affected by the stroke.
public struct OutlineModifier: ModifierValue {
    /// The thickness of the outline stroke in points.
    public let width: Double

    /// The line style of the outline (solid, dashed, dotted, or none).
    public let style: BorderStyle

    /// The design-token color of the outline.
    public let color: ColorToken

    /// The gap between the node's border box and the outline in points.
    ///
    /// When `nil`, the default offset of `0` is used, placing the outline
    /// flush against the border edge.
    public let offset: Double?

    /// Creates an outline modifier.
    ///
    /// - Parameters:
    ///   - width: The outline stroke width in points.
    ///   - style: The line style (e.g., `.solid`, `.dashed`).
    ///   - color: The design-token color of the outline.
    ///   - offset: Optional gap between the border box and the outline in points.
    public init(width: Double, style: BorderStyle, color: ColorToken, offset: Double? = nil) {
        self.width = width
        self.style = style
        self.color = color
        self.offset = offset
    }
}

extension Node {
    /// Draws an outline around this node outside its border box.
    ///
    /// Outlines do not affect the document's layout flow. They are commonly
    /// used to communicate focus state for keyboard navigation.
    ///
    /// ### Example
    ///
    /// ```swift
    /// Button("Save")
    ///     .outline(width: 2, style: .solid, color: .focus, offset: 2)
    ///
    /// Card()
    ///     .outline(width: 1, style: .dashed, color: .border)
    /// ```
    ///
    /// ### CSS Mapping
    ///
    /// Maps to the CSS `outline`, `outline-width`, `outline-style`, `outline-color`,
    /// and `outline-offset` properties on the rendered element.
    ///
    /// - Parameters:
    ///   - width: The outline stroke width in points.
    ///   - style: The line style (e.g., `.solid`, `.dashed`).
    ///   - color: The design-token color of the outline.
    ///   - offset: Optional gap between the border box and the outline in points. Defaults to `nil`.
    /// - Returns: A `ModifiedNode` with the outline modifier applied.
    public func outline(width: Double, style: BorderStyle, color: ColorToken, offset: Double? = nil) -> ModifiedNode<Self> {
        let mod = OutlineModifier(width: width, style: style, color: color, offset: offset)
        return ModifiedNode(content: self, modifiers: [mod])
    }
}
