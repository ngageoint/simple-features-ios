//
//  SFTestCase.m
//  sf-ios
//
//  Created by Brian Osborn on 11/10/15.
//  Copyright © 2015 NGA. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SFTestUtils.h"
#import "SFGeometryTestUtils.h"

@interface SFTestCase : XCTestCase

@end

@implementation SFTestCase

static NSUInteger GEOMETRIES_PER_TEST = 10;

-(void) setUp {
    [super setUp];
}

-(void) tearDown {
    [super tearDown];
}

-(void) testPoint {
    for (int i = 0; i < GEOMETRIES_PER_TEST; i++) {
        // Create and test a point
        SFPoint * point = [SFGeometryTestUtils createPointWithHasZ:[SFTestUtils coinFlip] andHasM:[SFTestUtils coinFlip]];
        [self geometryTester: point];
    }
}

-(void) testLineString {
    for (int i = 0; i < GEOMETRIES_PER_TEST; i++) {
        // Create and test a line string
        SFLineString * lineString = [SFGeometryTestUtils createLineStringWithHasZ:[SFTestUtils coinFlip] andHasM:[SFTestUtils coinFlip]];
        [self geometryTester: lineString];
    }
}

-(void) testPolygon {
    for (int i = 0; i < GEOMETRIES_PER_TEST; i++) {
        // Create and test a polygon
        SFPolygon * polygon = [SFGeometryTestUtils createPolygonWithHasZ:[SFTestUtils coinFlip] andHasM:[SFTestUtils coinFlip]];
        [self geometryTester: polygon];
    }
}

-(void) testMultiPoint {
    for (int i = 0; i < GEOMETRIES_PER_TEST; i++) {
        // Create and test a multi point
        SFMultiPoint * multiPoint = [SFGeometryTestUtils createMultiPointWithHasZ:[SFTestUtils coinFlip] andHasM:[SFTestUtils coinFlip]];
        [self geometryTester: multiPoint];
    }
}

-(void) testMultiLineString {
    for (int i = 0; i < GEOMETRIES_PER_TEST; i++) {
        // Create and test a multi line string
        SFMultiLineString * multiLineString = [SFGeometryTestUtils createMultiLineStringWithHasZ:[SFTestUtils coinFlip] andHasM:[SFTestUtils coinFlip]];
        [self geometryTester: multiLineString];
    }
}

-(void) testMultiPolygon {
    for (int i = 0; i < GEOMETRIES_PER_TEST; i++) {
        // Create and test a multi polygon
        SFMultiPolygon * multiPolygon = [SFGeometryTestUtils createMultiPolygonWithHasZ:[SFTestUtils coinFlip] andHasM:[SFTestUtils coinFlip]];
        [self geometryTester: multiPolygon];
    }
}

-(void) testGeometryCollection {
    for (int i = 0; i < GEOMETRIES_PER_TEST; i++) {
        // Create and test a geometry collection
        SFGeometryCollection * geometryCollection = [SFGeometryTestUtils createGeometryCollectionWithHasZ:[SFTestUtils coinFlip] andHasM:[SFTestUtils coinFlip]];
        [self geometryTester: geometryCollection];
    }
}

-(void) geometryTester: (SFGeometry *) geometry{
    
    // Write the geometries to bytes
    NSData * data1 = [SFGeometryTestUtils writeDataWithGeometry:geometry andByteOrder:CFByteOrderBigEndian];
    NSData * data2 = [SFGeometryTestUtils writeDataWithGeometry:geometry andByteOrder:CFByteOrderLittleEndian];
    
    [SFTestUtils assertFalse:[SFGeometryTestUtils equalDataWithExpected:data1 andActual:data2]];
    
    // Test that the bytes are read using their written byte order, not
    // the specified
    SFGeometry * geometry1opposite = [SFGeometryTestUtils readGeometryWithData:data1 andByteOrder:CFByteOrderLittleEndian];
    SFGeometry * geometry2opposite = [SFGeometryTestUtils readGeometryWithData:data2 andByteOrder:CFByteOrderBigEndian];
    [SFGeometryTestUtils compareDataWithExpected:[SFGeometryTestUtils writeDataWithGeometry:geometry]
                                        andActual:[SFGeometryTestUtils writeDataWithGeometry:geometry1opposite]];
    [SFGeometryTestUtils compareDataWithExpected:[SFGeometryTestUtils writeDataWithGeometry:geometry]
                                        andActual:[SFGeometryTestUtils writeDataWithGeometry:geometry2opposite]];
    
    SFGeometry * geometry1 = [SFGeometryTestUtils readGeometryWithData:data1 andByteOrder:CFByteOrderBigEndian];
    SFGeometry * geometry2 = [SFGeometryTestUtils readGeometryWithData:data2 andByteOrder:CFByteOrderLittleEndian];
    
    [SFGeometryTestUtils compareGeometriesWithExpected:geometry andActual:geometry1];
    [SFGeometryTestUtils compareGeometriesWithExpected:geometry andActual:geometry2];
    [SFGeometryTestUtils compareGeometriesWithExpected:geometry1 andActual:geometry2];

}

@end
