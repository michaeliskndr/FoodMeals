// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UtilityKit",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "UtilityKit",
            targets: ["UtilityKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .exact("6.6.0")),
        .package(url: "https://github.com/Swinject/Swinject.git", from: "2.8.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "UtilityKit",
            dependencies: [
                .product(name: "RxSwift", package: "RxSwift"),
                .product(name: "RxCocoa", package: "RxSwift"),
                "Swinject",
            ]),
        .testTarget(
            name: "UtilityKitTests",
            dependencies: ["UtilityKit"]),
    ]
)
