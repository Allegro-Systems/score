/// The build-mode environment in which the Score application is running.
///
/// `Environment` determines runtime behaviour such as whether dev tools are
/// injected, whether source maps are served, and whether error overlays are
/// shown in the browser. The value is resolved once at startup from the
/// `SCORE_ENV` environment variable, falling back to a compile-time check.
///
/// ### Resolution Order
///
/// 1. If the `SCORE_ENV` environment variable is set to `"production"` or
///    `"development"`, that value is used.
/// 2. Otherwise, debug builds (`#if DEBUG`) default to `.development` and
///    release builds default to `.production`.
///
/// ### Example
///
/// ```swift
/// if Environment.current == .development {
///     // inject dev tools script
/// }
/// ```
import Foundation

public enum Environment: String, Sendable {

    /// Development mode — enables dev tools, error overlays, and source maps.
    case development

    /// Production mode — optimised output with no debug instrumentation.
    case production

    /// The resolved environment for the current process.
    public static let current: Environment = {
        if let raw = ProcessInfo.processInfo.environment["SCORE_ENV"],
            let env = Environment(rawValue: raw)
        {
            return env
        }
        #if DEBUG
        return .development
        #else
        return .production
        #endif
    }()
}
