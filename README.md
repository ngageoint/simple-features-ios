# Simple Features iOS

#### Simple Features Lib ####

The Simple Features Libraries were developed at the [National Geospatial-Intelligence Agency (NGA)](http://www.nga.mil/) in collaboration with [BIT Systems](https://www.caci.com/bit-systems/). The government has "unlimited rights" and is releasing this software to increase the impact of government investments by providing developers with the opportunity to take things in new directions. The software use, modification, and distribution rights are stipulated within the [MIT license](http://choosealicense.com/licenses/mit/).

### Pull Requests ###
If you'd like to contribute to this project, please make a pull request. We'll review the pull request and discuss the changes. All pull request contributions to this project will be released under the MIT license.

Software source code previously released under an open source license and then modified by NGA staff is considered a "joint work" (see 17 USC § 101); it is partially copyrighted, partially public domain, and as a whole is protected by the copyrights of the non-government authors and must be released according to the terms of the original open source license.

### About ###

[Simple Features](http://ngageoint.github.io/simple-features-ios/) is an iOS library of geometry objects and utilities based upon the [OGC Simple Feature Access](http://www.opengeospatial.org/standards/sfa) standard.

### Simple Feature Conversion Libraries ###

* [simple-features-wkb-ios](https://github.com/ngageoint/simple-features-wkb-ios) - Well-Known Binary
* [simple-features-wkt-ios](https://github.com/ngageoint/simple-features-wkt-ios) - Well-Known Text
* [simple-features-geojson-ios](https://github.com/ngageoint/simple-features-geojson-ios) - GeoJSON
* [simple-features-proj-ios](https://github.com/ngageoint/simple-features-proj-ios) - Projection

### Usage ###

View the latest [Appledoc](http://ngageoint.github.io/simple-features-ios/docs/api/)

### Build ###

[![Build](https://github.com/ngageoint/simple-features-ios/actions/workflows/build.yml/badge.svg)](https://github.com/ngageoint/simple-features-ios/actions/workflows/build.yml)

Build this repository using SPM:

    swift build

Open the Swift Package in Xcode:

    open Package.swift

Run tests from Xcode or from command line:

    swift test

### Include Library ###

Add a package dependency version:

    .package(url: "https://github.com/ngageoint/simple-features-ios", from: "5.0.0"),

    # Or specific branch:

    .package(url: "https://github.com/ngageoint/simple-features-ios", branch: "release/5.0.0"),
    
    # Or as a local dependency:     

    .package(name: "simple-features-ios", path: "../simple-features-ios"),

Use it in a target:

        .target(
            name: "MyLibrary",
            dependencies: [
                .product(name: "SimpleFeatures", package: "simple-features-ios")
            ]
        )

### Swift ###

To use from Swift, import the framework:

    import SimpleFeatures
