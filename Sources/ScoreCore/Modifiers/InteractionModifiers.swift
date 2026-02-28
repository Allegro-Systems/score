/// The visual style of the mouse cursor when hovering over a node.
///
/// `CursorStyle` maps directly to the CSS `cursor` property values, allowing
/// fine-grained control over the pointer appearance in response to user interaction.
///
/// ### CSS Mapping
///
/// Maps to the CSS `cursor` property.
public enum CursorStyle: String, Sendable {
    /// The browser determines the cursor based on context.
    ///
    /// CSS equivalent: `cursor: auto`.
    case auto

    /// A pointing hand, indicating an interactive element such as a link or button.
    ///
    /// CSS equivalent: `cursor: pointer`.
    case pointer

    /// A circle with a line through it, indicating the action is not permitted.
    ///
    /// CSS equivalent: `cursor: not-allowed`.
    case notAllowed = "not-allowed"

    /// An I-beam, indicating editable text content.
    ///
    /// CSS equivalent: `cursor: text`.
    case text

    /// A four-directional arrow, indicating that the element can be moved.
    ///
    /// CSS equivalent: `cursor: move`.
    case move

    /// An open hand, indicating the element can be grabbed and dragged.
    ///
    /// CSS equivalent: `cursor: grab`.
    case grab
}

/// Controls whether and how a user can select text within a node.
///
/// `UserSelectMode` maps to the CSS `user-select` property, giving precise control
/// over text-selection behavior for interactive or non-interactive content.
///
/// ### CSS Mapping
///
/// Maps to the CSS `user-select` property.
public enum UserSelectMode: String, Sendable {
    /// The browser's default selection behavior applies.
    ///
    /// CSS equivalent: `user-select: auto`.
    case auto

    /// Text selection is disabled entirely within the element.
    ///
    /// CSS equivalent: `user-select: none`.
    case none

    /// Only text content may be selected.
    ///
    /// CSS equivalent: `user-select: text`.
    case text

    /// Clicking the element selects all of its text content at once.
    ///
    /// CSS equivalent: `user-select: all`.
    case all
}

/// A modifier that sets the cursor style displayed when the pointer hovers over a node.
///
/// `CursorModifier` wraps a `CursorStyle` value and is applied through the
/// `.cursor(_:)` method on `Node`.
///
/// ### Example
///
/// ```swift
/// Button("Submit")
///     .cursor(.pointer)
/// ```
///
/// ### CSS Mapping
///
/// Maps to the CSS `cursor` property on the rendered element.
public struct CursorModifier: ModifierValue {
    /// The cursor style to apply on hover.
    public let style: CursorStyle

    /// Creates a cursor modifier with the given style.
    ///
    /// - Parameter style: The `CursorStyle` to apply when the pointer hovers over this node.
    public init(_ style: CursorStyle) {
        self.style = style
    }
}

/// A modifier that controls text-selection behavior within a node.
///
/// `UserSelectModifier` wraps a `UserSelectMode` value and is applied through
/// the `.userSelect(_:)` method on `Node`.
///
/// ### Example
///
/// ```swift
/// Text("Non-selectable label")
///     .userSelect(.none)
/// ```
///
/// ### CSS Mapping
///
/// Maps to the CSS `user-select` property on the rendered element.
public struct UserSelectModifier: ModifierValue {
    /// The text-selection mode to apply.
    public let mode: UserSelectMode

    /// Creates a user-select modifier with the given mode.
    ///
    /// - Parameter mode: The `UserSelectMode` that controls how text within this node can be selected.
    public init(_ mode: UserSelectMode) {
        self.mode = mode
    }
}

extension Node {
    /// Sets the cursor style displayed when the pointer hovers over this node.
    ///
    /// Use this modifier to communicate interactivity or provide affordance cues
    /// to the user through cursor changes.
    ///
    /// ### Example
    ///
    /// ```swift
    /// Box {
    ///     Text("Drag me")
    /// }
    /// .cursor(.grab)
    /// ```
    ///
    /// ### CSS Mapping
    ///
    /// Maps to the CSS `cursor` property on the rendered element.
    ///
    /// - Parameter style: The `CursorStyle` to display on hover.
    /// - Returns: A `ModifiedNode` with the cursor modifier applied.
    public func cursor(_ style: CursorStyle) -> ModifiedNode<Self> {
        ModifiedNode(content: self, modifiers: [CursorModifier(style)])
    }

    /// Controls whether and how a user can select text within this node.
    ///
    /// Use this modifier to prevent accidental text selection on UI chrome elements,
    /// or to make an entire element's content selectable in a single click.
    ///
    /// ### Example
    ///
    /// ```swift
    /// NavigationBar()
    ///     .userSelect(.none)
    /// ```
    ///
    /// ### CSS Mapping
    ///
    /// Maps to the CSS `user-select` property on the rendered element.
    ///
    /// - Parameter mode: The `UserSelectMode` to apply.
    /// - Returns: A `ModifiedNode` with the user-select modifier applied.
    public func userSelect(_ mode: UserSelectMode) -> ModifiedNode<Self> {
        ModifiedNode(content: self, modifiers: [UserSelectModifier(mode)])
    }
}
