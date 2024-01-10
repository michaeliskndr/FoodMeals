// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MealsKit",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "MealsKit",
            targets: ["MealsKit"]),
    ],
    dependencies: [
        .package(path: "../ConnectionKit"),
        .package(path: "../CommonKit"),
        .package(path: "../UtilityKit"),
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.1")),
        .package(url: "https://github.com/onevcat/Kingfisher.git", .upToNextMajor(from: "7.0.0")),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.6.0"),
        .package(url: "https://github.com/ra1028/DiffableDataSources.git", from: "0.5.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "MealsKit", dependencies: [
                "ConnectionKit", "CommonKit", "UtilityKit", 
                "SnapKit", "Kingfisher", "DiffableDataSources"
            ]),
        .testTarget(
            name: "MealsKitTests",
            dependencies: ["MealsKit", .product(name: "RxTest", package: "RxSwift")]),
    ]
)
