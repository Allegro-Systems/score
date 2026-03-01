import Foundation
import HTTPTypes
import Testing

@testable import ScoreRuntime

@Test func textResponseSetsContentType() {
    let response = Response.text("hello")
    #expect(response.headers["content-type"] == "text/plain; charset=utf-8")
    #expect(response.body == Data("hello".utf8))
}

@Test func htmlResponseSetsContentType() {
    let response = Response.html("<h1>Hi</h1>")
    #expect(response.headers["content-type"] == "text/html; charset=utf-8")
    #expect(response.body == Data("<h1>Hi</h1>".utf8))
}

@Test func jsonResponseSetsContentType() {
    let data = Data("{\"ok\":true}".utf8)
    let response = Response.json(data)
    #expect(response.headers["content-type"] == "application/json")
    #expect(response.body == data)
}

@Test func defaultStatusIsOk() {
    let response = Response()
    #expect(response.status == .ok)
}

@Test func customStatusIsPreserved() {
    let response = Response.text("created", status: .created)
    #expect(response.status == .created)
}
