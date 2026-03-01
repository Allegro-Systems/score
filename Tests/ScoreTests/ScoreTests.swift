import Score
import Testing

@Test func routeAndControllerPublicApi() async throws {
    struct DemoController: Controller {
        let base: String = "/demo"
        let routes: [Route] = [Route(method: .get, path: "x")]
    }

    let controller = DemoController()
    #expect(controller.base == "/demo")
    #expect(controller.routes.first?.path == "/x")

    let route = Route(method: .post, path: " submit ")
    #expect(route.path == "/submit")

    let typed = Route(method: .get, path: "count") { (request: String) async throws -> Int in
        request.count
    }
    let out = try await typed.handler?("abc") as? Int
    #expect(out == 3)
}

@Test func responsiveAndAccessibilityPublicApi() {
    let base = TextNode("x")

    let compact = base.compact { $0 }
    #expect(compact.modifiers.count == 1)

    let dark = base.dark { $0 }
    #expect(dark.modifiers.count == 1)

    let themed = base.theme("brand") { $0 }
    #expect(themed.modifiers.count == 1)

    let a11y = base.accessibility(label: "label", hidden: true, role: "img")
    #expect(a11y.modifiers.count == 1)
}

@Test func layoutAndBoxModelPublicApi() {
    let node = TextNode("x")
        .padding(8, at: .horizontal)
        .margin(4, at: .top, .bottom)
        .display(.inlineBlock)
        .overflow(x: .hidden, y: .auto)
        .position(.absolute, top: 1, trailing: 2)
        .zIndex(10)
        .size(width: 100, minWidth: 50, maxWidth: 200)
        .aspectRatio(1.5)
        .border(width: 1, color: .accent, style: .solid, radius: 4, at: .top)
        .boxSizing(.borderBox)

    #expect(!node.modifiers.isEmpty)
}
