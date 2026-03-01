// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "Score",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .library(name: "Score", targets: ["Score"]),
        .library(name: "ScoreCore", targets: ["ScoreCore"]),
        .library(name: "ScoreHTML", targets: ["ScoreHTML"]),
        .library(name: "ScoreCSS", targets: ["ScoreCSS"]),
        .library(name: "ScoreRouter", targets: ["ScoreRouter"]),
        .library(name: "ScoreRuntime", targets: ["ScoreRuntime"]),
        .library(name: "ScoreDB", targets: ["ScoreDB"]),
        .library(name: "ScoreKV", targets: ["ScoreKV"]),
        .library(name: "ScoreAuth", targets: ["ScoreAuth"]),
        .library(name: "ScoreContent", targets: ["ScoreContent"]),
        .library(name: "ScoreAssets", targets: ["ScoreAssets"]),
        .library(name: "ScoreUI", targets: ["ScoreUI"]),
        .library(name: "ScoreVendor", targets: ["ScoreVendor"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swiftlang/swift-docc-plugin", from: "1.1.0"),
        .package(url: "https://github.com/apple/swift-http-types.git", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.0.0"),
        .package(url: "https://github.com/apple/swift-log.git", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-metrics.git", from: "2.0.0"),
        .package(url: "https://github.com/apple/swift-crypto.git", from: "3.0.0"),
        .package(url: "https://github.com/swiftlang/swift-markdown.git", from: "0.6.0"),
    ],
    targets: [
        .target(
            name: "ScoreCore",
            dependencies: [
                .product(name: "HTTPTypes", package: "swift-http-types")
            ]
        ),
        .target(name: "ScoreHTML", dependencies: ["ScoreCore"]),
        .target(name: "ScoreCSS", dependencies: ["ScoreCore"]),
        .target(
            name: "ScoreRouter",
            dependencies: [
                "ScoreCore",
                .product(name: "HTTPTypes", package: "swift-http-types"),
            ]
        ),
        .target(
            name: "ScoreRuntime",
            dependencies: [
                "ScoreCore",
                "ScoreHTML",
                "ScoreCSS",
                "ScoreRouter",
                .product(name: "NIOCore", package: "swift-nio"),
                .product(name: "NIOPosix", package: "swift-nio"),
                .product(name: "NIOHTTP1", package: "swift-nio"),
                .product(name: "HTTPTypes", package: "swift-http-types"),
                .product(name: "Logging", package: "swift-log"),
                .product(name: "Metrics", package: "swift-metrics"),
            ]
        ),
        .target(name: "ScoreDB", dependencies: ["ScoreCore"]),
        .target(
            name: "ScoreKV",
            dependencies: [
                "ScoreCore",
                .product(name: "NIOCore", package: "swift-nio"),
            ]
        ),
        .target(
            name: "ScoreAuth",
            dependencies: [
                "ScoreCore",
                "ScoreKV",
                "ScoreRouter",
                .product(name: "Crypto", package: "swift-crypto"),
            ]
        ),
        .target(
            name: "ScoreContent",
            dependencies: [
                "ScoreCore",
                "ScoreHTML",
                .product(name: "Markdown", package: "swift-markdown"),
            ]
        ),
        .target(name: "ScoreAssets", dependencies: ["ScoreCore"]),
        .target(name: "ScoreUI", dependencies: ["ScoreCore", "ScoreHTML", "ScoreCSS"]),
        .target(name: "ScoreVendor", dependencies: ["ScoreCore", "ScoreRouter"]),
        .target(
            name: "Score",
            dependencies: [
                "ScoreCore", "ScoreHTML", "ScoreCSS", "ScoreRouter",
                "ScoreRuntime", "ScoreDB", "ScoreKV", "ScoreAuth",
                "ScoreContent", "ScoreAssets", "ScoreUI", "ScoreVendor",
            ]
        ),
        .testTarget(name: "ScoreCoreTests", dependencies: ["ScoreCore"]),
        .testTarget(name: "ScoreTests", dependencies: ["Score"]),
        .testTarget(name: "ScoreHTMLTests", dependencies: ["ScoreHTML"]),
        .testTarget(name: "ScoreCSSTests", dependencies: ["ScoreCSS"]),
        .testTarget(name: "ScoreRouterTests", dependencies: ["ScoreRouter"]),
        .testTarget(
            name: "ScoreRuntimeTests",
            dependencies: [
                "ScoreRuntime",
                .product(name: "NIOEmbedded", package: "swift-nio"),
            ]
        ),
    ]
)
