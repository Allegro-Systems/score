#!/usr/bin/env swift

import Foundation

struct Coverage: Decodable {
    let data: [Datum]
}

struct Datum: Decodable {
    let files: [CoverageFile]
}

struct CoverageFile: Decodable {
    let filename: String
    let summary: Summary
}

struct Summary: Decodable {
    let lines: Metric
}

struct Metric: Decodable {
    let count: Int
    let covered: Int
}

@inline(__always)
func fail(_ message: String) -> Never {
    FileHandle.standardError.write(Data((message + "\n").utf8))
    exit(2)
}

func normalizedRoot(_ path: String) -> String {
    var value = path
    while value.hasSuffix("/") {
        value.removeLast()
    }
    return value
}

let args = CommandLine.arguments

guard args.count >= 2 else {
    fail("usage: coverage.swift <codecov_json_path> [min_percent=85] [enforce_targets=true|false] [project_root=pwd]")
}

let jsonPath = args[1]
let minRaw = args.count >= 3 ? args[2] : "85"
guard let minPercent = Double(minRaw) else {
    fail("invalid min_percent: \(minRaw)")
}
let enforceTargets = (args.count >= 4 ? args[3] : "true").lowercased() == "true"
let projectRoot = normalizedRoot(args.count >= 5 ? args[4] : FileManager.default.currentDirectoryPath)
let sourcePrefix = projectRoot + "/Sources/"

let payload = try Data(contentsOf: URL(fileURLWithPath: jsonPath))
let coverage = try JSONDecoder().decode(Coverage.self, from: payload)

var byTarget: [String: (covered: Int, count: Int)] = [:]

for datum in coverage.data {
    for file in datum.files {
        guard file.filename.hasPrefix(sourcePrefix) else { continue }

        let remainder = file.filename.dropFirst(sourcePrefix.count)
        guard let targetPart = remainder.split(separator: "/").first else { continue }

        let lines = file.summary.lines
        guard lines.count > 0 else { continue }

        let target = String(targetPart)
        var current = byTarget[target] ?? (covered: 0, count: 0)
        current.covered += lines.covered
        current.count += lines.count
        byTarget[target] = current
    }
}

guard !byTarget.isEmpty else {
    fail("no source coverage found under \(sourcePrefix)*")
}

print("Coverage by target (line coverage):")

var totalCovered = 0
var totalCount = 0
var failingTargets: [String] = []

for target in byTarget.keys.sorted() {
    guard let values = byTarget[target] else { continue }
    totalCovered += values.covered
    totalCount += values.count

    let percent = values.count == 0 ? 0.0 : (Double(values.covered) / Double(values.count)) * 100.0
    if enforceTargets && percent < minPercent {
        failingTargets.append(target)
    }

    print("- \(target): \(String(format: "%.2f", percent))% (\(values.covered)/\(values.count))")
}

let overall = totalCount == 0 ? 0.0 : (Double(totalCovered) / Double(totalCount)) * 100.0
print("Overall: \(String(format: "%.2f", overall))% (\(totalCovered)/\(totalCount))")

if overall < minPercent {
    fail("overall coverage \(String(format: "%.2f", overall))% is below required \(String(format: "%.2f", minPercent))%")
}

if !failingTargets.isEmpty {
    fail("targets below \(String(format: "%.2f", minPercent))%: \(failingTargets.sorted().joined(separator: ", "))")
}

print("Coverage threshold satisfied (min \(String(format: "%.2f", minPercent))%).")
