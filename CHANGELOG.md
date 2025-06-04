# Change Log
All notable changes to this project will be documented in this file.
Adheres to [Semantic Versioning](http://semver.org/).

---

## 5.0.0 (6-4-2025)

* Breaking changes for Swift interopability. Converted C `enum` types to Objective-C `NS_ENUM` for proper visibility in Swift.
    * Release builds were failing in [Mage iOS app](https://github.com/ngageoint/mage-ios/) (Cannot find 'SF_POINT' in scope) and optimizations were disabled due to related symbols issues.
    * Updated types: `SFGeometryType`, `SFFiniteFilterType`, and `SFEventType` to use `NS_ENUM(NSInteger)`.
* Updated to Swift Package Manager (SPM) since Cocoapods is deprecated
* Updated header imports to use modular framework imports using angular brackets for Objective-C

## [4.1.4](https://github.com/ngageoint/simple-features-ios/releases/tag/4.1.4) (04-08-2024)

* Geometry Utils for Haversine distance, geodesic midpoints, geodesic paths, and geodesic envelopes
* Envelope left mid, bottom mid, right mid, and top mid methods
* Envelope min/max x/y/z/m double value methods
* Point x/y/z/m double value methods

## [4.1.3](https://github.com/ngageoint/simple-features-ios/releases/tag/4.1.3) (11-08-2023)

* Module definition

## [4.1.2](https://github.com/ngageoint/simple-features-ios/releases/tag/4.1.2) (01-25-2023)

* Shamos-Hoey simple polygon detection bug fix

## [4.1.1](https://github.com/ngageoint/simple-features-ios/releases/tag/4.1.1) (01-09-2023)

* Imports cleanup and simplification

## [4.1.0](https://github.com/ngageoint/simple-features-ios/releases/tag/4.1.0) (09-06-2022)

* Static creation shortcut methods
* Copy initializers
* Geometry utility intersections, distance, bearings, conversions, envelopes, crop, equal, contains, and bound
* GeometryEnvelope modified to Secure Coding
* GeometryEnvelope value setters, directionals, mids, centroid, empty, contains, and build geometry

## [4.0.1](https://github.com/ngageoint/simple-features-ios/releases/tag/4.0.1) (02-10-2022)

* Geometry Envelope range and point check utilities
* Geometry expand envelope method
* Centroid geometry utility for geometries in degrees
* Build geometries from envelope utility

## [4.0.0](https://github.com/ngageoint/simple-features-ios/releases/tag/4.0.0) (03-01-2021)

* Geometry Coding modified to Secure Coding
* iOS platform and deployment target 12.0

## [3.0.0](https://github.com/ngageoint/simple-features-ios/releases/tag/3.0.0) (08-13-2020)

* Geometry Filter interface and Point Finite Filter implementation
* Manual and automatic z and m has value updates
* Byte Reader/Writer interface updates
* Method renames to drop "get" prefix
* Text token reader

## [2.0.3](https://github.com/ngageoint/simple-features-ios/releases/tag/2.0.3) (10-14-2019)

* Geometry Types fromName method returns SF_NONE for non matching names

## [2.0.2](https://github.com/ngageoint/simple-features-ios/releases/tag/2.0.2) (04-03-2019)

* Geometry Type parent and child hierarchy utility methods
* Encode and decode geometry utility methods
* Geometry Envelope intersects, contains, and overlap while allowing empty
* 2D Centroid documentation clarification

## [2.0.1](https://github.com/ngageoint/simple-features-ios/releases/tag/2.0.1) (09-24-2018)

* Xcode 10 fix

## [2.0.0](https://github.com/ngageoint/simple-features-ios/releases/tag/2.0.0) (05-18-2018)

* Initial Release
