import ScoreCore
import Testing

@testable import ScoreRuntime

private struct MinimalTheme: Theme {
    var name: String? { nil }
    var colorRoles: [String: ColorToken] { [:] }
    var customColorRoles: [String: [Int: ColorToken]] { [:] }
    var fontFamilies: [String: String] { [:] }
    var typeScaleBase: Double { 16 }
    var typeScaleRatio: Double { 1.25 }
    var spacingUnit: Double { 4 }
    var radiusBase: Double { 4 }
    var syntaxThemeName: String? { nil }
    var dark: (any ThemePatch)? { nil }
}

private struct NamedMinimalTheme: Theme {
    var name: String? { "ocean" }
    var colorRoles: [String: ColorToken] { [:] }
    var customColorRoles: [String: [Int: ColorToken]] { [:] }
    var fontFamilies: [String: String] { [:] }
    var typeScaleBase: Double { 16 }
    var typeScaleRatio: Double { 1.25 }
    var spacingUnit: Double { 4 }
    var radiusBase: Double { 4 }
    var syntaxThemeName: String? { nil }
    var dark: (any ThemePatch)? { nil }
}

private struct AppMetadata: Metadata {
    var site: String? { "TestSite" }
    var title: String? { nil }
    var titleSeparator: String { " — " }
    var description: String? { "Default description" }
    var keywords: [String] { ["swift"] }
    var structuredData: [String] { [] }
}

private struct TitlePatch: MetadataPatch {
    var site: String? { nil }
    var title: String? { "Home" }
    var titleSeparator: String? { nil }
    var description: String? { nil }
    var keywords: [String]? { nil }
    var structuredData: [String]? { nil }
}

private struct SimplePage: Page {
    static let path = "/"
    var metadata: (any MetadataPatch)? { TitlePatch() }

    var body: some Node {
        Heading(.one) { Text(verbatim: "Hello") }
    }
}

private struct StyledPage: Page {
    static let path = "/styled"

    var body: some Node {
        Paragraph {
            Text(verbatim: "Padded text")
        }
        .padding(16)
    }
}

@Test func renderSimplePage() {
    let html = PageRenderer.render(page: SimplePage(), metadata: nil, theme: nil)
    #expect(html.contains("<!DOCTYPE html>"))
    #expect(html.contains("<h1>Hello</h1>"))
}

@Test func renderPageWithMetadata() {
    let html = PageRenderer.render(page: SimplePage(), metadata: AppMetadata(), theme: nil)
    #expect(html.contains("<title>Home — TestSite</title>"))
    #expect(html.contains("Default description"))
}

@Test func renderPageWithTheme() {
    let html = PageRenderer.render(page: SimplePage(), metadata: nil, theme: MinimalTheme())
    #expect(html.contains(":root {"))
    #expect(html.contains("--spacing-unit: 4px"))
}

@Test func renderStyledPageIncludesCSS() {
    let html = PageRenderer.render(page: StyledPage(), metadata: nil, theme: nil)
    #expect(html.contains("padding: 16px"))
}

@Test func renderStyledPageInjectsClass() {
    let html = PageRenderer.render(page: StyledPage(), metadata: nil, theme: nil)
    #expect(html.contains("<div class=\"s-"))
}

@Test func renderPageWithNamedThemeEmitsDataTheme() {
    let html = PageRenderer.render(page: SimplePage(), metadata: nil, theme: NamedMinimalTheme())
    #expect(html.contains("<html lang=\"en\" data-theme=\"ocean\">"))
}

@Test func renderPageWithUnnamedThemeOmitsDataTheme() {
    let html = PageRenderer.render(page: SimplePage(), metadata: nil, theme: MinimalTheme())
    #expect(html.contains("<html lang=\"en\">"))
    #expect(!html.contains("data-theme"))
}
