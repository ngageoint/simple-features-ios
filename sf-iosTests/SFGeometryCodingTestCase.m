//
//  SFGeometryCodingTestCase.m
//  sf-iosTests
//
//  Created by Brian Osborn on 12/12/18.
//  Copyright © 2018 NGA. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SFGeometryUtils.h"
#import "SFGeometryTestUtils.h"
#import "SFTestUtils.h"

@interface SFGeometryCodingTestCase : XCTestCase

@end

@implementation SFGeometryCodingTestCase

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testPolygon {
    [self testCoding:[SFGeometryTestUtils createPolygonWithHasZ:[SFTestUtils coinFlip] andHasM:[SFTestUtils coinFlip]]];
}

- (void)testLineString {
    [self testCoding:[SFGeometryTestUtils createLineStringWithHasZ:[SFTestUtils coinFlip] andHasM:[SFTestUtils coinFlip]]];
}

- (void)testPoint {
    [self testCoding:[SFGeometryTestUtils createPointWithHasZ:[SFTestUtils coinFlip] andHasM:[SFTestUtils coinFlip]]];
}

- (void)testGeometryCollection {
    [self testCoding:[SFGeometryTestUtils createGeometryCollectionWithHasZ:[SFTestUtils coinFlip] andHasM:[SFTestUtils coinFlip]]];
}

- (void)testMultiPolygon {
    [self testCoding:[SFGeometryTestUtils createMultiPolygonWithHasZ:[SFTestUtils coinFlip] andHasM:[SFTestUtils coinFlip]]];
}

- (void)testMultiLineString {
    [self testCoding:[SFGeometryTestUtils createMultiLineStringWithHasZ:[SFTestUtils coinFlip] andHasM:[SFTestUtils coinFlip]]];
}

- (void)testMultiPoint {
    [self testCoding:[SFGeometryTestUtils createMultiPointWithHasZ:[SFTestUtils coinFlip] andHasM:[SFTestUtils coinFlip]]];
}

- (void)testCurvePolygon {
    [self testCoding:[SFGeometryTestUtils createCurvePolygonWithHasZ:[SFTestUtils coinFlip] andHasM:[SFTestUtils coinFlip]]];
}

- (void)testCompoundCurve {
    [self testCoding:[SFGeometryTestUtils createCompoundCurveWithHasZ:[SFTestUtils coinFlip] andHasM:[SFTestUtils coinFlip]]];
}

-(void) testCoding: (SFGeometry *) geometry{
    
    NSData *data = [SFGeometryUtils encodeGeometry:geometry];
    SFGeometry *decodedGeometry = [SFGeometryUtils decodeGeometry:data];
    
    [SFGeometryTestUtils compareGeometriesWithExpected:geometry andActual:decodedGeometry];
}

@end
