/// A modifier that controls how a flex item grows, shrinks, and is ordered within its container.
///
/// `FlexItemModifier` applies flex child properties to a node, giving fine-grained
/// control over how an individual item behaves inside a flex container. It covers
/// the `flex-grow`, `flex-shrink`, `flex-basis`, `order`, and `align-self` CSS properties.
///
/// ### Example
///
/// ```swift
/// Div {
///     Text("Grows to fill space")
/// }
/// .flexItem(grow: 1, shrink: 0, alignSelf: .center)
/// ```
///
/// ### CSS Mapping
///
/// Maps to the CSS `flex-grow`, `flex-shrink`, `flex-basis`, `order`,
/// and `align-self` properties on the rendered element.
public struct FlexItemModifier: ModifierValue {

    /// The factor by which the item grows relative to other flex siblings.
    ///
    /// A value of `1` allows the item to grow to fill available space.
    /// When `nil`, the CSS `flex-grow` property is not set.
    /// Equivalent to CSS `flex-grow`.
    public let grow: Double?

    /// The factor by which the item shrinks relative to other flex siblings when space is limited.
    ///
    /// A value of `0` prevents the item from shrinking.
    /// When `nil`, the CSS `flex-shrink` property is not set.
    /// Equivalent to CSS `flex-shrink`.
    public let shrink: Double?

    /// The initial main-size of the flex item before free space is distributed.
    ///
    /// Expressed in points. When `nil`, the CSS `flex-basis` property is not set.
    /// Equivalent to CSS `flex-basis`.
    public let basis: Double?

    /// The position of the item relative to other flex siblings.
    ///
    /// Lower values appear first. When `nil`, the CSS `order` property is not set.
    /// Equivalent to CSS `order`.
    public let order: Int?

    /// The cross-axis alignment override for this individual flex item.
    ///
    /// Overrides the container's `align-items` value for this specific child.
    /// When `nil`, the CSS `align-self` property is not set.
    /// Equivalent to CSS `align-self`.
    public let alignSelf: FlexAlign?

    /// Creates a flex item modifier.
    ///
    /// All parameters are optional. Omit any parameter to leave its corresponding
    /// CSS property unset.
    ///
    /// - Parameters:
    ///   - grow: The flex-grow factor. Defaults to `nil`.
    ///   - shrink: The flex-shrink factor. Defaults to `nil`.
    ///   - basis: The flex-basis value in points. Defaults to `nil`.
    ///   - order: The visual ordering index. Defaults to `nil`.
    ///   - alignSelf: The per-item cross-axis alignment. Defaults to `nil`.
    public init(grow: Double? = nil, shrink: Double? = nil, basis: Double? = nil, order: Int? = nil, alignSelf: FlexAlign? = nil) {
        self.grow = grow
        self.shrink = shrink
        self.basis = basis
        self.order = order
        self.alignSelf = alignSelf
    }
}

/// A modifier that controls where a grid item is placed within its grid container.
///
/// `GridPlacementModifier` applies grid child placement properties to a node,
/// including explicit column and row placement, named area assignment, inline
/// justification, and the shorthand `place-self` property.
///
/// ### Example
///
/// ```swift
/// Div {
///     Text("Header")
/// }
/// .gridPlacement(area: "header", justifySelf: .center)
/// ```
///
/// ### CSS Mapping
///
/// Maps to the CSS `grid-column`, `grid-row`, `grid-area`, `justify-self`,
/// and `place-self` properties on the rendered element.
public struct GridPlacementModifier: ModifierValue {

    /// The column track or span within the grid.
    ///
    /// Accepts any valid CSS `grid-column` value, such as `"1"`, `"1 / 3"`, or `"span 2"`.
    /// When `nil`, the CSS `grid-column` property is not set.
    public let column: String?

    /// The row track or span within the grid.
    ///
    /// Accepts any valid CSS `grid-row` value, such as `"2"` or `"1 / span 3"`.
    /// When `nil`, the CSS `grid-row` property is not set.
    public let row: String?

    /// The named grid area this item should occupy.
    ///
    /// Corresponds to a name defined in the container's `grid-template-areas`.
    /// When `nil`, the CSS `grid-area` property is not set.
    public let area: String?

    /// The inline-axis alignment of the item within its grid cell.
    ///
    /// Overrides the container's `justify-items` value for this specific child.
    /// When `nil`, the CSS `justify-self` property is not set.
    public let justifySelf: TextAlign?

    /// The shorthand for both block-axis and inline-axis self-alignment.
    ///
    /// Accepts any valid CSS `place-self` value, such as `"center start"`.
    /// When `nil`, the CSS `place-self` property is not set.
    public let placeSelf: String?

    /// Creates a grid placement modifier.
    ///
    /// All parameters are optional. Omit any parameter to leave its corresponding
    /// CSS property unset.
    ///
    /// - Parameters:
    ///   - column: The grid column placement string. Defaults to `nil`.
    ///   - row: The grid row placement string. Defaults to `nil`.
    ///   - area: The named grid area. Defaults to `nil`.
    ///   - justifySelf: The inline-axis alignment. Defaults to `nil`.
    ///   - placeSelf: The shorthand self-placement string. Defaults to `nil`.
    public init(column: String? = nil, row: String? = nil, area: String? = nil, justifySelf: TextAlign? = nil, placeSelf: String? = nil) {
        self.column = column
        self.row = row
        self.area = area
        self.justifySelf = justifySelf
        self.placeSelf = placeSelf
    }
}

extension Node {

    /// Applies flex item properties to control how the node behaves inside a flex container.
    ///
    /// Use this modifier on children of a `.flex(...)` container to individually
    /// control growth, shrinkage, initial size, visual order, and cross-axis alignment.
    ///
    /// ### Example
    ///
    /// ```swift
    /// Div {
    ///     Text("Sidebar")
    /// }
    /// .flexItem(grow: 0, shrink: 0, basis: 240)
    ///
    /// Div {
    ///     Text("Main content")
    /// }
    /// .flexItem(grow: 1)
    /// ```
    ///
    /// ### CSS Mapping
    ///
    /// Maps to the CSS `flex-grow`, `flex-shrink`, `flex-basis`, `order`,
    /// and `align-self` properties.
    ///
    /// - Parameters:
    ///   - grow: The flex-grow factor. Defaults to `nil`.
    ///   - shrink: The flex-shrink factor. Defaults to `nil`.
    ///   - basis: The flex-basis value in points. Defaults to `nil`.
    ///   - order: The visual ordering index. Defaults to `nil`.
    ///   - alignSelf: The per-item cross-axis alignment. Defaults to `nil`.
    /// - Returns: A modified node with the flex item styles applied.
    public func flexItem(grow: Double? = nil, shrink: Double? = nil, basis: Double? = nil, order: Int? = nil, alignSelf: FlexAlign? = nil) -> ModifiedNode<Self> {
        let mod = FlexItemModifier(grow: grow, shrink: shrink, basis: basis, order: order, alignSelf: alignSelf)
        return ModifiedNode(content: self, modifiers: [mod])
    }

    /// Applies grid placement properties to control where the node appears in a grid container.
    ///
    /// Use this modifier on children of a `.grid(...)` container to place the item
    /// at a specific column, row, or named area, and to control its inline alignment.
    ///
    /// ### Example
    ///
    /// ```swift
    /// Div {
    ///     Text("Spanning header")
    /// }
    /// .gridPlacement(column: "1 / -1", row: "1")
    ///
    /// Div {
    ///     Text("Named area")
    /// }
    /// .gridPlacement(area: "sidebar", justifySelf: .start)
    /// ```
    ///
    /// ### CSS Mapping
    ///
    /// Maps to the CSS `grid-column`, `grid-row`, `grid-area`, `justify-self`,
    /// and `place-self` properties.
    ///
    /// - Parameters:
    ///   - column: The grid column placement string. Defaults to `nil`.
    ///   - row: The grid row placement string. Defaults to `nil`.
    ///   - area: The named grid area. Defaults to `nil`.
    ///   - justifySelf: The inline-axis alignment. Defaults to `nil`.
    ///   - placeSelf: The shorthand self-placement string. Defaults to `nil`.
    /// - Returns: A modified node with the grid placement styles applied.
    public func gridPlacement(column: String? = nil, row: String? = nil, area: String? = nil, justifySelf: TextAlign? = nil, placeSelf: String? = nil) -> ModifiedNode<Self> {
        let mod = GridPlacementModifier(column: column, row: row, area: area, justifySelf: justifySelf, placeSelf: placeSelf)
        return ModifiedNode(content: self, modifiers: [mod])
    }
}
