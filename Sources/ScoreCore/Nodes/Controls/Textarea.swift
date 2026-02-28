/// A node that renders a multi-line plain-text editing control.
///
/// `TextArea` renders as the HTML `<textarea>` element, allowing users to enter
/// freeform text that may span multiple lines. Unlike a single-line text input,
/// it is well suited for longer content such as messages, descriptions, and
/// comments.
///
/// Typical uses include:
/// - Comment or review submission fields
/// - Bio or description sections in a profile form
/// - Support ticket or feedback message bodies
///
/// ### Example
///
/// ```swift
/// TextArea(
///     name: "message",
///     placeholder: "Write your message here…",
///     rows: 6,
///     id: "message-input",
///     required: true
/// )
/// ```
///
/// - Important: Always associate a `<label>` with the textarea's `id` so that
///   screen readers can identify the control correctly.
public struct TextArea: Node {

    /// The name submitted with the form data when the form is posted.
    ///
    /// If `nil`, the content of the textarea is not included in the form
    /// submission.
    public let name: String?

    /// Short hint text displayed inside the control when it has no value.
    ///
    /// Rendered as the HTML `placeholder` attribute. Disappears as soon as the
    /// user begins typing.
    public let placeholder: String?

    /// The pre-filled text content of the textarea.
    ///
    /// Rendered as the text node inside the HTML `<textarea>` element. If `nil`,
    /// the textarea is initially empty.
    public let value: String?

    /// The visible number of text lines displayed by the control.
    ///
    /// Rendered as the HTML `rows` attribute. If `nil`, the browser uses its
    /// default height.
    public let rows: Int?

    /// The visible width of the control measured in average character widths.
    ///
    /// Rendered as the HTML `cols` attribute. If `nil`, the browser uses its
    /// default width.
    public let columns: Int?

    /// The unique identifier used to associate this control with a `<label>`.
    ///
    /// If `nil`, no `id` attribute is rendered.
    public let id: String?

    /// Whether the user must enter a value before the form can be submitted.
    ///
    /// When `true`, renders the HTML `required` attribute.
    public let isRequired: Bool

    /// Whether the control is non-interactive and its content cannot be changed.
    ///
    /// When `true`, renders the HTML `disabled` attribute. Unlike `isReadOnly`,
    /// a disabled textarea is not submitted with the form.
    public let isDisabled: Bool

    /// Whether the content of the control is non-editable but still submitted.
    ///
    /// When `true`, renders the HTML `readonly` attribute. The user can select
    /// and copy the text but cannot modify it. The value is still included in
    /// form submissions, unlike `isDisabled`.
    public let isReadOnly: Bool

    /// Creates a multi-line text editing control.
    ///
    /// - Parameters:
    ///   - name: The form field name submitted with the textarea's content.
    ///   - placeholder: Short hint text shown when the control is empty.
    ///   - value: Pre-filled text content displayed inside the control.
    ///   - rows: The visible number of text lines. Defaults to `nil` (browser default).
    ///   - columns: The visible character-width of the control. Defaults to `nil`
    ///     (browser default).
    ///   - id: An optional unique identifier for the element.
    ///   - required: When `true`, the user must fill in the field before submitting.
    ///   - disabled: When `true`, the control is non-interactive and excluded from
    ///     form submission.
    ///   - readOnly: When `true`, the content cannot be edited but is still submitted.
    public init(
        name: String? = nil,
        placeholder: String? = nil,
        value: String? = nil,
        rows: Int? = nil,
        columns: Int? = nil,
        id: String? = nil,
        required: Bool = false,
        disabled: Bool = false,
        readOnly: Bool = false
    ) {
        self.name = name
        self.placeholder = placeholder
        self.value = value
        self.rows = rows
        self.columns = columns
        self.id = id
        self.isRequired = required
        self.isDisabled = disabled
        self.isReadOnly = readOnly
    }

    public var body: Never { fatalError() }
}
