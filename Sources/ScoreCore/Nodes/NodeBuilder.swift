/// A result builder that constructs a `Node` tree from a block of node
/// expressions.
///
/// `NodeBuilder` is the engine behind Score's declarative UI syntax. Apply
/// the `@NodeBuilder` attribute to a function, computed property, or closure
/// parameter to enable the DSL:
///
/// ```swift
/// struct Page: Node {
///     @NodeBuilder
///     var body: some Node {
///         HeaderNode(title: "Welcome")
///         BodyNode(text: "Hello, Score!")
///         FooterNode()
///     }
/// }
/// ```
///
/// ### Supported Syntax
///
/// | Builder block content | Produced node type |
/// |---|---|
/// | No statements | `EmptyNode` |
/// | A single node expression | The node itself (identity) |
/// | Two or more node expressions | `TupleNode<...>` |
/// | A bare `String` literal | `TextNode` |
/// | `if`/`else` | `ConditionalNode<T, F>` |
/// | `if` without `else` | `OptionalNode<C>` |
/// | `for`/`while` loop | `ArrayNode<C>` |
///
/// ### String Literals
///
/// `@NodeBuilder` promotes bare `String` values to `TextNode` automatically,
/// so you can write:
///
/// ```swift
/// var body: some Node {
///     "Hello, world!"
/// }
/// ```
///
/// - Note: `NodeBuilder` conforms to Swift's `@resultBuilder` protocol.
///   You do not call its static methods directly — the compiler transforms
///   builder block syntax into calls to the appropriate `build*` methods.
@resultBuilder
public struct NodeBuilder {

    /// Produces an `EmptyNode` from a builder block that contains no
    /// statements.
    ///
    /// This method is called by the compiler when a `@NodeBuilder` block is
    /// completely empty. It allows writing `{}` without producing a compile
    /// error.
    ///
    /// - Returns: An `EmptyNode` that renders nothing.
    public static func buildBlock() -> EmptyNode {
        EmptyNode()
    }

    /// Returns a single-node block unchanged.
    ///
    /// When the builder block contains exactly one statement that is already
    /// a `Node`, the compiler calls this overload. No wrapping occurs, so
    /// the concrete node type is preserved.
    ///
    /// - Parameter component: The sole node in the builder block.
    /// - Returns: The same node, unmodified.
    public static func buildBlock<C: Node>(_ component: C) -> C {
        component
    }

    /// Groups multiple heterogeneous node expressions into a `TupleNode`.
    ///
    /// When a builder block contains two or more statements, the compiler
    /// calls this variadic overload and wraps all children in a
    /// `TupleNode`, preserving the static type of each child via Swift's
    /// parameter pack generics.
    ///
    /// - Parameter components: A variadic pack of the individual nodes
    ///   declared in the builder block.
    /// - Returns: A `TupleNode` containing all provided child nodes.
    public static func buildBlock<each C: Node>(_ components: repeat each C) -> TupleNode<repeat each C> {
        TupleNode(repeat each components)
    }

    /// Lifts a `Node`-conforming expression into the builder pipeline.
    ///
    /// The compiler calls this method for each statement in the builder
    /// block that produces a `Node`. Because it returns the input unchanged,
    /// the concrete type is fully preserved.
    ///
    /// - Parameter expression: A node expression from the builder block.
    /// - Returns: The same node, unmodified.
    public static func buildExpression<C: Node>(_ expression: C) -> C {
        expression
    }

    /// Lifts a bare `String` expression into a `TextNode`.
    ///
    /// This overload enables string literals and `String` values to be used
    /// directly inside `@NodeBuilder` blocks without explicitly wrapping
    /// them in `TextNode`:
    ///
    /// ```swift
    /// var body: some Node {
    ///     "Score is great!"   // Becomes TextNode("Score is great!")
    /// }
    /// ```
    ///
    /// - Parameter expression: A `String` value from the builder block.
    /// - Returns: A `TextNode` wrapping the given string.
    public static func buildExpression(_ expression: String) -> TextNode {
        TextNode(expression)
    }

    /// Wraps an optional node in an `OptionalNode`.
    ///
    /// The compiler calls this method when a `@NodeBuilder` block contains
    /// a standalone `if` statement without a matching `else` clause. When
    /// the condition is `false`, `component` is `nil` and `OptionalNode`
    /// renders nothing.
    ///
    /// - Parameter component: The conditionally-present node, or `nil`.
    /// - Returns: An `OptionalNode` that renders `component` when non-`nil`.
    public static func buildOptional<C: Node>(_ component: C?) -> OptionalNode<C> {
        OptionalNode(component)
    }

    /// Produces a `ConditionalNode` from the true branch of an `if`/`else`.
    ///
    /// The compiler calls this method for the `if` branch when a builder
    /// block contains an `if`/`else` statement. It stores the true-branch
    /// node in `ConditionalNode.Storage.first`.
    ///
    /// - Parameter component: The node produced by the `if` branch.
    /// - Returns: A `ConditionalNode` whose `storage` is `.first(component)`.
    public static func buildEither<T: Node, F: Node>(first component: T) -> ConditionalNode<T, F> {
        ConditionalNode(storage: .first(component))
    }

    /// Produces a `ConditionalNode` from the false branch of an `if`/`else`.
    ///
    /// The compiler calls this method for the `else` branch when a builder
    /// block contains an `if`/`else` statement. It stores the false-branch
    /// node in `ConditionalNode.Storage.second`.
    ///
    /// - Parameter component: The node produced by the `else` branch.
    /// - Returns: A `ConditionalNode` whose `storage` is `.second(component)`.
    public static func buildEither<T: Node, F: Node>(second component: F) -> ConditionalNode<T, F> {
        ConditionalNode(storage: .second(component))
    }

    /// Collects the nodes produced by a loop into an `ArrayNode`.
    ///
    /// The compiler calls this method when a builder block contains a `for`
    /// loop or other imperative iteration. All nodes produced by successive
    /// loop iterations are collected into an array and wrapped in an
    /// `ArrayNode`.
    ///
    /// ```swift
    /// var body: some Node {
    ///     for name in ["Alice", "Bob", "Carol"] {
    ///         TextNode(name)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameter components: The ordered array of nodes produced by the
    ///   loop iterations.
    /// - Returns: An `ArrayNode` containing all iterated child nodes.
    public static func buildArray<C: Node>(_ components: [C]) -> ArrayNode<C> {
        ArrayNode(children: components)
    }
}
