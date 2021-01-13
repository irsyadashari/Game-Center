// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Core",
    platforms: [.iOS(.v14), .macOS(.v10_15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Core",
            targets: ["Core"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(name: "Realm", url: "https://github.com/realm/realm-cocoa.git", from: "5.4.4")
    ],
    targets: [
        .target(
            name: "Core",
            dependencies: [
                .product(name: "RealmSwift", package: "Realm"),
            ]),
        .testTarget(
            name: "CoreTests",
            dependencies: ["Core"]),
    ]
)
