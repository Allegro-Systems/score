import ScoreCore
import Testing

@testable import ScoreRuntime

private struct StaticPage: Page {
    static let path = "/"

    var body: some Node {
        Heading(.one) { Text(verbatim: "Hello") }
    }
}

private struct ReactivePage: Page {
    static let path = "/counter"
    @State var count = 0

    var body: some Node {
        Button { Text(verbatim: "\(count)") }
            .on(.click, "increment")
    }
}

private struct MultiStatePage: Page {
    static let path = "/multi"
    @State var name = "world"
    @State var visible = true

    var body: some Node {
        Text(verbatim: "\(name)")
    }
}

private struct ComputedPage: Page {
    static let path = "/computed"
    @State var price = 10
    @Computed var doubled = 20

    var body: some Node {
        Text(verbatim: "value")
    }
}

private struct ActionPage: Page {
    static let path = "/action"
    @State var count = 0
    @Action var increment = {}

    var body: some Node {
        Button { Text(verbatim: "Go") }
            .on(.click, "increment")
    }
}

@Test func staticPageEmitsNoScript() {
    let script = JSEmitter.emit(page: StaticPage(), environment: .development)
    #expect(script.isEmpty)
}

@Test func reactivePageEmitsStateDeclaration() {
    let states = JSEmitter.extractStates(from: ReactivePage())
    #expect(states.count == 1)
    #expect(states[0].name == "count")
    #expect(states[0].initialValue == "0")
}

@Test func multiStatePageExtractsAllStates() {
    let states = JSEmitter.extractStates(from: MultiStatePage())
    #expect(states.count == 2)

    let names = Set(states.map(\.name))
    #expect(names.contains("name"))
    #expect(names.contains("visible"))
}

@Test func computedPageExtractsComputed() {
    let computeds = JSEmitter.extractComputeds(from: ComputedPage())
    #expect(computeds.count == 1)
    #expect(computeds[0].name == "doubled")
}

@Test func actionPageExtractsAction() {
    let actions = JSEmitter.extractActions(from: ActionPage())
    #expect(actions.count == 1)
    #expect(actions[0].name == "increment")
}

@Test func reactivePageExtractsEventBindings() {
    let bindings = JSEmitter.extractEventBindings(from: ReactivePage().body)
    #expect(bindings.count == 1)
    #expect(bindings[0].event == "click")
    #expect(bindings[0].handler == "increment")
}

@Test func emitProducesScriptTag() {
    let script = JSEmitter.emit(page: ReactivePage(), environment: .development)
    #expect(script.hasPrefix("<script>"))
    #expect(script.hasSuffix("</script>"))
}

@Test func emitIncludesScoreStateCalls() {
    let script = JSEmitter.emit(page: ReactivePage(), environment: .development)
    #expect(script.contains("Score.state(0)"))
}

@Test func emitIncludesAddEventListener() {
    let script = JSEmitter.emit(page: ReactivePage(), environment: .development)
    #expect(script.contains("addEventListener(\"click\", increment)"))
}

@Test func emitIncludesDataSelectorInDevMode() {
    let script = JSEmitter.emit(page: ReactivePage(), environment: .development)
    #expect(script.contains("data-s="))
}

@Test func actionPageEmitsFunctionDeclaration() {
    let script = JSEmitter.emit(page: ActionPage(), environment: .development)
    #expect(script.contains("function increment()"))
}

@Test func computedPageEmitsScoreComputed() {
    let script = JSEmitter.emit(page: ComputedPage(), environment: .development)
    #expect(script.contains("Score.computed("))
}

@Test func stringStateEmitsQuotedValue() {
    let states = JSEmitter.extractStates(from: MultiStatePage())
    let nameState = states.first { $0.name == "name" }
    #expect(nameState?.initialValue == "\"world\"")
}

@Test func boolStateEmitsJSBoolean() {
    let states = JSEmitter.extractStates(from: MultiStatePage())
    let visibleState = states.first { $0.name == "visible" }
    #expect(visibleState?.initialValue == "true")
}
