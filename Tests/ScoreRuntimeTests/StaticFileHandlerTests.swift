import Foundation
import Testing

@testable import ScoreRuntime

@Test func mimeTypeForCSS() {
    #expect(StaticFileHandler.mimeType(for: "css") == "text/css; charset=utf-8")
}

@Test func mimeTypeForJS() {
    #expect(StaticFileHandler.mimeType(for: "js") == "application/javascript; charset=utf-8")
}

@Test func mimeTypeForPNG() {
    #expect(StaticFileHandler.mimeType(for: "png") == "image/png")
}

@Test func mimeTypeForWoff2() {
    #expect(StaticFileHandler.mimeType(for: "woff2") == "font/woff2")
}

@Test func mimeTypeForUnknownExtension() {
    #expect(StaticFileHandler.mimeType(for: "xyz") == "application/octet-stream")
}

@Test func rejectsDirectoryTraversal() {
    let result = StaticFileHandler.serve(relativePath: "../etc/passwd", from: "/tmp")
    #expect(result == nil)
}

@Test func rejectsEmptyPath() {
    let result = StaticFileHandler.serve(relativePath: "", from: "/tmp")
    #expect(result == nil)
}

@Test func returnsNilForMissingFile() {
    let result = StaticFileHandler.serve(
        relativePath: "nonexistent-file-abc123.txt",
        from: NSTemporaryDirectory()
    )
    #expect(result == nil)
}

@Test func servesExistingFile() throws {
    let dir = NSTemporaryDirectory()
    let filename = "score-test-\(UUID().uuidString).txt"
    let path = (dir as NSString).appendingPathComponent(filename)
    let content = "hello static"
    try content.write(toFile: path, atomically: true, encoding: .utf8)
    defer { try? FileManager.default.removeItem(atPath: path) }

    let result = StaticFileHandler.serve(relativePath: filename, from: dir)
    #expect(result != nil)
    let (data, contentType) = result!
    #expect(String(data: data, encoding: .utf8) == "hello static")
    #expect(contentType == "text/plain; charset=utf-8")
}
