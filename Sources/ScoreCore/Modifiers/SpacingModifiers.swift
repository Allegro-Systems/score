/// A logical edge or axis of a node's box model.
///
/// `Edge` is used with spacing modifiers such as `padding` and `margin` to target
/// specific sides or axes of a node rather than applying a uniform value to all sides.
///
/// ### CSS Mapping
///
/// Maps to directional CSS properties such as `padding-top`, `padding-inline`, etc.
public enum Edge: Sendable, Hashable {
    /// The top edge of the node.
    ///
    /// CSS equivalent: `-top` suffix (e.g., `padding-top`, `margin-top`).
    case top

    /// The bottom edge of the node.
    ///
    /// CSS equivalent: `-bottom` suffix (e.g., `padding-bottom`, `margin-bottom`).
    case bottom

    /// The leading (start) edge, respecting the document's writing direction.
    ///
    /// CSS equivalent: `-inline-start` or `-left` suffix.
    case leading

    /// The trailing (end) edge, respecting the document's writing direction.
    ///
    /// CSS equivalent: `-inline-end` or `-right` suffix.
    case trailing

    /// Both the leading and trailing edges simultaneously.
    ///
    /// CSS equivalent: `-inline` suffix (e.g., `padding-inline`).
    case horizontal

    /// Both the top and bottom edges simultaneously.
    ///
    /// CSS equivalent: `-block` suffix (e.g., `padding-block`).
    case vertical
}

/// A modifier that applies uniform or edge-specific padding to a node.
///
/// `PaddingModifier` adds inner spacing between a node's content and its border.
/// When `edges` is `nil`, the value is applied to all four sides uniformly.
///
/// ### Example
///
/// ```swift
/// Text("Hello")
///     .padding(16)
///
/// Text("Hello")
///     .padding(8, at: .horizontal)
/// ```
///
/// ### CSS Mapping
///
/// Maps to the CSS `padding` property, or directional variants such as
/// `padding-top`, `padding-inline`, etc. when specific edges are provided.
public struct PaddingModifier: ModifierValue {
    /// The padding amount in points.
    public let value: Double

    /// The set of edges to which the padding is applied.
    ///
    /// When `nil`, padding is applied uniformly to all four edges.
    public let edges: Set<Edge>?

    /// Creates a padding modifier.
    ///
    /// - Parameters:
    ///   - value: The padding amount in points.
    ///   - edges: The specific edges to pad. Pass `nil` to apply padding to all edges.
    public init(_ value: Double, edges: Set<Edge>? = nil) {
        self.value = value
        self.edges = edges
    }
}

/// A modifier that applies uniform or edge-specific margin to a node.
///
/// `MarginModifier` adds outer spacing between a node's border and surrounding elements.
/// When `edges` is `nil`, the value is applied to all four sides uniformly.
///
/// ### Example
///
/// ```swift
/// Card()
///     .margin(24)
///
/// Card()
///     .margin(12, at: .top)
/// ```
///
/// ### CSS Mapping
///
/// Maps to the CSS `margin` property, or directional variants such as
/// `margin-top`, `margin-inline`, etc. when specific edges are provided.
public struct MarginModifier: ModifierValue {
    /// The margin amount in points.
    public let value: Double

    /// The set of edges to which the margin is applied.
    ///
    /// When `nil`, margin is applied uniformly to all four edges.
    public let edges: Set<Edge>?

    /// Creates a margin modifier.
    ///
    /// - Parameters:
    ///   - value: The margin amount in points.
    ///   - edges: The specific edges to apply the margin to. Pass `nil` to apply to all edges.
    public init(_ value: Double, edges: Set<Edge>? = nil) {
        self.value = value
        self.edges = edges
    }
}

extension Node {
    /// Applies uniform padding on all four edges of this node.
    ///
    /// ### Example
    ///
    /// ```swift
    /// Text("Hello")
    ///     .padding(16)
    /// ```
    ///
    /// ### CSS Mapping
    ///
    /// Maps to the CSS `padding` shorthand property.
    ///
    /// - Parameter value: The padding amount in points, applied to all edges.
    /// - Returns: A `ModifiedNode` with the padding modifier applied.
    public func padding(_ value: Double) -> ModifiedNode<Self> {
        ModifiedNode(content: self, modifiers: [PaddingModifier(value)])
    }

    /// Applies padding to a single edge of this node.
    ///
    /// ### Example
    ///
    /// ```swift
    /// Text("Hello")
    ///     .padding(8, at: .top)
    /// ```
    ///
    /// ### CSS Mapping
    ///
    /// Maps to a directional CSS padding property such as `padding-top`.
    ///
    /// - Parameters:
    ///   - value: The padding amount in points.
    ///   - edge: The single `Edge` to which padding is applied.
    /// - Returns: A `ModifiedNode` with the padding modifier applied.
    public func padding(_ value: Double, at edge: Edge) -> ModifiedNode<Self> {
        ModifiedNode(content: self, modifiers: [PaddingModifier(value, edges: Set([edge]))])
    }

    /// Applies padding to an array of specified edges of this node.
    ///
    /// ### Example
    ///
    /// ```swift
    /// Text("Hello")
    ///     .padding(12, at: [.top, .bottom])
    /// ```
    ///
    /// ### CSS Mapping
    ///
    /// Maps to a combination of directional CSS padding properties.
    ///
    /// - Parameters:
    ///   - value: The padding amount in points.
    ///   - edges: An array of `Edge` values to which padding is applied.
    /// - Returns: A `ModifiedNode` with the padding modifier applied.
    public func padding(_ value: Double, at edges: [Edge]) -> ModifiedNode<Self> {
        ModifiedNode(content: self, modifiers: [PaddingModifier(value, edges: Set(edges))])
    }

    /// Applies padding to a variadic list of specified edges of this node.
    ///
    /// ### Example
    ///
    /// ```swift
    /// Text("Hello")
    ///     .padding(12, at: .leading, .trailing)
    /// ```
    ///
    /// ### CSS Mapping
    ///
    /// Maps to a combination of directional CSS padding properties.
    ///
    /// - Parameters:
    ///   - value: The padding amount in points.
    ///   - edges: A variadic list of `Edge` values to which padding is applied.
    /// - Returns: A `ModifiedNode` with the padding modifier applied.
    public func padding(_ value: Double, at edges: Edge...) -> ModifiedNode<Self> {
        ModifiedNode(content: self, modifiers: [PaddingModifier(value, edges: Set(edges))])
    }

    /// Applies uniform margin on all four edges of this node.
    ///
    /// ### Example
    ///
    /// ```swift
    /// Card()
    ///     .margin(24)
    /// ```
    ///
    /// ### CSS Mapping
    ///
    /// Maps to the CSS `margin` shorthand property.
    ///
    /// - Parameter value: The margin amount in points, applied to all edges.
    /// - Returns: A `ModifiedNode` with the margin modifier applied.
    public func margin(_ value: Double) -> ModifiedNode<Self> {
        ModifiedNode(content: self, modifiers: [MarginModifier(value)])
    }

    /// Applies margin to a single edge of this node.
    ///
    /// ### Example
    ///
    /// ```swift
    /// Card()
    ///     .margin(16, at: .bottom)
    /// ```
    ///
    /// ### CSS Mapping
    ///
    /// Maps to a directional CSS margin property such as `margin-bottom`.
    ///
    /// - Parameters:
    ///   - value: The margin amount in points.
    ///   - edge: The single `Edge` to which the margin is applied.
    /// - Returns: A `ModifiedNode` with the margin modifier applied.
    public func margin(_ value: Double, at edge: Edge) -> ModifiedNode<Self> {
        ModifiedNode(content: self, modifiers: [MarginModifier(value, edges: Set([edge]))])
    }

    /// Applies margin to an array of specified edges of this node.
    ///
    /// ### Example
    ///
    /// ```swift
    /// Card()
    ///     .margin(8, at: [.leading, .trailing])
    /// ```
    ///
    /// ### CSS Mapping
    ///
    /// Maps to a combination of directional CSS margin properties.
    ///
    /// - Parameters:
    ///   - value: The margin amount in points.
    ///   - edges: An array of `Edge` values to which the margin is applied.
    /// - Returns: A `ModifiedNode` with the margin modifier applied.
    public func margin(_ value: Double, at edges: [Edge]) -> ModifiedNode<Self> {
        ModifiedNode(content: self, modifiers: [MarginModifier(value, edges: Set(edges))])
    }

    /// Applies margin to a variadic list of specified edges of this node.
    ///
    /// ### Example
    ///
    /// ```swift
    /// Card()
    ///     .margin(8, at: .top, .bottom)
    /// ```
    ///
    /// ### CSS Mapping
    ///
    /// Maps to a combination of directional CSS margin properties.
    ///
    /// - Parameters:
    ///   - value: The margin amount in points.
    ///   - edges: A variadic list of `Edge` values to which the margin is applied.
    /// - Returns: A `ModifiedNode` with the margin modifier applied.
    public func margin(_ value: Double, at edges: Edge...) -> ModifiedNode<Self> {
        ModifiedNode(content: self, modifiers: [MarginModifier(value, edges: Set(edges))])
    }
}
