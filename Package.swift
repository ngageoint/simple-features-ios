// swift-tools-version:5.10
import PackageDescription

let package = Package(
    name: "SimpleFeatures",
    platforms: [.macOS(.v11), .iOS(.v13)],
    products: [
        .library(
            name: "SimpleFeatures",
            targets: ["SimpleFeatures"]),
    ],
    targets: [
        .target(
            name: "SimpleFeatures",
            path: "sf-ios",
            publicHeadersPath: "include"
        ),
        .testTarget(
            name: "SimpleFeaturesTests",
            dependencies: [
                "SimpleFeatures"
            ],
            path: "sf-iosTests",
            cSettings: [
                .headerSearchPath(""),
            ]
        )
    ]
)
