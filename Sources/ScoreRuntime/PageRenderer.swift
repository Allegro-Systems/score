import ScoreCSS
import ScoreCore
import ScoreHTML

/// Orchestrates rendering a single ``Page`` into a complete HTML document.
///
/// `PageRenderer` coordinates the CSS collection, class injection, HTML
/// rendering, and document assembly steps that transform a page's node tree
/// into a `<!DOCTYPE html>` string ready to serve as an HTTP response.
///
/// ### Pipeline
///
/// 1. Evaluate the page's `body` to obtain the node tree
/// 2. Run `CSSCollector` to extract scoped CSS rules
/// 3. Build a class injector closure from the collected rules
/// 4. Run `HTMLRenderer` with the injector to produce HTML with class attributes
/// 5. Run `JSEmitter` to produce client-side reactive scripts (if any)
/// 6. Call `DocumentAssembler` to merge everything into a complete document
///
/// ### Example
///
/// ```swift
/// let html = PageRenderer.render(
///     page: homePage,
///     metadata: appMetadata,
///     theme: appTheme
/// )
/// ```
public enum PageRenderer: Sendable {

    /// Renders a page into a complete HTML document.
    ///
    /// - Parameters:
    ///   - page: The page to render.
    ///   - metadata: The application-level metadata, if any.
    ///   - theme: The application theme, if any.
    ///   - environment: The build environment, used to control JS emission.
    ///     Defaults to ``Environment/current``.
    /// - Returns: A complete HTML document string.
    public static func render(
        page: some Page,
        metadata: (any Metadata)?,
        theme: (any Theme)?,
        environment: Environment = .current
    ) -> String {
        let body = page.body

        var collector = CSSCollector()
        collector.collect(from: body)
        let rules = collector.collectedRules()

        let classLookup = buildClassLookup(from: rules)
        let renderer = HTMLRenderer(classInjector: { modifiers in
            classLookup(modifiers)
        })
        let bodyHTML = renderer.render(body)

        let componentCSS = collector.renderStylesheet()
        let themeCSS = theme.map { ThemeCSSEmitter.emit($0) } ?? ""

        let pageScript = JSEmitter.emit(page: page, environment: environment)
        var scripts: [String] = []
        if !pageScript.isEmpty {
            scripts.append("<script src=\"/_score/signal-polyfill.js\"></script>")
            scripts.append("<script src=\"/_score/score-runtime.js\"></script>")
            scripts.append(pageScript)
        }

        let patch = page.metadata
        let title = DocumentAssembler.composeTitle(
            page: patch?.title ?? metadata?.title,
            separator: patch?.titleSeparator ?? metadata?.titleSeparator ?? " | ",
            site: patch?.site ?? metadata?.site
        )

        let parts = DocumentAssembler.Parts(
            title: title,
            description: patch?.description ?? metadata?.description,
            keywords: patch?.keywords ?? metadata?.keywords ?? [],
            structuredData: patch?.structuredData ?? metadata?.structuredData ?? [],
            themeCSS: themeCSS,
            componentCSS: componentCSS,
            bodyHTML: bodyHTML,
            scripts: scripts,
            activeTheme: theme?.name
        )

        return DocumentAssembler.assemble(parts)
    }

    private static func buildClassLookup(
        from rules: [CSSCollector.Rule]
    ) -> @Sendable ([any ModifierValue]) -> String? {
        var mapping: [String: String] = [:]
        for rule in rules {
            mapping[rule.className] = rule.className
        }
        let frozenMapping = mapping

        return { modifiers in
            var declarations: [CSSDeclaration] = []
            for modifier in modifiers {
                declarations.append(contentsOf: CSSEmitter.declarations(for: modifier))
            }
            guard !declarations.isEmpty else { return nil }

            var hasher = Hasher()
            for d in declarations {
                hasher.combine(d.property)
                hasher.combine(d.value)
            }
            let hash = UInt(bitPattern: hasher.finalize())
            let className = "s-\(String(hash, radix: 36))"
            return frozenMapping[className]
        }
    }
}
