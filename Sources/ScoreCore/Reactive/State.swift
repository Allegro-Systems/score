/// A property wrapper that declares a piece of mutable, reactive state.
///
/// `State` marks a stored property as a reactive signal. During server-side
/// rendering, `wrappedValue` returns the initial value so that the first
/// paint contains correct content. On the client, the Score compiler emits a
/// `Signal.State` that tracks reads and writes, allowing the reactive engine
/// to update only the DOM nodes that depend on the value.
///
/// ### Usage
///
/// ```swift
/// struct Counter: Component {
///     @State var count = 0
///
///     var body: some Node {
///         Button("\(count)")
///             .on(.click, "increment")
///     }
/// }
/// ```
///
/// - Note: `State` is `Sendable` when its `Value` type is `Sendable`, which
///   is required for all properties used within `Node` trees.
@propertyWrapper
public struct State<Value: Sendable>: Sendable {

    /// The underlying stored value.
    ///
    /// During server-side rendering this is the initial value provided at
    /// declaration. On the client the compiler replaces access with a
    /// `Signal.State` read.
    public var wrappedValue: Value

    /// Creates a reactive state property with the given initial value.
    ///
    /// - Parameter wrappedValue: The initial value for this state property.
    public init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }
}
