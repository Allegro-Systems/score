/// A property wrapper that marks a closure as a client-side action.
///
/// `Action` identifies a closure that should be emitted as a plain
/// JavaScript function on the client. During server-side rendering the
/// wrapped closure is inert — it exists only to be discovered by the
/// compiler and emitted alongside the component's reactive signals.
///
/// On the client, the emitted function typically calls `.set()` on one or
/// more `Signal.State` values to trigger reactive updates.
///
/// ### Usage
///
/// ```swift
/// struct Counter: Component {
///     @State var count = 0
///     @Action var increment = { count += 1 }
///
///     var body: some Node {
///         Button("\(count)")
///             .on(.click, "increment")
///     }
/// }
/// ```
///
/// - Note: The closure must be `Sendable` to satisfy Swift 6 concurrency
///   requirements.
@propertyWrapper
public struct Action: Sendable {

    /// The action closure.
    ///
    /// During server-side rendering this closure is never invoked. On the
    /// client the compiler emits an equivalent JavaScript function.
    public var wrappedValue: @Sendable () -> Void

    /// Creates an action with the given closure.
    ///
    /// - Parameter wrappedValue: The closure that will be emitted as a
    ///   client-side JavaScript function.
    public init(wrappedValue: @escaping @Sendable () -> Void) {
        self.wrappedValue = wrappedValue
    }
}
