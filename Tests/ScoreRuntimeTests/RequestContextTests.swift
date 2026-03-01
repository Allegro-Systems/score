import Testing

@testable import ScoreRuntime

@Test func parseQueryExtractsParameters() {
    let query = RequestContext.parseQuery("/path?a=1&b=2")
    #expect(query == ["a": "1", "b": "2"])
}

@Test func parseQueryReturnsEmptyForNoQueryString() {
    let query = RequestContext.parseQuery("/path")
    #expect(query.isEmpty)
}

@Test func parseQueryDecodesPercentEncoding() {
    let query = RequestContext.parseQuery("/path?key=hello%20world")
    #expect(query["key"] == "hello world")
}

@Test func parseQueryFirstValueWins() {
    let query = RequestContext.parseQuery("/path?x=1&x=2")
    #expect(query["x"] == "1")
}

@Test func parseQueryHandlesEmptyValue() {
    let query = RequestContext.parseQuery("/path?flag=&other=ok")
    #expect(query["flag"] == "")
    #expect(query["other"] == "ok")
}

@Test func parseQueryHandlesKeyWithoutEquals() {
    let query = RequestContext.parseQuery("/path?flag&other=ok")
    #expect(query["flag"] == "")
    #expect(query["other"] == "ok")
}
