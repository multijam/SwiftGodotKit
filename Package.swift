// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftGodotKit",
    platforms: [
        .macOS(.v13),
        .visionOS(.v1),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SwiftGodotKit",
            targets: ["SwiftGodotKit"]),
        .executable(name: "Dodge", targets: ["Dodge"]),
        .executable(name: "UglySample", targets: ["UglySample"]),
        .executable(name: "Properties", targets: ["Properties"]),
        .executable(name: "TrivialSample", targets: ["TrivialSample"]),
    ],
    dependencies: [
        .package(url: "https://github.com/multijam/SwiftGodot", revision: "d5f4229b08fd7369c95b27261f8da57dd4b5651e")
        //.package(path: "../SwiftGodot"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SwiftGodotKit",
            dependencies: [
                "SwiftGodot",
                .target(name: "binary_libgodot", condition: .when(platforms: [.macOS, .visionOS])),
                .target(name: "libgodot", condition: .when(platforms: [.linux, .windows])),
            ]
        ),
        
        .executableTarget(
            name: "UglySample",
            dependencies: ["SwiftGodotKit"]
        ),
        
        .executableTarget(
            name: "TrivialSample",
            dependencies: ["SwiftGodotKit"]
        ),

        .executableTarget(
            name: "Properties",
            dependencies: ["SwiftGodotKit"]
        ),
        
        // This is a sample that I am porting
        .executableTarget(
            name: "Dodge",
            dependencies: [
                "SwiftGodotKit",
                .target(name: "binary_libgodot", condition: .when(platforms: [.macOS, .visionOS])),
                .target(name: "libgodot", condition: .when(platforms: [.linux, .windows])),
            ],
            resources: [.copy ("Project")]
        ),
        .binaryTarget (
            name: "binary_libgodot",
            //path: "../SwiftGodot/libgodot.xcframework"
            url: "https://github.com/multijam/SwiftGodot/releases/download/v0.0.9/libgodot.xcframework.zip",
            checksum: "fdc3cf0a98dce8a9db13bcf0bc051efd6334225222ddf403ac2f9b5fbc5c8fa0"
        ),
        .systemLibrary(
            name: "libgodot"
        ),
    ]
)
