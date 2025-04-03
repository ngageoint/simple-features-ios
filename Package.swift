// swift-tools-version:5.10
import PackageDescription

let package = Package(
    name: "sf-ios",
    platforms: [.macOS(.v11), .iOS(.v12)],
    products: [
        .library(
            name: "sf-ios",
            targets: ["sf-ios"]),
    ],
    targets: [
        .target(
            name: "sf-ios",
            path: "sf-ios",
            exclude: [
                "sf_ios.swift",
//                "sf-ios-Bridging-Header.h"
            ],
            publicHeadersPath: "",
            cSettings: [
                .headerSearchPath(""),
                
                .headerSearchPath("extended"),
                .headerSearchPath("util"),
                .headerSearchPath("util/centroid"),
                .headerSearchPath("util/filter"),
                .headerSearchPath("util/sweep"),
            ]),
        .testTarget(
            name: "sf-iosTests",
            dependencies: [
                "sf-ios"
            ],
            path: "sf-iosTests",
            exclude: [
//                "Info.plist"
            ],
            cSettings: [
                .headerSearchPath(""),
                .headerSearchPath("sweep"),
                .headerSearchPath("../sf-ios/extended"),
                .headerSearchPath("../sf-ios/util"),
                .headerSearchPath("../sf-ios/util/centroid"),
                .headerSearchPath("../sf-ios/util/filter"),
                .headerSearchPath("../sf-ios/util/sweep"),
            ]),
    ]
)
