/// A modifier that sets the background color of a node.
///
/// `BackgroundModifier` fills the node's background with a design-token color.
/// For image-based backgrounds, use `BackgroundImageModifier` instead.
///
/// ### Example
///
/// ```swift
/// Box()
///     .background(.surface)
/// ```
///
/// ### CSS Mapping
///
/// Maps to the CSS `background-color` property on the rendered element.
public struct BackgroundModifier: ModifierValue {
    /// The design-token color applied as the background fill.
    public let color: ColorToken

    /// Creates a background color modifier.
    ///
    /// - Parameter color: The `ColorToken` to use as the background color.
    public init(_ color: ColorToken) {
        self.color = color
    }
}

extension Node {
    /// Sets the background fill color of this node.
    ///
    /// ### Example
    ///
    /// ```swift
    /// Box()
    ///     .background(.surface)
    /// ```
    ///
    /// ### CSS Mapping
    ///
    /// Maps to the CSS `background-color` property on the rendered element.
    ///
    /// - Parameter color: The `ColorToken` to use as the background color.
    /// - Returns: A `ModifiedNode` with the background modifier applied.
    public func background(_ color: ColorToken) -> ModifiedNode<Self> {
        ModifiedNode(content: self, modifiers: [BackgroundModifier(color)])
    }
}
