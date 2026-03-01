import ScoreCore

/// A single CSS property–value pair.
///
/// `CSSDeclaration` is the atomic unit of styling in ScoreCSS. A collection
/// of declarations forms a rule set that is associated with a scoped
/// selector by `CSSCollector`.
///
/// ### Example
///
/// ```swift
/// let declaration = CSSDeclaration(property: "padding", value: "16px")
/// // Renders as: padding: 16px;
/// ```
public struct CSSDeclaration: Sendable, Hashable {

    /// The CSS property name (e.g. `"padding"`, `"background-color"`).
    public let property: String

    /// The CSS value (e.g. `"16px"`, `"oklch(0.65 0.18 270)"`).
    public let value: String

    /// Creates a CSS declaration.
    ///
    /// - Parameters:
    ///   - property: The CSS property name.
    ///   - value: The CSS value.
    public init(property: String, value: String) {
        self.property = property
        self.value = value
    }

    /// Renders this declaration as a CSS string.
    ///
    /// - Returns: A string in the format `"property: value"`.
    public func render() -> String {
        "\(property): \(value)"
    }
}
