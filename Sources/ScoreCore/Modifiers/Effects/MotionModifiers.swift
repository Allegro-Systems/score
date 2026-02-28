/// A modifier that applies a CSS transform to a node.
///
/// `TransformModifier` accepts a raw CSS transform string, providing full access
/// to all CSS transform functions such as `translate()`, `rotate()`, `scale()`,
/// `skew()`, and their 3D equivalents. Multiple transform functions can be
/// combined in a single string and are applied left-to-right.
///
/// ### Example
///
/// ```swift
/// Icon()
///     .transform("rotate(45deg)")
///
/// Badge()
///     .transform("translate(-50%, -50%) scale(1.1)")
/// ```
///
/// ### CSS Mapping
///
/// Maps to the CSS `transform` property on the rendered element.
public struct TransformModifier: ModifierValue {
    /// The raw CSS transform string, such as `"rotate(45deg)"` or `"scale(1.2) translateY(-4px)"`.
    public let value: String

    /// Creates a transform modifier with the given CSS transform string.
    ///
    /// - Parameter value: A CSS transform function string (e.g., `"translateX(10px)"`, `"rotate(90deg) scale(0.9)"`).
    public init(_ value: String) {
        self.value = value
    }
}

/// A modifier that animates CSS property changes on a node over time.
///
/// `TransitionModifier` defines a CSS transition for a specific property,
/// controlling how the property animates from one value to another when it changes.
/// The duration is specified in seconds, and an optional easing function and
/// delay can be applied.
///
/// ### Example
///
/// ```swift
/// Button("Hover me")
///     .transition(property: "background-color", duration: 0.2, timing: "ease-in-out")
///
/// Panel()
///     .transition(property: "opacity", duration: 0.3, timing: "ease-out", delay: 0.1)
/// ```
///
/// ### CSS Mapping
///
/// Maps to the CSS `transition` shorthand property on the rendered element,
/// rendered as `transition: {property} {duration}s {timing} {delay}s`.
public struct TransitionModifier: ModifierValue {
    /// The CSS property name to transition, such as `"opacity"` or `"background-color"`.
    public let property: String

    /// The duration of the transition animation in seconds.
    public let duration: Double

    /// The CSS easing function for the transition, such as `"ease"`, `"linear"`, or `"cubic-bezier(...)"`
    ///
    /// When `nil`, the browser's default easing (`ease`) is used.
    public let timing: String?

    /// The delay in seconds before the transition begins.
    ///
    /// When `nil`, the transition starts immediately.
    public let delay: Double?

    /// Creates a transition modifier.
    ///
    /// - Parameters:
    ///   - property: The CSS property to animate (e.g., `"opacity"`, `"transform"`).
    ///   - duration: The animation duration in seconds.
    ///   - timing: Optional CSS easing function string.
    ///   - delay: Optional delay in seconds before the animation starts.
    public init(property: String, duration: Double, timing: String? = nil, delay: Double? = nil) {
        self.property = property
        self.duration = duration
        self.timing = timing
        self.delay = delay
    }
}

/// A modifier that plays a named CSS keyframe animation on a node.
///
/// `AnimationModifier` references a `@keyframes` animation by name and
/// configures its playback through duration, easing, delay, iteration count,
/// direction, and fill mode. All parameters beyond `name` and `duration` are
/// optional and fall back to CSS defaults when omitted.
///
/// ### Example
///
/// ```swift
/// Spinner()
///     .animation(name: "spin", duration: 1.0, timing: "linear", iterationCount: "infinite")
///
/// Toast()
///     .animation(name: "fadeIn", duration: 0.3, timing: "ease-out", fillMode: "forwards")
/// ```
///
/// ### CSS Mapping
///
/// Maps to the CSS `animation` shorthand property on the rendered element.
public struct AnimationModifier: ModifierValue {
    /// The name of the `@keyframes` animation to play.
    public let name: String

    /// The duration of one animation cycle in seconds.
    public let duration: Double

    /// The CSS easing function for the animation, such as `"ease"`, `"linear"`, or `"cubic-bezier(0.4, 0, 0.2, 1)"`.
    ///
    /// When `nil`, the browser's default easing (`ease`) is used.
    public let timing: String?

    /// The delay in seconds before the animation begins.
    ///
    /// When `nil`, the animation starts immediately.
    public let delay: Double?

    /// How many times the animation repeats.
    ///
    /// Accepts numeric strings like `"2"` or the keyword `"infinite"`.
    /// When `nil`, the animation plays once.
    public let iterationCount: String?

    /// The direction in which the animation plays.
    ///
    /// Common values: `"normal"`, `"reverse"`, `"alternate"`, `"alternate-reverse"`.
    /// When `nil`, `"normal"` is used.
    public let direction: String?

    /// How styles are applied before and after the animation executes.
    ///
    /// Common values: `"none"`, `"forwards"`, `"backwards"`, `"both"`.
    /// When `nil`, `"none"` is used.
    public let fillMode: String?

    /// Creates an animation modifier.
    ///
    /// - Parameters:
    ///   - name: The `@keyframes` animation name.
    ///   - duration: The duration of one animation cycle in seconds.
    ///   - timing: Optional CSS easing function string.
    ///   - delay: Optional delay in seconds before the animation starts.
    ///   - iterationCount: Optional iteration count, such as `"2"` or `"infinite"`.
    ///   - direction: Optional playback direction, such as `"alternate"`.
    ///   - fillMode: Optional fill mode, such as `"forwards"` or `"both"`.
    public init(name: String, duration: Double, timing: String? = nil, delay: Double? = nil, iterationCount: String? = nil, direction: String? = nil, fillMode: String? = nil) {
        self.name = name
        self.duration = duration
        self.timing = timing
        self.delay = delay
        self.iterationCount = iterationCount
        self.direction = direction
        self.fillMode = fillMode
    }
}

extension Node {
    /// Applies a CSS transform to this node.
    ///
    /// Use CSS transform functions such as `translate()`, `rotate()`, `scale()`,
    /// and `skew()`. Multiple functions can be chained in a single string.
    ///
    /// ### Example
    ///
    /// ```swift
    /// Icon()
    ///     .transform("rotate(45deg)")
    ///
    /// Tooltip()
    ///     .transform("translate(-50%, -100%)")
    /// ```
    ///
    /// ### CSS Mapping
    ///
    /// Maps to the CSS `transform` property on the rendered element.
    ///
    /// - Parameter value: A CSS transform function string.
    /// - Returns: A `ModifiedNode` with the transform modifier applied.
    public func transform(_ value: String) -> ModifiedNode<Self> {
        ModifiedNode(content: self, modifiers: [TransformModifier(value)])
    }

    /// Animates changes to a CSS property on this node over time.
    ///
    /// When the specified property's value changes (e.g., on hover or state change),
    /// the browser will animate the change according to the configured duration,
    /// easing, and delay.
    ///
    /// ### Example
    ///
    /// ```swift
    /// Button("Hover me")
    ///     .transition(property: "opacity", duration: 0.2, timing: "ease-in-out")
    ///
    /// Drawer()
    ///     .transition(property: "transform", duration: 0.35, timing: "cubic-bezier(0.4,0,0.2,1)")
    /// ```
    ///
    /// ### CSS Mapping
    ///
    /// Maps to the CSS `transition` shorthand property on the rendered element.
    ///
    /// - Parameters:
    ///   - property: The CSS property to animate (e.g., `"opacity"`, `"transform"`).
    ///   - duration: The animation duration in seconds.
    ///   - timing: Optional CSS easing function string. Defaults to `nil`.
    ///   - delay: Optional delay in seconds before the animation starts. Defaults to `nil`.
    /// - Returns: A `ModifiedNode` with the transition modifier applied.
    public func transition(property: String, duration: Double, timing: String? = nil, delay: Double? = nil) -> ModifiedNode<Self> {
        let mod = TransitionModifier(property: property, duration: duration, timing: timing, delay: delay)
        return ModifiedNode(content: self, modifiers: [mod])
    }

    /// Plays a named CSS keyframe animation on this node.
    ///
    /// The animation name must correspond to a `@keyframes` rule defined in
    /// the project's CSS. Use the optional parameters to control playback behavior.
    ///
    /// ### Example
    ///
    /// ```swift
    /// LoadingSpinner()
    ///     .animation(name: "spin", duration: 1.0, timing: "linear", iterationCount: "infinite")
    ///
    /// Notification()
    ///     .animation(name: "slideIn", duration: 0.4, timing: "ease-out", fillMode: "forwards")
    /// ```
    ///
    /// ### CSS Mapping
    ///
    /// Maps to the CSS `animation` shorthand property on the rendered element.
    ///
    /// - Parameters:
    ///   - name: The `@keyframes` animation name.
    ///   - duration: The duration of one animation cycle in seconds.
    ///   - timing: Optional CSS easing function string. Defaults to `nil`.
    ///   - delay: Optional delay in seconds before the animation starts. Defaults to `nil`.
    ///   - iterationCount: Optional iteration count, such as `"2"` or `"infinite"`. Defaults to `nil`.
    ///   - direction: Optional playback direction, such as `"alternate"`. Defaults to `nil`.
    ///   - fillMode: Optional fill mode, such as `"forwards"`. Defaults to `nil`.
    /// - Returns: A `ModifiedNode` with the animation modifier applied.
    public func animation(
        name: String, duration: Double, timing: String? = nil, delay: Double? = nil, iterationCount: String? = nil, direction: String? = nil, fillMode: String? = nil
    ) -> ModifiedNode<Self> {
        let mod = AnimationModifier(name: name, duration: duration, timing: timing, delay: delay, iterationCount: iterationCount, direction: direction, fillMode: fillMode)
        return ModifiedNode(content: self, modifiers: [mod])
    }
}
