/// A protocol that defines application-level document metadata.
///
/// `Metadata` represents the base metadata payload inherited by pages. Concrete
/// renderer modules map this payload to output-specific constructs such as HTML
/// `<title>` and `<meta>` tags.
///
/// Typical uses include:
/// - Defining global site metadata defaults on `Application`
/// - Providing keyword and description defaults for all pages
/// - Supplying structured data payloads for document emitters
///
/// ### Example
///
/// ```swift
/// struct AppMetadata: Metadata {
///     var site: String? { "Example" }
///     var title: String? { nil }
///     var titleSeparator: String { " | " }
///     var description: String? { "Static-first Swift web apps." }
///     var keywords: [String] { ["swift", "score"] }
///     var structuredData: [String] { [] }
/// }
/// ```
///
/// ### HTML Mapping
///
/// Conforming values map to document-level metadata tags and JSON-LD payloads.
public protocol Metadata: Sendable {

    /// The optional site name used in title composition.
    var site: String? { get }

    /// The optional document title.
    ///
    /// When `nil`, renderer modules may derive a title from page context.
    var title: String? { get }

    /// The separator used when composing page and site titles.
    var titleSeparator: String { get }

    /// The optional default document description.
    var description: String? { get }

    /// The default keyword list.
    var keywords: [String] { get }

    /// Structured data payloads represented as JSON strings.
    ///
    /// Renderer modules can emit these as JSON-LD script elements.
    var structuredData: [String] { get }
}

/// A protocol for page-level metadata overrides.
///
/// `MetadataPatch` mirrors `Metadata` using optional fields so pages can
/// selectively override application defaults without redefining the full
/// metadata payload.
///
/// Typical uses include:
/// - Overriding page title and description on a single route
/// - Adding route-specific keywords
/// - Appending page-specific structured-data payloads
///
/// ### Example
///
/// ```swift
/// struct AboutMetadataPatch: MetadataPatch {
///     var title: String? { "About" }
///     var description: String? { "About our product." }
/// }
/// ```
///
/// ### HTML Mapping
///
/// Patch values map to partial metadata overrides during document rendering.
public protocol MetadataPatch: Sendable {

    /// Optional site-name override.
    var site: String? { get }

    /// Optional title override.
    var title: String? { get }

    /// Optional title-separator override.
    var titleSeparator: String? { get }

    /// Optional description override.
    var description: String? { get }

    /// Optional keyword-list override.
    var keywords: [String]? { get }

    /// Optional structured-data override.
    var structuredData: [String]? { get }
}
