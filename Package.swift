// swift-tools-version:4.2
import PackageDescription

let name = "LegibleError"

let package = Package(
    name: name,
    products: [
        .library(name: name, targets: [name]),
    ],
    targets: [
        .target(name: name, path: "Sources"),
        .testTarget(name: "LegibleErrorTests", dependencies: [.init(stringLiteral: name)]),
    ]
)

package.swiftLanguageVersions = [.v4, .v4_2]
