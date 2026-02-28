/// The animation style used when the browser scrolls to an anchor or programmatic target.
///
/// `ScrollBehavior` controls whether scrolling jumps instantly to the target position
/// or animates smoothly, mapping to the CSS `scroll-behavior` property.
///
/// ### CSS Mapping
///
/// Maps to the CSS `scroll-behavior` property.
public enum ScrollBehavior: String, Sendable {

    /// Scrolling jumps instantly to the target position.
    ///
    /// This is the default browser behaviour. Equivalent to CSS `auto`.
    case auto

    /// Scrolling animates smoothly to the target position.
    ///
    /// Equivalent to CSS `smooth`.
    case smooth
}

/// The axis or axes on which scroll snapping is enforced in a scroll container.
///
/// `ScrollSnapType` determines whether the scroll container snaps along the
/// horizontal axis, vertical axis, both, or not at all.
///
/// ### CSS Mapping
///
/// Maps to the CSS `scroll-snap-type` property.
public enum ScrollSnapType: String, Sendable {

    /// Scroll snapping is disabled.
    ///
    /// Equivalent to CSS `none`.
    case none

    /// Snapping is enforced on the horizontal axis.
    ///
    /// Equivalent to CSS `x`.
    case x

    /// Snapping is enforced on the vertical axis.
    ///
    /// Equivalent to CSS `y`.
    case y

    /// Snapping is enforced on the block axis (vertical in horizontal writing modes).
    ///
    /// Equivalent to CSS `block`.
    case block

    /// Snapping is enforced on the inline axis (horizontal in horizontal writing modes).
    ///
    /// Equivalent to CSS `inline`.
    case inline

    /// Snapping is enforced on both axes simultaneously.
    ///
    /// Equivalent to CSS `both`.
    case both
}

/// The position within a snap container at which a scroll snap item aligns.
///
/// `ScrollSnapAlign` is applied to individual scroll snap items to control
/// which edge or center of the item aligns with the snap container's snap port.
///
/// ### CSS Mapping
///
/// Maps to the CSS `scroll-snap-align` property.
public enum ScrollSnapAlign: String, Sendable {

    /// No snap alignment is applied to this item.
    ///
    /// Equivalent to CSS `none`.
    case none

    /// The start edge of the item aligns with the snap port.
    ///
    /// Equivalent to CSS `start`.
    case start

    /// The center of the item aligns with the snap port.
    ///
    /// Equivalent to CSS `center`.
    case center

    /// The end edge of the item aligns with the snap port.
    ///
    /// Equivalent to CSS `end`.
    case end
}

/// A modifier that controls the animation behaviour of programmatic or anchor scrolling.
///
/// `ScrollBehaviorModifier` applies the CSS `scroll-behavior` property to a scroll
/// container, determining whether navigating to an in-page anchor or running
/// `scrollIntoView()` produces an instant jump or a smooth animation.
///
/// ### Example
///
/// ```swift
/// Div {
///     Section(id: "intro") { ... }
///     Section(id: "features") { ... }
/// }
/// .overflow(.scroll)
/// .scrollBehavior(.smooth)
/// ```
///
/// ### CSS Mapping
///
/// Maps to the CSS `scroll-behavior` property on the rendered element.
public struct ScrollBehaviorModifier: ModifierValue {

    /// The scroll animation behaviour to apply.
    ///
    /// Equivalent to CSS `scroll-behavior`.
    public let behavior: ScrollBehavior

    /// Creates a scroll behavior modifier.
    ///
    /// - Parameter behavior: The scroll animation behaviour to apply.
    public init(_ behavior: ScrollBehavior) {
        self.behavior = behavior
    }
}

/// A modifier that sets the scroll margin of an element within a snap container.
///
/// `ScrollMarginModifier` applies the CSS `scroll-margin` property, which adds
/// space between the element's snap position and the edge of the scroll container's
/// snap port. This is useful for offsetting a sticky header that would otherwise
/// obscure the snapped item.
///
/// ### Example
///
/// ```swift
/// Section(id: "features") {
///     Text("Features")
/// }
/// .scrollMargin(64)
/// ```
///
/// ### CSS Mapping
///
/// Maps to the CSS `scroll-margin` shorthand property on the rendered element.
public struct ScrollMarginModifier: ModifierValue {

    /// The scroll margin to apply on all sides, in points.
    ///
    /// Equivalent to CSS `scroll-margin`.
    public let value: Double

    /// Creates a scroll margin modifier.
    ///
    /// - Parameter value: The margin to apply around the element's snap position, in points.
    public init(_ value: Double) {
        self.value = value
    }
}

/// A modifier that sets the scroll padding of a scroll container.
///
/// `ScrollPaddingModifier` applies the CSS `scroll-padding` property, which defines
/// insets on the scroll container's snap port. Items snapping into view will align
/// within the padded area rather than the raw edge of the container.
///
/// ### Example
///
/// ```swift
/// Div {
///     Card()
///     Card()
/// }
/// .overflow(x: .scroll)
/// .scrollSnap(type: .x, align: .start)
/// .scrollPadding(16)
/// ```
///
/// ### CSS Mapping
///
/// Maps to the CSS `scroll-padding` shorthand property on the rendered element.
public struct ScrollPaddingModifier: ModifierValue {

    /// The scroll padding to apply on all sides of the scroll container, in points.
    ///
    /// Equivalent to CSS `scroll-padding`.
    public let value: Double

    /// Creates a scroll padding modifier.
    ///
    /// - Parameter value: The padding around the snap port, in points.
    public init(_ value: Double) {
        self.value = value
    }
}

/// A modifier that enables scroll snapping on a container or aligns an item within one.
///
/// `ScrollSnapModifier` combines the `scroll-snap-type` property (applied to the
/// scroll container) and the `scroll-snap-align` property (applied to snap items)
/// into a single modifier. The `type` value configures the container's snap axis,
/// while the optional `align` value controls where each child item snaps.
///
/// ### Example
///
/// ```swift
/// Div {
///     Slide()
///     Slide()
///     Slide()
/// }
/// .overflow(x: .scroll)
/// .scrollSnap(type: .x, align: .center)
/// ```
///
/// ### CSS Mapping
///
/// Maps to the CSS `scroll-snap-type` and `scroll-snap-align` properties
/// on the rendered element.
public struct ScrollSnapModifier: ModifierValue {

    /// The snapping axis applied to the scroll container.
    ///
    /// Equivalent to CSS `scroll-snap-type`.
    public let type: ScrollSnapType

    /// The snap alignment applied to child snap items.
    ///
    /// When `nil`, the CSS `scroll-snap-align` property is not set.
    public let align: ScrollSnapAlign?

    /// Creates a scroll snap modifier.
    ///
    /// - Parameters:
    ///   - type: The snapping axis for the scroll container.
    ///   - align: The snap alignment for child items. Defaults to `nil`.
    public init(type: ScrollSnapType, align: ScrollSnapAlign? = nil) {
        self.type = type
        self.align = align
    }
}

extension Node {

    /// Sets the animation behaviour for scrolling triggered by anchors or scripts.
    ///
    /// Apply this modifier to a scrollable container to make in-page navigation
    /// feel smooth rather than instant.
    ///
    /// ### Example
    ///
    /// ```swift
    /// Div {
    ///     Section(id: "about") { Text("About") }
    ///     Section(id: "contact") { Text("Contact") }
    /// }
    /// .overflow(.scroll)
    /// .scrollBehavior(.smooth)
    /// ```
    ///
    /// ### CSS Mapping
    ///
    /// Maps to the CSS `scroll-behavior` property.
    ///
    /// - Parameter behavior: The scroll animation behaviour to apply.
    /// - Returns: A modified node with the scroll-behavior style applied.
    public func scrollBehavior(_ behavior: ScrollBehavior) -> ModifiedNode<Self> {
        ModifiedNode(content: self, modifiers: [ScrollBehaviorModifier(behavior)])
    }

    /// Sets the scroll margin so the element's snap point is offset from the container edge.
    ///
    /// Use this to account for fixed or sticky headers that would otherwise obscure
    /// the top of an element when it snaps into view.
    ///
    /// ### Example
    ///
    /// ```swift
    /// Section(id: "pricing") {
    ///     Text("Pricing")
    /// }
    /// .scrollMargin(80)
    /// ```
    ///
    /// ### CSS Mapping
    ///
    /// Maps to the CSS `scroll-margin` property.
    ///
    /// - Parameter value: The margin around the element's snap position, in points.
    /// - Returns: A modified node with the scroll-margin style applied.
    public func scrollMargin(_ value: Double) -> ModifiedNode<Self> {
        ModifiedNode(content: self, modifiers: [ScrollMarginModifier(value)])
    }

    /// Sets the padding of the scroll container's snap port.
    ///
    /// Apply this to the scroll container to inset the area within which snap items
    /// align, preventing them from snapping flush against the container edge.
    ///
    /// ### Example
    ///
    /// ```swift
    /// Div {
    ///     Card()
    ///     Card()
    /// }
    /// .overflow(x: .scroll)
    /// .scrollSnap(type: .x, align: .start)
    /// .scrollPadding(24)
    /// ```
    ///
    /// ### CSS Mapping
    ///
    /// Maps to the CSS `scroll-padding` property.
    ///
    /// - Parameter value: The padding around the scroll container's snap port, in points.
    /// - Returns: A modified node with the scroll-padding style applied.
    public func scrollPadding(_ value: Double) -> ModifiedNode<Self> {
        ModifiedNode(content: self, modifiers: [ScrollPaddingModifier(value)])
    }

    /// Enables scroll snapping on the element and optionally aligns its snap children.
    ///
    /// Apply this modifier to a scrollable container to make it snap to its children
    /// as the user scrolls. The `type` parameter sets the snap axis on the container,
    /// and the optional `align` parameter sets the snap alignment on each snap item.
    ///
    /// ### Example
    ///
    /// ```swift
    /// Div {
    ///     Slide()
    ///     Slide()
    ///     Slide()
    /// }
    /// .overflow(x: .scroll)
    /// .scrollSnap(type: .x, align: .start)
    /// ```
    ///
    /// ### CSS Mapping
    ///
    /// Maps to the CSS `scroll-snap-type` and `scroll-snap-align` properties.
    ///
    /// - Parameters:
    ///   - type: The snapping axis for the scroll container.
    ///   - align: The snap alignment for child items. Defaults to `nil`.
    /// - Returns: A modified node with the scroll-snap styles applied.
    public func scrollSnap(type: ScrollSnapType, align: ScrollSnapAlign? = nil) -> ModifiedNode<Self> {
        ModifiedNode(content: self, modifiers: [ScrollSnapModifier(type: type, align: align)])
    }
}
