/// Describes how the total width and height of an element are calculated.
///
/// `BoxSizing` determines whether padding and borders are included in an element's
/// declared `width` and `height`, or whether they are added on top of those values.
///
/// ### CSS Mapping
///
/// Maps to the CSS `box-sizing` property.
public enum BoxSizing: String, Sendable {

    /// The declared width and height apply to the content area only.
    ///
    /// Padding and borders are added outside the specified dimensions,
    /// increasing the element's total rendered size. Equivalent to CSS `content-box`.
    case contentBox = "content-box"

    /// The declared width and height include padding and borders.
    ///
    /// The content area shrinks to accommodate padding and border widths within
    /// the specified dimensions. Equivalent to CSS `border-box`.
    case borderBox = "border-box"
}

/// A modifier that controls how an element's box dimensions are computed.
///
/// `BoxSizingModifier` applies the CSS `box-sizing` property to a node, determining
/// whether padding and border contribute to or are absorbed within the element's
/// declared width and height.
///
/// ### Example
///
/// ```swift
/// Div {
///     Text("Content")
/// }
/// .boxSizing(.borderBox)
/// ```
///
/// ### CSS Mapping
///
/// Maps to the CSS `box-sizing` property on the rendered element.
public struct BoxSizingModifier: ModifierValue {

    /// The box-sizing mode to apply.
    public let value: BoxSizing

    /// Creates a box-sizing modifier.
    ///
    /// - Parameter value: The box-sizing mode to apply to the element.
    public init(_ value: BoxSizing) {
        self.value = value
    }
}

extension Node {

    /// Sets how the element's total size is calculated with respect to padding and borders.
    ///
    /// Use `.boxSizing(.borderBox)` to ensure that padding and borders are included
    /// within the element's declared dimensions, which is often the most predictable
    /// sizing behaviour for layout.
    ///
    /// ### Example
    ///
    /// ```swift
    /// Div {
    ///     Text("Padded content")
    /// }
    /// .size(width: 300)
    /// .boxSizing(.borderBox)
    /// ```
    ///
    /// ### CSS Mapping
    ///
    /// Maps to the CSS `box-sizing` property.
    ///
    /// - Parameter value: The box-sizing mode to apply.
    /// - Returns: A modified node with the box-sizing style applied.
    public func boxSizing(_ value: BoxSizing) -> ModifiedNode<Self> {
        ModifiedNode(content: self, modifiers: [BoxSizingModifier(value)])
    }
}
