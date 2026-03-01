import ScoreCore

/// Renders as a `<div>` block container.
extension Stack: HTMLRenderable {
    /// Wraps content in a `<div>` element.
    func renderHTML(into output: inout String, renderer: HTMLRenderer) {
        renderer.tag("div", content: content, to: &output)
    }
}

/// Renders as the `<main>` landmark element.
extension Main: HTMLRenderable {
    /// Wraps content in a `<main>` element.
    func renderHTML(into output: inout String, renderer: HTMLRenderer) {
        renderer.tag("main", content: content, to: &output)
    }
}

/// Renders as the `<section>` sectioning element.
extension Section: HTMLRenderable {
    /// Wraps content in a `<section>` element.
    func renderHTML(into output: inout String, renderer: HTMLRenderer) {
        renderer.tag("section", content: content, to: &output)
    }
}

/// Renders as the `<article>` sectioning element.
extension Article: HTMLRenderable {
    /// Wraps content in an `<article>` element.
    func renderHTML(into output: inout String, renderer: HTMLRenderer) {
        renderer.tag("article", content: content, to: &output)
    }
}

/// Renders as the `<header>` landmark element.
extension Header: HTMLRenderable {
    /// Wraps content in a `<header>` element.
    func renderHTML(into output: inout String, renderer: HTMLRenderer) {
        renderer.tag("header", content: content, to: &output)
    }
}

/// Renders as the `<footer>` landmark element.
extension Footer: HTMLRenderable {
    /// Wraps content in a `<footer>` element.
    func renderHTML(into output: inout String, renderer: HTMLRenderer) {
        renderer.tag("footer", content: content, to: &output)
    }
}

/// Renders as the `<aside>` complementary landmark element.
extension Aside: HTMLRenderable {
    /// Wraps content in an `<aside>` element.
    func renderHTML(into output: inout String, renderer: HTMLRenderer) {
        renderer.tag("aside", content: content, to: &output)
    }
}

/// Renders as the `<nav>` navigation landmark element.
extension Navigation: HTMLRenderable {
    /// Wraps content in a `<nav>` element.
    func renderHTML(into output: inout String, renderer: HTMLRenderer) {
        renderer.tag("nav", content: content, to: &output)
    }
}

/// Renders transparently, emitting children with no wrapper element.
extension Group: HTMLRenderable {
    /// Emits content directly, producing no surrounding tag of its own.
    func renderHTML(into output: inout String, renderer: HTMLRenderer) {
        renderer.write(content, to: &output)
    }
}
