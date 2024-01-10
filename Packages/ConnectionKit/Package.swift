// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ConnectionKit",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "ConnectionKit",
            targets: ["ConnectionKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/RxSwiftCommunity/RxAlamofire.git",
                 exact: "6.1.0"),
        .package(path: "../UtilityKit"),
        .package(path: "../CommonKit")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "ConnectionKit", dependencies: ["RxAlamofire", "UtilityKit", "CommonKit"]),
        .testTarget(
            name: "ConnectionKitTests",
            dependencies: ["ConnectionKit"]),
    ]
)
