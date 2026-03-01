import Foundation
import HTTPTypes

/// An HTTP response returned from a controller handler.
///
/// `Response` encapsulates the status code, headers, and body of an HTTP
/// response. Controller handlers can return this type directly for full
/// control over the response, or use the convenience factory methods.
public struct Response: Sendable {

    /// The HTTP response status.
    public var status: HTTPResponse.Status

    /// Response headers. Keys should be lowercased.
    public var headers: [String: String]

    /// The response body.
    public var body: Data

    /// Creates a response with the given status, headers, and body.
    public init(
        status: HTTPResponse.Status = .ok,
        headers: [String: String] = [:],
        body: Data = Data()
    ) {
        self.status = status
        self.headers = headers
        self.body = body
    }

    /// Creates a plain-text response.
    public static func text(_ string: String, status: HTTPResponse.Status = .ok) -> Response {
        Response(
            status: status,
            headers: ["content-type": "text/plain; charset=utf-8"],
            body: Data(string.utf8)
        )
    }

    /// Creates an HTML response.
    public static func html(_ string: String, status: HTTPResponse.Status = .ok) -> Response {
        Response(
            status: status,
            headers: ["content-type": "text/html; charset=utf-8"],
            body: Data(string.utf8)
        )
    }

    /// Creates a JSON response from raw data.
    public static func json(_ data: Data, status: HTTPResponse.Status = .ok) -> Response {
        Response(
            status: status,
            headers: ["content-type": "application/json"],
            body: data
        )
    }
}
