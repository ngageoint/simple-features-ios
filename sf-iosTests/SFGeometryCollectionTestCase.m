//
//  SFGeometryCollectionTestCase.m
//  sf-iosTests
//
//  Created by Brian Osborn on 4/25/18.
//  Copyright © 2018 NGA. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SFTestUtils.h"
#import "SFGeometryTestUtils.h"
#import "SFPoint.h"
#import "SFExtendedGeometryCollection.h"

@interface SFGeometryCollectionTestCase : XCTestCase

@end

@implementation SFGeometryCollectionTestCase

-(void) setUp {
    [super setUp];
}

-(void) tearDown {
    [super tearDown];
}

-(void) testMultiPoint {
    
    NSMutableArray<SFPoint *> *points = [[NSMutableArray alloc] init];
    for(int i = 0; i < 5; i++){
        [points addObject:[SFGeometryTestUtils createPointWithHasZ:[SFTestUtils coinFlip] andHasM:[SFTestUtils coinFlip]]];
    }
    NSMutableArray<SFGeometry *> *geometries = [[NSMutableArray alloc] init];
    [geometries addObjectsFromArray:points];
    
    SFMultiPoint *multiPoint = [[SFMultiPoint alloc] initWithPoints:points];
    SFGeometryCollection *geometryCollection = [[SFGeometryCollection alloc] initWithGeometries:geometries];

    [SFTestUtils assertEqualIntWithValue:[multiPoint numPoints] andValue2:[geometryCollection numGeometries]];
    [SFTestUtils assertEqualIntWithValue:[multiPoint numGeometries] andValue2:[geometryCollection numGeometries]];
    [SFTestUtils assertEqualWithValue:multiPoint.geometries andValue2:geometryCollection.geometries];
    
    [SFTestUtils assertTrue:[multiPoint isMultiPoint]];
    [SFTestUtils assertEqualIntWithValue:SF_MULTIPOINT andValue2:[multiPoint collectionType]];
    [SFTestUtils assertFalse:[multiPoint isMultiLineString]];
    [SFTestUtils assertFalse:[multiPoint isMultiCurve]];
    [SFTestUtils assertFalse:[multiPoint isMultiPolygon]];
    [SFTestUtils assertFalse:[multiPoint isMultiSurface]];
    
    [SFTestUtils assertTrue:[geometryCollection isMultiPoint]];
    [SFTestUtils assertEqualIntWithValue:SF_MULTIPOINT andValue2:[geometryCollection collectionType]];
    [SFTestUtils assertFalse:[geometryCollection isMultiLineString]];
    [SFTestUtils assertFalse:[geometryCollection isMultiCurve]];
    [SFTestUtils assertFalse:[geometryCollection isMultiPolygon]];
    [SFTestUtils assertFalse:[geometryCollection isMultiSurface]];
    
    SFMultiPoint *multiPoint2 = [geometryCollection asMultiPoint];
    [SFTestUtils assertEqualWithValue:multiPoint andValue2:multiPoint2];
    [SFTestUtils assertEqualWithValue:multiPoint2 andValue2:[multiPoint asMultiPoint]];
    
    SFGeometryCollection *geometryCollection2 = [multiPoint asGeometryCollection];
    [SFTestUtils assertEqualWithValue:geometryCollection andValue2: geometryCollection2];
    [SFTestUtils assertEqualWithValue:geometryCollection2 andValue2:[geometryCollection asGeometryCollection]];
    
    SFExtendedGeometryCollection *extendedGeometryCollection = [[SFExtendedGeometryCollection alloc] initWithGeometryCollection:geometryCollection];
    [SFTestUtils assertEqualIntWithValue:SF_GEOMETRYCOLLECTION andValue2:extendedGeometryCollection.geometryType];
    [SFTestUtils assertEqualIntWithValue:SF_MULTIPOINT andValue2:[extendedGeometryCollection collectionType]];
    [SFTestUtils assertEqualWithValue:extendedGeometryCollection andValue2:[[SFExtendedGeometryCollection alloc] initWithGeometryCollection:geometryCollection]];
    
}

@end
