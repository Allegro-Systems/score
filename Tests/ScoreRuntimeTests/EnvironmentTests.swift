import Testing

@testable import ScoreRuntime

@Test func environmentDefaultIsDevelopment() {
    #expect(Environment.current == .development)
}

@Test func environmentRawValueDevelopment() {
    let env = Environment(rawValue: "development")
    #expect(env == .development)
}

@Test func environmentRawValueProduction() {
    let env = Environment(rawValue: "production")
    #expect(env == .production)
}

@Test func environmentInvalidRawValue() {
    let env = Environment(rawValue: "staging")
    #expect(env == nil)
}
