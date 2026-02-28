/// A named viewport-width breakpoint used to apply conditional styles.
///
/// `Breakpoint` represents the set of screen-size thresholds supported by Score.
/// Each case maps to a CSS `@media` query targeting a minimum or characteristic
/// viewport width, allowing layouts to adapt responsively.
///
/// ### CSS Mapping
///
/// Maps to CSS `@media` width queries on the rendered stylesheet.
public enum Breakpoint: String, Sendable {

    /// Targets compact viewports, typically narrow mobile screens.
    ///
    /// Equivalent to a small-width CSS media query (e.g. `@media (max-width: ...)`).
    case compact

    /// Targets wide mobile or small tablet viewports.
    ///
    /// Equivalent to a CSS media query for slightly wider viewports.
    case wide

    /// Targets tablet-sized viewports.
    ///
    /// Equivalent to a CSS media query for mid-range viewport widths.
    case tablet

    /// Targets large tablet or small desktop viewports.
    ///
    /// Equivalent to a CSS media query for larger viewport widths.
    case large

    /// Targets standard desktop viewports.
    ///
    /// Equivalent to a CSS media query for typical desktop viewport widths.
    case desktop

    /// Targets very wide or cinema-display viewports.
    ///
    /// Equivalent to a CSS media query for extra-large viewport widths.
    case cinema
}

/// A modifier that applies a transformed version of a node at a specific viewport breakpoint.
///
/// `BreakpointModifier` wraps a breakpoint and a transformed node, enabling Score's
/// rendering engine to emit `@media` queries that activate the contained styles only
/// when the viewport matches the specified breakpoint.
///
/// ### Example
///
/// ```swift
/// Div {
///     Text("Responsive")
/// }
/// .desktop { $0.flex(.row, gap: 24) }
/// ```
///
/// ### CSS Mapping
///
/// Maps to a CSS `@media` width query wrapping the modified styles.
public struct BreakpointModifier<Content: Node>: ModifierValue {

    /// The viewport breakpoint at which the contained styles become active.
    public let breakpoint: Breakpoint

    /// The transformed node whose styles are applied at the breakpoint.
    public let content: Content

    /// Creates a breakpoint modifier.
    ///
    /// - Parameters:
    ///   - breakpoint: The viewport breakpoint to target.
    ///   - content: The transformed node to render at the breakpoint.
    public init(_ breakpoint: Breakpoint, content: Content) {
        self.breakpoint = breakpoint
        self.content = content
    }
}

/// The system color scheme used to apply conditional styles.
///
/// `ColorScheme` represents a user's preferred color scheme as reported by the
/// operating system, enabling Score to emit `@media (prefers-color-scheme: ...)` queries.
///
/// ### CSS Mapping
///
/// Maps to the CSS `@media (prefers-color-scheme: ...)` media query.
public enum ColorScheme: String, Sendable {

    /// The light color scheme, typically a white or light-grey background.
    ///
    /// Equivalent to CSS `@media (prefers-color-scheme: light)`.
    case light

    /// The dark color scheme, typically a dark-grey or black background.
    ///
    /// Equivalent to CSS `@media (prefers-color-scheme: dark)`.
    case dark
}

/// A modifier that applies a transformed version of a node for a specific system color scheme.
///
/// `ColorSchemeModifier` enables Score's rendering engine to emit styles inside a
/// `@media (prefers-color-scheme: ...)` query, so that nodes can adapt their
/// appearance to the user's light or dark mode preference.
///
/// ### Example
///
/// ```swift
/// Div {
///     Text("Themed")
/// }
/// .dark { $0.background(.neutral(900)) }
/// ```
///
/// ### CSS Mapping
///
/// Maps to a CSS `@media (prefers-color-scheme: ...)` query wrapping the modified styles.
public struct ColorSchemeModifier<Content: Node>: ModifierValue {

    /// The color scheme under which the contained styles become active.
    public let scheme: ColorScheme

    /// The transformed node whose styles are applied under the color scheme.
    public let content: Content

    /// Creates a color scheme modifier.
    ///
    /// - Parameters:
    ///   - scheme: The color scheme to target.
    ///   - content: The transformed node to render under the scheme.
    public init(_ scheme: ColorScheme, content: Content) {
        self.scheme = scheme
        self.content = content
    }
}

/// A modifier that applies a transformed version of a node when a named CSS theme is active.
///
/// `NamedThemeModifier` enables Score's rendering engine to scope styles behind a
/// named CSS data attribute or class selector, allowing application-level theme
/// switching without media queries.
///
/// ### Example
///
/// ```swift
/// Div {
///     Text("Branded")
/// }
/// .theme("brand-blue") { $0.background(.custom("brand", shade: 600)) }
/// ```
///
/// ### CSS Mapping
///
/// Maps to a CSS selector scope such as `[data-theme="<name>"]` wrapping the modified styles.
public struct NamedThemeModifier<Content: Node>: ModifierValue {

    /// The name of the CSS theme scope to target.
    public let name: String

    /// The transformed node whose styles are applied within the named theme.
    public let content: Content

    /// Creates a named theme modifier.
    ///
    /// - Parameters:
    ///   - name: The theme name used to scope the styles.
    ///   - content: The transformed node to render within the theme.
    public init(_ name: String, content: Content) {
        self.name = name
        self.content = content
    }
}

extension Node {

    /// Applies a transformed version of the node when the viewport matches the compact breakpoint.
    ///
    /// Use this modifier to override or extend styles for narrow mobile viewports.
    /// The closure receives the current node and returns the modified version to
    /// apply at the breakpoint.
    ///
    /// ### Example
    ///
    /// ```swift
    /// Div {
    ///     Text("Content")
    /// }
    /// .flex(.row, gap: 16)
    /// .compact { $0.flex(.column) }
    /// ```
    ///
    /// ### CSS Mapping
    ///
    /// Maps to a CSS `@media` compact-width query wrapping the modified styles.
    ///
    /// - Parameter transform: A closure that receives the node and returns its modified form.
    /// - Returns: A modified node that activates the transformation at the compact breakpoint.
    public func compact<Modified: Node>(@NodeBuilder _ transform: (Self) -> Modified) -> ModifiedNode<Self> {
        ModifiedNode(content: self, modifiers: [BreakpointModifier(.compact, content: transform(self))])
    }

    /// Applies a transformed version of the node when the viewport matches the wide breakpoint.
    ///
    /// ### Example
    ///
    /// ```swift
    /// Div {
    ///     Text("Content")
    /// }
    /// .wide { $0.size(maxWidth: 640) }
    /// ```
    ///
    /// ### CSS Mapping
    ///
    /// Maps to a CSS `@media` wide-width query wrapping the modified styles.
    ///
    /// - Parameter transform: A closure that receives the node and returns its modified form.
    /// - Returns: A modified node that activates the transformation at the wide breakpoint.
    public func wide<Modified: Node>(@NodeBuilder _ transform: (Self) -> Modified) -> ModifiedNode<Self> {
        ModifiedNode(content: self, modifiers: [BreakpointModifier(.wide, content: transform(self))])
    }

    /// Applies a transformed version of the node when the viewport matches the tablet breakpoint.
    ///
    /// ### Example
    ///
    /// ```swift
    /// Div {
    ///     Text("Content")
    /// }
    /// .tablet { $0.grid(columns: 2, gap: 16) }
    /// ```
    ///
    /// ### CSS Mapping
    ///
    /// Maps to a CSS `@media` tablet-width query wrapping the modified styles.
    ///
    /// - Parameter transform: A closure that receives the node and returns its modified form.
    /// - Returns: A modified node that activates the transformation at the tablet breakpoint.
    public func tablet<Modified: Node>(@NodeBuilder _ transform: (Self) -> Modified) -> ModifiedNode<Self> {
        ModifiedNode(content: self, modifiers: [BreakpointModifier(.tablet, content: transform(self))])
    }

    /// Applies a transformed version of the node when the viewport matches the large breakpoint.
    ///
    /// ### Example
    ///
    /// ```swift
    /// Div {
    ///     Text("Content")
    /// }
    /// .large { $0.grid(columns: 3, gap: 24) }
    /// ```
    ///
    /// ### CSS Mapping
    ///
    /// Maps to a CSS `@media` large-width query wrapping the modified styles.
    ///
    /// - Parameter transform: A closure that receives the node and returns its modified form.
    /// - Returns: A modified node that activates the transformation at the large breakpoint.
    public func large<Modified: Node>(@NodeBuilder _ transform: (Self) -> Modified) -> ModifiedNode<Self> {
        ModifiedNode(content: self, modifiers: [BreakpointModifier(.large, content: transform(self))])
    }

    /// Applies a transformed version of the node when the viewport matches the desktop breakpoint.
    ///
    /// ### Example
    ///
    /// ```swift
    /// Div {
    ///     Text("Content")
    /// }
    /// .desktop { $0.grid(columns: 4, gap: 32) }
    /// ```
    ///
    /// ### CSS Mapping
    ///
    /// Maps to a CSS `@media` desktop-width query wrapping the modified styles.
    ///
    /// - Parameter transform: A closure that receives the node and returns its modified form.
    /// - Returns: A modified node that activates the transformation at the desktop breakpoint.
    public func desktop<Modified: Node>(@NodeBuilder _ transform: (Self) -> Modified) -> ModifiedNode<Self> {
        ModifiedNode(content: self, modifiers: [BreakpointModifier(.desktop, content: transform(self))])
    }

    /// Applies a transformed version of the node when the viewport matches the cinema breakpoint.
    ///
    /// ### Example
    ///
    /// ```swift
    /// Div {
    ///     Text("Content")
    /// }
    /// .cinema { $0.size(maxWidth: 1920) }
    /// ```
    ///
    /// ### CSS Mapping
    ///
    /// Maps to a CSS `@media` cinema-width query wrapping the modified styles.
    ///
    /// - Parameter transform: A closure that receives the node and returns its modified form.
    /// - Returns: A modified node that activates the transformation at the cinema breakpoint.
    public func cinema<Modified: Node>(@NodeBuilder _ transform: (Self) -> Modified) -> ModifiedNode<Self> {
        ModifiedNode(content: self, modifiers: [BreakpointModifier(.cinema, content: transform(self))])
    }

    /// Applies a transformed version of the node when the user's system is in light mode.
    ///
    /// ### Example
    ///
    /// ```swift
    /// Div {
    ///     Text("Hello")
    /// }
    /// .light { $0.background(.surface) }
    /// ```
    ///
    /// ### CSS Mapping
    ///
    /// Maps to a CSS `@media (prefers-color-scheme: light)` query wrapping the modified styles.
    ///
    /// - Parameter transform: A closure that receives the node and returns its modified form.
    /// - Returns: A modified node that activates the transformation in light mode.
    public func light<Modified: Node>(@NodeBuilder _ transform: (Self) -> Modified) -> ModifiedNode<Self> {
        ModifiedNode(content: self, modifiers: [ColorSchemeModifier(.light, content: transform(self))])
    }

    /// Applies a transformed version of the node when the user's system is in dark mode.
    ///
    /// ### Example
    ///
    /// ```swift
    /// Div {
    ///     Text("Hello")
    /// }
    /// .dark { $0.background(.neutral(900)) }
    /// ```
    ///
    /// ### CSS Mapping
    ///
    /// Maps to a CSS `@media (prefers-color-scheme: dark)` query wrapping the modified styles.
    ///
    /// - Parameter transform: A closure that receives the node and returns its modified form.
    /// - Returns: A modified node that activates the transformation in dark mode.
    public func dark<Modified: Node>(@NodeBuilder _ transform: (Self) -> Modified) -> ModifiedNode<Self> {
        ModifiedNode(content: self, modifiers: [ColorSchemeModifier(.dark, content: transform(self))])
    }

    /// Applies a transformed version of the node when a named CSS theme is active.
    ///
    /// Use this modifier to scope style overrides behind an application-level theme
    /// name. The rendering engine wraps the styles in a selector such as
    /// `[data-theme="<name>"]`, allowing you to switch themes by toggling an
    /// attribute on a root element.
    ///
    /// ### Example
    ///
    /// ```swift
    /// Div {
    ///     Text("Brand content")
    /// }
    /// .theme("high-contrast") { $0.background(.neutral(50)) }
    /// ```
    ///
    /// ### CSS Mapping
    ///
    /// Maps to a CSS `[data-theme="<name>"]` selector scope wrapping the modified styles.
    ///
    /// - Parameters:
    ///   - name: The theme name used to scope the styles.
    ///   - transform: A closure that receives the node and returns its modified form.
    /// - Returns: A modified node that activates the transformation under the named theme.
    public func theme<Modified: Node>(_ name: String, @NodeBuilder _ transform: (Self) -> Modified) -> ModifiedNode<Self> {
        ModifiedNode(content: self, modifiers: [NamedThemeModifier(name, content: transform(self))])
    }
}
