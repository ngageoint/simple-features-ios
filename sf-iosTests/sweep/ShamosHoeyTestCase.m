//
//  ShamosHoeyTestCase.m
//  sf-iosTests
//
//  Created by Brian Osborn on 1/12/18.
//  Copyright © 2018 NGA. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SFTestUtils.h"
#import "SFShamosHoey.h"

@interface ShamosHoeyTestCase : XCTestCase

@end

@implementation ShamosHoeyTestCase

-(void) setUp {
    [super setUp];
}

-(void) tearDown {
    [super tearDown];
}

- (void)testSimple {
    
    NSMutableArray<SFPoint *> *points = [NSMutableArray array];
    
    [self addPoint:points withX:0 andY:0];
    [self addPoint:points withX:1 andY:0];
    [self addPoint:points withX:.5 andY:1];
    
    [SFTestUtils assertTrue:[SFShamosHoey simplePolygonPoints:points]];
    [SFTestUtils assertTrue:[SFShamosHoey simplePolygonRing:[SFLineString lineStringWithPoints:points]]];
    [SFTestUtils assertTrue:[SFShamosHoey simplePolygon:[SFPolygon polygonWithRing:[SFLineString lineStringWithPoints:points]]]];
    [SFTestUtils assertTrue:[[SFLineString lineStringWithPoints:points] isSimple]];
    [self simple:[SFPolygon polygonWithRing:[SFLineString lineStringWithPoints:points]]];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:(int)points.count];
    
    [self addPoint:points withX:0 andY:0];
    
    [SFTestUtils assertTrue:[SFShamosHoey simplePolygonPoints:points]];
    [SFTestUtils assertTrue:[SFShamosHoey simplePolygonRing:[SFLineString lineStringWithPoints:points]]];
    [SFTestUtils assertTrue:[SFShamosHoey simplePolygon:[SFPolygon polygonWithRing:[SFLineString lineStringWithPoints:points]]]];
    [SFTestUtils assertTrue:[[SFLineString lineStringWithPoints:points] isSimple]];
    [self simple:[SFPolygon polygonWithRing:[SFLineString lineStringWithPoints:points]]];
    [SFTestUtils assertEqualIntWithValue:4 andValue2:(int)points.count];
    
    [points removeAllObjects];
    
    [self addPoint:points withX:0 andY:100];
    [self addPoint:points withX:100 andY:0];
    [self addPoint:points withX:200 andY:100];
    [self addPoint:points withX:100 andY:200];
    [self addPoint:points withX:0 andY:100];
    
    [SFTestUtils assertTrue:[SFShamosHoey simplePolygonPoints:points]];
    [SFTestUtils assertTrue:[SFShamosHoey simplePolygonRing:[SFLineString lineStringWithPoints:points]]];
    [SFTestUtils assertTrue:[SFShamosHoey simplePolygon:[SFPolygon polygonWithRing:[SFLineString lineStringWithPoints:points]]]];
    [SFTestUtils assertTrue:[[SFLineString lineStringWithPoints:points] isSimple]];
    [self simple:[SFPolygon polygonWithRing:[SFLineString lineStringWithPoints:points]]];
    [SFTestUtils assertEqualIntWithValue:5 andValue2:(int)points.count];
    
    [points removeAllObjects];
    
    [self addPoint:points withX:-104.8384094 andY:39.753657];
    [self addPoint:points withX:-104.8377228 andY:39.7354422];
    [self addPoint:points withX:-104.7930908 andY:39.7364983];
    [self addPoint:points withX:-104.8233891 andY:39.7440222];
    [self addPoint:points withX:-104.7930908 andY:39.7369603];
    [self addPoint:points withX:-104.808197 andY:39.7541849];
    [self addPoint:points withX:-104.8383236 andY:39.753723];
    
    [SFTestUtils assertTrue:[SFShamosHoey simplePolygonPoints:points]];    [SFTestUtils assertTrue:[SFShamosHoey simplePolygonRing:[SFLineString lineStringWithPoints:points]]];
    [SFTestUtils assertTrue:[SFShamosHoey simplePolygon:[SFPolygon polygonWithRing:[SFLineString lineStringWithPoints:points]]]];
    [SFTestUtils assertTrue:[[SFLineString lineStringWithPoints:points] isSimple]];
    [self simple:[SFPolygon polygonWithRing:[SFLineString lineStringWithPoints:points]]];
    [SFTestUtils assertEqualIntWithValue:7 andValue2:(int)points.count];
    
    [points removeAllObjects];
    
    [self addPoint:points withX:-106.3256836 andY:40.2962865];
    [self addPoint:points withX:-105.6445313 andY:38.5911138];
    [self addPoint:points withX:-105.0842285 andY:40.3046654];
    [self addPoint:points withX:-105.6445313 andY:38.5911139];
    
    [SFTestUtils assertTrue:[SFShamosHoey simplePolygonPoints:points]];
    [SFTestUtils assertTrue:[SFShamosHoey simplePolygonRing:[SFLineString lineStringWithPoints:points]]];
    [SFTestUtils assertTrue:[SFShamosHoey simplePolygon:[SFPolygon polygonWithRing:[SFLineString lineStringWithPoints:points]]]];
    [SFTestUtils assertTrue:[[SFLineString lineStringWithPoints:points] isSimple]];
    [self simple:[SFPolygon polygonWithRing:[SFLineString lineStringWithPoints:points]]];
    [SFTestUtils assertEqualIntWithValue:4 andValue2:(int)points.count];
}

- (void)testNonSimple {
    
    NSMutableArray<SFPoint *> *points = [NSMutableArray array];
    
    [self addPoint:points withX:0 andY:0];
    
    [SFTestUtils assertFalse:[SFShamosHoey simplePolygonPoints:points]];
    [SFTestUtils assertFalse:[SFShamosHoey simplePolygonRing:[SFLineString lineStringWithPoints:points]]];
    [SFTestUtils assertFalse:[SFShamosHoey simplePolygon:[SFPolygon polygonWithRing:[SFLineString lineStringWithPoints:points]]]];
    [SFTestUtils assertFalse:[[SFLineString lineStringWithPoints:points] isSimple]];
    [self complex:[SFPolygon polygonWithRing:[SFLineString lineStringWithPoints:points]]];
    [SFTestUtils assertEqualIntWithValue:1 andValue2:(int)points.count];
    
    [self addPoint:points withX:1 andY:0];
    
    [SFTestUtils assertFalse:[SFShamosHoey simplePolygonPoints:points]];
    [SFTestUtils assertFalse:[SFShamosHoey simplePolygonRing:[SFLineString lineStringWithPoints:points]]];
    [SFTestUtils assertFalse:[SFShamosHoey simplePolygon:[SFPolygon polygonWithRing:[SFLineString lineStringWithPoints:points]]]];
    [SFTestUtils assertFalse:[[SFLineString lineStringWithPoints:points] isSimple]];
    [self complex:[SFPolygon polygonWithRing:[SFLineString lineStringWithPoints:points]]];
    [SFTestUtils assertEqualIntWithValue:2 andValue2:(int)points.count];
    
    [self addPoint:points withX:0 andY:0];
    
    [SFTestUtils assertFalse:[SFShamosHoey simplePolygonPoints:points]];
    [SFTestUtils assertFalse:[SFShamosHoey simplePolygonRing:[SFLineString lineStringWithPoints:points]]];
    [SFTestUtils assertFalse:[SFShamosHoey simplePolygon:[SFPolygon polygonWithRing:[SFLineString lineStringWithPoints:points]]]];
    [SFTestUtils assertFalse:[[SFLineString lineStringWithPoints:points] isSimple]];
    [self complex:[SFPolygon polygonWithRing:[SFLineString lineStringWithPoints:points]]];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:(int)points.count];
    
    [points removeAllObjects];
    
    [self addPoint:points withX:0 andY:100];
    [self addPoint:points withX:100 andY:0];
    [self addPoint:points withX:200 andY:100];
    [self addPoint:points withX:100 andY:200];
    [self addPoint:points withX:100.01 andY:200];
    [self addPoint:points withX:0 andY:100];
    
    [SFTestUtils assertFalse:[SFShamosHoey simplePolygonPoints:points]];
    [SFTestUtils assertFalse:[SFShamosHoey simplePolygonRing:[SFLineString lineStringWithPoints:points]]];
    [SFTestUtils assertFalse:[SFShamosHoey simplePolygon:[SFPolygon polygonWithRing:[SFLineString lineStringWithPoints:points]]]];
    [SFTestUtils assertFalse:[[SFLineString lineStringWithPoints:points] isSimple]];
    [self complex:[SFPolygon polygonWithRing:[SFLineString lineStringWithPoints:points]]];
    [SFTestUtils assertEqualIntWithValue:6 andValue2:(int)points.count];
    
    [points removeAllObjects];
    
    [self addPoint:points withX:-104.8384094 andY:39.753657];
    [self addPoint:points withX:-104.8377228 andY:39.7354422];
    [self addPoint:points withX:-104.7930908 andY:39.7364983];
    [self addPoint:points withX:-104.8233891 andY:39.7440222];
    [self addPoint:points withX:-104.8034763 andY:39.7387424];
    [self addPoint:points withX:-104.7930908 andY:39.7369603];
    [self addPoint:points withX:-104.808197 andY:39.7541849];
    [self addPoint:points withX:-104.8383236 andY:39.753723];
    
    [SFTestUtils assertFalse:[SFShamosHoey simplePolygonPoints:points]];
    [SFTestUtils assertFalse:[SFShamosHoey simplePolygonRing:[SFLineString lineStringWithPoints:points]]];
    [SFTestUtils assertFalse:[SFShamosHoey simplePolygon:[SFPolygon polygonWithRing:[SFLineString lineStringWithPoints:points]]]];
    [SFTestUtils assertFalse:[[SFLineString lineStringWithPoints:points] isSimple]];
    [self complex:[SFPolygon polygonWithRing:[SFLineString lineStringWithPoints:points]]];
    [SFTestUtils assertEqualIntWithValue:8 andValue2:(int)points.count];
    
    [points removeAllObjects];
    
    [self addPoint:points withX:-106.3256836 andY:40.2962865];
    [self addPoint:points withX:-105.6445313 andY:38.5911138];
    [self addPoint:points withX:-105.0842285 andY:40.3046654];
    [self addPoint:points withX:-105.6445313 andY:38.5911138];
    
    [SFTestUtils assertFalse:[SFShamosHoey simplePolygonPoints:points]];
    [SFTestUtils assertFalse:[SFShamosHoey simplePolygonRing:[SFLineString lineStringWithPoints:points]]];
    [SFTestUtils assertFalse:[SFShamosHoey simplePolygon:[SFPolygon polygonWithRing:[SFLineString lineStringWithPoints:points]]]];
    [SFTestUtils assertFalse:[[SFLineString lineStringWithPoints:points] isSimple]];
    [self complex:[SFPolygon polygonWithRing:[SFLineString lineStringWithPoints:points]]];
    [SFTestUtils assertEqualIntWithValue:4 andValue2:(int)points.count];
    
    [points removeAllObjects];
    
    [self addPoint:points withX:1 andY:0];
    [self addPoint:points withX:0 andY:1];
    [self addPoint:points withX:1 andY:0];
    [self addPoint:points withX:2 andY:2];
    
    [SFTestUtils assertFalse:[SFShamosHoey simplePolygonPoints:points]];
    [SFTestUtils assertFalse:[SFShamosHoey simplePolygonRing:[SFLineString lineStringWithPoints:points]]];
    [SFTestUtils assertFalse:[SFShamosHoey simplePolygon:[SFPolygon polygonWithRing:[SFLineString lineStringWithPoints:points]]]];
    [SFTestUtils assertFalse:[[SFLineString lineStringWithPoints:points] isSimple]];
    [self complex:[SFPolygon polygonWithRing:[SFLineString lineStringWithPoints:points]]];
    [SFTestUtils assertEqualIntWithValue:4 andValue2:(int)points.count];
    
}

- (void)testSimpleHole {
    
    SFPolygon *polygon = [SFPolygon polygon];
    
    NSMutableArray<SFPoint *> *points = [NSMutableArray array];
    
    [self addPoint:points withX:0 andY:0];
    [self addPoint:points withX:10 andY:0];
    [self addPoint:points withX:5 andY:10];
    
    SFLineString *ring = [SFLineString lineString];
    ring.points = points;
    
    [polygon addRing:ring];
    
    [SFTestUtils assertTrue:[SFShamosHoey simplePolygon:polygon]];
    [self simple:polygon];
    [SFTestUtils assertEqualIntWithValue:1 andValue2:[polygon numRings]];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:[((SFLineString *)[polygon.rings objectAtIndex:0]) numPoints]];
    
    NSMutableArray<SFPoint *> *holePoints = [NSMutableArray array];
    
    [self addPoint:holePoints withX:1 andY:1];
    [self addPoint:holePoints withX:9 andY:1];
    [self addPoint:holePoints withX:5 andY:9];
    
    SFLineString *hole = [SFLineString lineString];
    hole.points = holePoints;
    
    [polygon addRing:hole];
    
    [SFTestUtils assertTrue:[SFShamosHoey simplePolygon:polygon]];
    [self simple:polygon];
    [SFTestUtils assertEqualIntWithValue:2 andValue2:[polygon numRings]];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:[((SFLineString *)[polygon.rings objectAtIndex:0]) numPoints]];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:[((SFLineString *)[polygon.rings objectAtIndex:1]) numPoints]];
    
}

- (void)testNonSimpleHole {
    
    SFPolygon *polygon = [SFPolygon polygon];
    
    NSMutableArray<SFPoint *> *points = [NSMutableArray array];
    
    [self addPoint:points withX:0 andY:0];
    [self addPoint:points withX:10 andY:0];
    [self addPoint:points withX:5 andY:10];
    
    SFLineString *ring = [SFLineString lineString];
    ring.points = points;
    
    [polygon addRing:ring];
    
    [SFTestUtils assertTrue:[SFShamosHoey simplePolygon:polygon]];
    [self simple:polygon];
    [SFTestUtils assertEqualIntWithValue:1 andValue2:[polygon numRings]];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:[((SFLineString *)[polygon.rings objectAtIndex:0]) numPoints]];
    
    NSMutableArray<SFPoint *> *holePoints = [NSMutableArray array];
    
    [self addPoint:holePoints withX:1 andY:1];
    [self addPoint:holePoints withX:9 andY:1];
    [self addPoint:holePoints withX:5 andY:9];
    [self addPoint:holePoints withX:5.000001 andY:9];
    
    SFLineString *hole = [SFLineString lineString];
    hole.points = holePoints;
    
    [polygon addRing:hole];
    
    [SFTestUtils assertFalse:[SFShamosHoey simplePolygon:polygon]];
    [self complex:polygon];
    [SFTestUtils assertEqualIntWithValue:2 andValue2:[polygon numRings]];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:[((SFLineString *)[polygon.rings objectAtIndex:0]) numPoints]];
    [SFTestUtils assertEqualIntWithValue:4 andValue2:[((SFLineString *)[polygon.rings objectAtIndex:1]) numPoints]];
    
}

- (void)testIntersectingHole {
    
    SFPolygon *polygon = [SFPolygon polygon];
    
    NSMutableArray<SFPoint *> *points = [NSMutableArray array];
    
    [self addPoint:points withX:0 andY:0];
    [self addPoint:points withX:10 andY:0];
    [self addPoint:points withX:5 andY:10];
    
    SFLineString *ring = [SFLineString lineString];
    ring.points = points;
    
    [polygon addRing:ring];
    
    [SFTestUtils assertTrue:[SFShamosHoey simplePolygon:polygon]];
    [self simple:polygon];
    [SFTestUtils assertEqualIntWithValue:1 andValue2:[polygon numRings]];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:[((SFLineString *)[polygon.rings objectAtIndex:0]) numPoints]];
    
    NSMutableArray<SFPoint *> *holePoints = [NSMutableArray array];
    
    [self addPoint:holePoints withX:1 andY:1];
    [self addPoint:holePoints withX:9 andY:1];
    [self addPoint:holePoints withX:5 andY:10];
    
    SFLineString *hole = [SFLineString lineString];
    hole.points = holePoints;
    
    [polygon addRing:hole];
    
    [SFTestUtils assertFalse:[SFShamosHoey simplePolygon:polygon]];
    [self complex:polygon];
    [SFTestUtils assertEqualIntWithValue:2 andValue2:[polygon numRings]];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:[((SFLineString *)[polygon.rings objectAtIndex:0]) numPoints]];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:[((SFLineString *)[polygon.rings objectAtIndex:1]) numPoints]];
    
}

- (void)testIntersectingHoles {
    
    SFPolygon *polygon = [SFPolygon polygon];
    
    NSMutableArray<SFPoint *> *points = [NSMutableArray array];
    
    [self addPoint:points withX:0 andY:0];
    [self addPoint:points withX:10 andY:0];
    [self addPoint:points withX:5 andY:10];
    
    SFLineString *ring = [SFLineString lineString];
    ring.points = points;
    
    [polygon addRing:ring];
    
    [SFTestUtils assertTrue:[SFShamosHoey simplePolygon:polygon]];
    [self simple:polygon];
    [SFTestUtils assertEqualIntWithValue:1 andValue2:[polygon numRings]];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:[((SFLineString *)[polygon.rings objectAtIndex:0]) numPoints]];
    
    NSMutableArray<SFPoint *> *holePoints1 = [NSMutableArray array];
    
    [self addPoint:holePoints1 withX:1 andY:1];
    [self addPoint:holePoints1 withX:9 andY:1];
    [self addPoint:holePoints1 withX:5 andY:9];
    
    SFLineString *hole1 = [SFLineString lineString];
    hole1.points = holePoints1;
    
    [polygon addRing:hole1];
    
    [SFTestUtils assertTrue:[SFShamosHoey simplePolygon:polygon]];
    [self simple:polygon];
    [SFTestUtils assertEqualIntWithValue:2 andValue2:[polygon numRings]];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:[((SFLineString *)[polygon.rings objectAtIndex:0]) numPoints]];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:[((SFLineString *)[polygon.rings objectAtIndex:1]) numPoints]];
    
    NSMutableArray<SFPoint *> *holePoints2 = [NSMutableArray array];
    
    [self addPoint:holePoints2 withX:5.0 andY:0.1];
    [self addPoint:holePoints2 withX:6.0 andY:0.1];
    [self addPoint:holePoints2 withX:5.5 andY:1.00001];
    
    SFLineString *hole2 = [SFLineString lineString];
    hole2.points = holePoints2;
    
    [polygon addRing:hole2];
    
    [SFTestUtils assertFalse:[SFShamosHoey simplePolygon:polygon]];
    [self complex:polygon];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:[polygon numRings]];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:[((SFLineString *)[polygon.rings objectAtIndex:0]) numPoints]];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:[((SFLineString *)[polygon.rings objectAtIndex:1]) numPoints]];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:[((SFLineString *)[polygon.rings objectAtIndex:2]) numPoints]];
    
}

- (void)testHoleInsideHole {
    
    SFPolygon *polygon = [SFPolygon polygon];
    
    NSMutableArray<SFPoint *> *points = [NSMutableArray array];
    
    [self addPoint:points withX:0 andY:0];
    [self addPoint:points withX:10 andY:0];
    [self addPoint:points withX:5 andY:10];
    
    SFLineString *ring = [SFLineString lineString];
    ring.points = points;
    
    [polygon addRing:ring];
    
    [SFTestUtils assertTrue:[SFShamosHoey simplePolygon:polygon]];
    [self simple:polygon];
    [SFTestUtils assertEqualIntWithValue:1 andValue2:[polygon numRings]];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:[((SFLineString *)[polygon.rings objectAtIndex:0]) numPoints]];
    
    NSMutableArray<SFPoint *> *holePoints1 = [NSMutableArray array];
    
    [self addPoint:holePoints1 withX:1 andY:1];
    [self addPoint:holePoints1 withX:9 andY:1];
    [self addPoint:holePoints1 withX:5 andY:9];
    
    SFLineString *hole1 = [SFLineString lineString];
    hole1.points = holePoints1;
    
    [polygon addRing:hole1];
    
    [SFTestUtils assertTrue:[SFShamosHoey simplePolygon:polygon]];
    [self simple:polygon];
    [SFTestUtils assertEqualIntWithValue:2 andValue2:[polygon numRings]];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:[((SFLineString *)[polygon.rings objectAtIndex:0]) numPoints] ];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:[((SFLineString *)[polygon.rings objectAtIndex:1]) numPoints]];
    
    NSMutableArray<SFPoint *> *holePoints2 = [NSMutableArray array];
    
    [self addPoint:holePoints2 withX:2 andY:2];
    [self addPoint:holePoints2 withX:8 andY:2];
    [self addPoint:holePoints2 withX:5 andY:8];
    
    SFLineString *hole2 = [SFLineString lineString];
    hole2.points = holePoints2;
    
    [polygon addRing:hole2];
    
    [SFTestUtils assertFalse:[SFShamosHoey simplePolygon:polygon]];
    [self complex:polygon];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:[polygon numRings]];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:[((SFLineString *)[polygon.rings objectAtIndex:0]) numPoints]];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:[((SFLineString *)[polygon.rings objectAtIndex:1]) numPoints]];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:[((SFLineString *)[polygon.rings objectAtIndex:2]) numPoints]];
    
}

- (void)testExternalHole {
    
    SFPolygon *polygon = [SFPolygon polygon];
    
    NSMutableArray<SFPoint *> *points = [NSMutableArray array];
    
    [self addPoint:points withX:0 andY:0];
    [self addPoint:points withX:10 andY:0];
    [self addPoint:points withX:5 andY:10];
    
    SFLineString *ring = [SFLineString lineString];
    ring.points = points;
    
    [polygon addRing:ring];
    
    [SFTestUtils assertTrue:[SFShamosHoey simplePolygon:polygon]];
    [self simple:polygon];
    [SFTestUtils assertEqualIntWithValue:1 andValue2:[polygon numRings]];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:[((SFLineString *)[polygon.rings objectAtIndex:0]) numPoints]];
    
    NSMutableArray<SFPoint *> *holePoints = [NSMutableArray array];
    
    [self addPoint:holePoints withX:-1 andY:1];
    [self addPoint:holePoints withX:-1 andY:3];
    [self addPoint:holePoints withX:-2 andY:1];
    
    SFLineString *hole = [SFLineString lineString];
    hole.points = holePoints;
    
    [polygon addRing:hole];
    
    [SFTestUtils assertFalse:[SFShamosHoey simplePolygon:polygon]];
    [self complex:polygon];
    [SFTestUtils assertEqualIntWithValue:2 andValue2:[polygon numRings]];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:[((SFLineString *)[polygon.rings objectAtIndex:0]) numPoints]];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:[((SFLineString *)[polygon.rings objectAtIndex:1]) numPoints]];
    
}

- (void)testLargeSimple {
    
    double increment = .01;
    double radius = 1250;
    double x = -radius + increment;
    double y = 0;
    
    NSMutableArray<SFPoint *> *points = [NSMutableArray array];
    
    while (x <= radius) {
        if (x <= 0) {
            y -= increment;
        } else {
            y += increment;
        }
        [self addPoint:points withX:x andY:y];
        x += increment;
    }
    
    x = radius - increment;
    while (x >= -radius) {
        if (x >= 0) {
            y += increment;
        } else {
            y -= increment;
        }
        [self addPoint:points withX:x andY:y];
        x -= increment;
    }
    
    [SFTestUtils assertTrue:[SFShamosHoey simplePolygonPoints:points]];
    [SFTestUtils assertTrue:[SFShamosHoey simplePolygonRing:[SFLineString lineStringWithPoints:points]]];
    [SFTestUtils assertTrue:[SFShamosHoey simplePolygon:[SFPolygon polygonWithRing:[SFLineString lineStringWithPoints:points]]]];
    [SFTestUtils assertTrue:[[SFLineString lineStringWithPoints:points] isSimple]];
    [SFTestUtils assertTrue:[[SFPolygon polygonWithRing:[SFLineString lineStringWithPoints:points]] isSimple]];
    [SFTestUtils assertEqualIntWithValue:(int) (radius / increment * 4) andValue2:(int)points.count];
    
}

- (void)testLargeNonSimple {
    
    double increment = .01;
    double radius = 1250;
    double x = -radius + increment;
    double y = 0;
    
    NSMutableArray<SFPoint *> *points = [NSMutableArray array];
    
    while (x <= radius) {
        if (x <= 0) {
            y -= increment;
        } else {
            y += increment;
        }
        [self addPoint:points withX:x andY:y];
        x += increment;
    }
    
    SFPoint *previousPoint = [points objectAtIndex:points.count - 2];
    int invalidIndex = (int)points.count;
    [self addPoint:points withX:[previousPoint.x doubleValue] andY:[previousPoint.y doubleValue] - .000001];
    
    x = radius - increment;
    while (x >= -radius) {
        if (x >= 0) {
            y += increment;
        } else {
            y -= increment;
        }
        [self addPoint:points withX:x andY:y];
        x -= increment;
    }
    
    [SFTestUtils assertFalse:[SFShamosHoey simplePolygonPoints:points]];
    [SFTestUtils assertFalse:[SFShamosHoey simplePolygonRing:[SFLineString lineStringWithPoints:points]]];
    [SFTestUtils assertFalse:[SFShamosHoey simplePolygon:[SFPolygon polygonWithRing:[SFLineString lineStringWithPoints:points]]]];
    [SFTestUtils assertFalse:[[SFLineString lineStringWithPoints:points] isSimple]];
    [SFTestUtils assertFalse:[[SFPolygon polygonWithRing:[SFLineString lineStringWithPoints:points]] isSimple]];
    [SFTestUtils assertEqualIntWithValue:1 + (int) (radius / increment * 4) andValue2:(int)points.count];
    
    [points removeObjectAtIndex:invalidIndex];
    previousPoint = [points objectAtIndex:points.count - 3];
    [self addPoint:points withX:[previousPoint.x doubleValue] andY:[previousPoint.y doubleValue] + .000000000000001];
    
    [SFTestUtils assertFalse:[SFShamosHoey simplePolygonPoints:points]];
    [SFTestUtils assertFalse:[SFShamosHoey simplePolygonRing:[SFLineString lineStringWithPoints:points]]];
    [SFTestUtils assertFalse:[SFShamosHoey simplePolygon:[SFPolygon polygonWithRing:[SFLineString lineStringWithPoints:points]]]];
    [SFTestUtils assertFalse:[[SFLineString lineStringWithPoints:points] isSimple]];
    [SFTestUtils assertFalse:[[SFPolygon polygonWithRing:[SFLineString lineStringWithPoints:points]] isSimple]];
    [SFTestUtils assertEqualIntWithValue:1 + (int) (radius / increment * 4) andValue2:(int)points.count];
    
}

- (void) testPolygons1 {
    
    SFLineString *ring = [SFLineString lineString];
    [ring addPoint:[SFPoint pointWithXValue:0 andYValue:0]];
    [ring addPoint:[SFPoint pointWithXValue:4 andYValue:4]];
    [ring addPoint:[SFPoint pointWithXValue:0 andYValue:4]];
    [ring addPoint:[SFPoint pointWithXValue:4 andYValue:0]];
    SFPolygon *polygon = [SFPolygon polygonWithRing:ring];
    
    [self complex:polygon];
    
    ring = [SFLineString lineString];
    [ring addPoint:[SFPoint pointWithXValue:0 andYValue:0]];
    [ring addPoint:[SFPoint pointWithXValue:4 andYValue:0]];
    [ring addPoint:[SFPoint pointWithXValue:4 andYValue:4]];
    [ring addPoint:[SFPoint pointWithXValue:0 andYValue:4]];
    polygon = [SFPolygon polygonWithRing:ring];
    
    [self simple:polygon];
    
    ring = [SFLineString lineString];
    [ring addPoint:[SFPoint pointWithXValue:0 andYValue:4]];
    [ring addPoint:[SFPoint pointWithXValue:4 andYValue:0]];
    [ring addPoint:[SFPoint pointWithXValue:0 andYValue:0]];
    [ring addPoint:[SFPoint pointWithXValue:4 andYValue:4]];
    polygon = [SFPolygon polygonWithRing:ring];
    
    [self complex:polygon];
    
    ring = [SFLineString lineString];
    [ring addPoint:[SFPoint pointWithXValue:0 andYValue:4]];
    [ring addPoint:[SFPoint pointWithXValue:4 andYValue:4]];
    [ring addPoint:[SFPoint pointWithXValue:4 andYValue:0]];
    [ring addPoint:[SFPoint pointWithXValue:0 andYValue:0]];
    polygon = [SFPolygon polygonWithRing:ring];
    
    [self simple:polygon];
    
    ring = [SFLineString lineString];
    [ring addPoint:[SFPoint pointWithXValue:0 andYValue:0]];
    [ring addPoint:[SFPoint pointWithXValue:4 andYValue:4]];
    [ring addPoint:[SFPoint pointWithXValue:1 andYValue:3]];
    [ring addPoint:[SFPoint pointWithXValue:3 andYValue:1]];
    polygon = [SFPolygon polygonWithRing:ring];
    
    [self complex:polygon];
    
    ring = [SFLineString lineString];
    [ring addPoint:[SFPoint pointWithXValue:0 andYValue:0]];
    [ring addPoint:[SFPoint pointWithXValue:3 andYValue:1]];
    [ring addPoint:[SFPoint pointWithXValue:4 andYValue:4]];
    [ring addPoint:[SFPoint pointWithXValue:1 andYValue:3]];
    polygon = [SFPolygon polygonWithRing:ring];
    
    [self simple:polygon];
    
    ring = [SFLineString lineString];
    [ring addPoint:[SFPoint pointWithXValue:1 andYValue:3]];
    [ring addPoint:[SFPoint pointWithXValue:3 andYValue:1]];
    [ring addPoint:[SFPoint pointWithXValue:0 andYValue:0]];
    [ring addPoint:[SFPoint pointWithXValue:4 andYValue:4]];
    polygon = [SFPolygon polygonWithRing:ring];
    
    [self complex:polygon];
    
    ring = [SFLineString lineString];
    [ring addPoint:[SFPoint pointWithXValue:1 andYValue:3]];
    [ring addPoint:[SFPoint pointWithXValue:4 andYValue:4]];
    [ring addPoint:[SFPoint pointWithXValue:3 andYValue:1]];
    [ring addPoint:[SFPoint pointWithXValue:0 andYValue:0]];
    polygon = [SFPolygon polygonWithRing:ring];
    
    [self simple:polygon];
    
}

- (void) testPolygons2 {

    SFLineString *ring = [SFLineString lineString];
    [ring addPoint:[SFPoint pointWithXValue:119.65450502825215 andYValue:234.97190110269844]];
    [ring addPoint:[SFPoint pointWithXValue:120.94208471603682 andYValue:241.47274889005215]];
    [ring addPoint:[SFPoint pointWithXValue:120.57389187028015 andYValue:240.42380619065557]];
    [ring addPoint:[SFPoint pointWithXValue:120.40553233952696 andYValue:239.3249423106921]];
    [ring addPoint:[SFPoint pointWithXValue:120.44278575100797 andYValue:238.2138802324909]];
    [ring addPoint:[SFPoint pointWithXValue:120.68437322950616 andYValue:237.12876169126298]];
    [ring addPoint:[SFPoint pointWithXValue:121.12200129996195 andYValue:236.1068378045508]];
    [ring addPoint:[SFPoint pointWithXValue:121.74064659481407 andYValue:235.18319027576013]];
    [ring addPoint:[SFPoint pointWithXValue:122.51907159233552 andYValue:234.38952707167576]];
    SFPolygon *polygon = [SFPolygon polygonWithRing:ring];

    [self complex:polygon];

    ring = [SFLineString lineString];
    [ring addPoint:[SFPoint pointWithXValue:119.65450502825215 andYValue:234.97190110269844]];
    [ring addPoint:[SFPoint pointWithXValue:120.94208471603682 andYValue:241.47274889005215]];
    // [ring addPoint:[SFPoint pointWithXValue:120.57389187028015 andYValue:240.42380619065557]];
    // [ring addPoint:[SFPoint pointWithXValue:120.40553233952696 andYValue:239.3249423106921]];
    [ring addPoint:[SFPoint pointWithXValue:120.44278575100797 andYValue:238.2138802324909]];
    [ring addPoint:[SFPoint pointWithXValue:120.68437322950616 andYValue:237.12876169126298]];
    [ring addPoint:[SFPoint pointWithXValue:121.12200129996195 andYValue:236.1068378045508]];
    [ring addPoint:[SFPoint pointWithXValue:121.74064659481407 andYValue:235.18319027576013]];
    [ring addPoint:[SFPoint pointWithXValue:122.51907159233552 andYValue:234.38952707167576]];
    polygon = [SFPolygon polygonWithRing:ring];

    [self simple:polygon];

    ring = [SFLineString lineString];
    [ring addPoint:[SFPoint pointWithXValue:119.65450502825215 andYValue:234.97190110269844]];
    [ring addPoint:[SFPoint pointWithXValue:120.94208471603682 andYValue:241.47274889005215]];
    // [ring addPoint:[SFPoint pointWithXValue:120.57389187028015 andYValue:240.42380619065557]];
    // [ring addPoint:[SFPoint pointWithXValue:120.40553233952696 andYValue:239.3249423106921]];
    [ring addPoint:[SFPoint pointWithXValue:120.44278575100797 andYValue:238.2138802324909]];
    [ring addPoint:[SFPoint pointWithXValue:120.68437322950616 andYValue:237.12876169126298]];
    [ring addPoint:[SFPoint pointWithXValue:121.12200129996195 andYValue:236.1068378045508]];
    [ring addPoint:[SFPoint pointWithXValue:121.74064659481407 andYValue:235.18319027576013]];
    [ring addPoint:[SFPoint pointWithXValue:122.51907159233552 andYValue:234.38952707167576]];
    [ring addPoint:[SFPoint pointWithXValue:119.65450502825215 andYValue:234.97190110269844]];
    polygon = [SFPolygon polygonWithRing:ring];

    [self simple:polygon];

    ring = [SFLineString lineString];
    [ring addPoint:[SFPoint pointWithXValue:119.65450502825215 andYValue:234.97190110269844]];
    [ring addPoint:[SFPoint pointWithXValue:120.94208471603682 andYValue:241.47274889005215]];
    [ring addPoint:[SFPoint pointWithXValue:120.57389187028015 andYValue:240.42380619065557]];
    // [ring addPoint:[SFPoint pointWithXValue:120.40553233952696 andYValue:239.3249423106921]];
    [ring addPoint:[SFPoint pointWithXValue:120.44278575100797 andYValue:238.2138802324909]];
    [ring addPoint:[SFPoint pointWithXValue:120.68437322950616 andYValue:237.12876169126298]];
    [ring addPoint:[SFPoint pointWithXValue:121.12200129996195 andYValue:236.1068378045508]];
    [ring addPoint:[SFPoint pointWithXValue:121.74064659481407 andYValue:235.18319027576013]];
    [ring addPoint:[SFPoint pointWithXValue:122.51907159233552 andYValue:234.38952707167576]];
    polygon = [SFPolygon polygonWithRing:ring];

    [self complex:polygon];

    ring = [SFLineString lineString];
    [ring addPoint:[SFPoint pointWithXValue:119.65450502825215 andYValue:234.97190110269844]];
    [ring addPoint:[SFPoint pointWithXValue:120.94208471603682 andYValue:241.47274889005215]];
    // [ring addPoint:[SFPoint pointWithXValue:120.57389187028015 andYValue:240.42380619065557]];
    [ring addPoint:[SFPoint pointWithXValue:120.40553233952696 andYValue:239.3249423106921]];
    [ring addPoint:[SFPoint pointWithXValue:120.44278575100797 andYValue:238.2138802324909]];
    [ring addPoint:[SFPoint pointWithXValue:120.68437322950616 andYValue:237.12876169126298]];
    [ring addPoint:[SFPoint pointWithXValue:121.12200129996195 andYValue:236.1068378045508]];
    [ring addPoint:[SFPoint pointWithXValue:121.74064659481407 andYValue:235.18319027576013]];
    [ring addPoint:[SFPoint pointWithXValue:122.51907159233552 andYValue:234.38952707167576]];
    polygon = [SFPolygon polygonWithRing:ring];

    [self complex:polygon];

}

- (void) testPolygons3 {

    SFLineString *ring = [SFLineString lineString];
    [ring addPoint:[SFPoint pointWithXValue:2.48 andYValue:1.38]];
    [ring addPoint:[SFPoint pointWithXValue:2.642 andYValue:4.22]];
    [ring addPoint:[SFPoint pointWithXValue:4.41 andYValue:2.91]];
    [ring addPoint:[SFPoint pointWithXValue:4.69 andYValue:4.42]];
    [ring addPoint:[SFPoint pointWithXValue:2.68 andYValue:4.90]];
    SFPolygon *polygon = [SFPolygon polygonWithRing:ring];

    [self simple:polygon];

    ring = [SFLineString lineString];
    [ring addPoint:[SFPoint pointWithXValue:2.48 andYValue:1.38]];
    [ring addPoint:[SFPoint pointWithXValue:2.641 andYValue:4.22]];
    [ring addPoint:[SFPoint pointWithXValue:4.41 andYValue:2.91]];
    [ring addPoint:[SFPoint pointWithXValue:4.69 andYValue:4.42]];
    [ring addPoint:[SFPoint pointWithXValue:2.68 andYValue:4.90]];
    polygon = [SFPolygon polygonWithRing:ring];

    [self complex:polygon];

    ring = [SFLineString lineString];
    [ring addPoint:[SFPoint pointWithXValue:2.48 andYValue:1.38]];
    [ring addPoint:[SFPoint pointWithXValue:2.642 andYValue:4.22]];
    [ring addPoint:[SFPoint pointWithXValue:3.60 andYValue:4.68]];
    [ring addPoint:[SFPoint pointWithXValue:4.69 andYValue:4.42]];
    [ring addPoint:[SFPoint pointWithXValue:2.68 andYValue:4.90]];
    polygon = [SFPolygon polygonWithRing:ring];

    [self simple:polygon];

    ring = [SFLineString lineString];
    [ring addPoint:[SFPoint pointWithXValue:2.48 andYValue:1.38]];
    [ring addPoint:[SFPoint pointWithXValue:2.642 andYValue:4.22]];
    [ring addPoint:[SFPoint pointWithXValue:3.60 andYValue:4.681]];
    [ring addPoint:[SFPoint pointWithXValue:4.69 andYValue:4.42]];
    [ring addPoint:[SFPoint pointWithXValue:2.68 andYValue:4.90]];
    polygon = [SFPolygon polygonWithRing:ring];

    [self complex:polygon];

    ring = [SFLineString lineString];
    [ring addPoint:[SFPoint pointWithXValue:2.48 andYValue:1.38]];
    [ring addPoint:[SFPoint pointWithXValue:6.34 andYValue:2.15]];
    [ring addPoint:[SFPoint pointWithXValue:5.85 andYValue:3.34]];
    [ring addPoint:[SFPoint pointWithXValue:5.98 andYValue:3.07]];
    [ring addPoint:[SFPoint pointWithXValue:5.09 andYValue:4.98]];
    polygon = [SFPolygon polygonWithRing:ring];

    [self simple:polygon];

    ring = [SFLineString lineString];
    [ring addPoint:[SFPoint pointWithXValue:2.48 andYValue:1.38]];
    [ring addPoint:[SFPoint pointWithXValue:6.34 andYValue:2.15]];
    [ring addPoint:[SFPoint pointWithXValue:5.855 andYValue:3.34]];
    [ring addPoint:[SFPoint pointWithXValue:5.98 andYValue:3.07]];
    [ring addPoint:[SFPoint pointWithXValue:5.09 andYValue:4.98]];
    polygon = [SFPolygon polygonWithRing:ring];

    [self complex:polygon];

}

- (void) testPolygons4 {
    
    SFLineString *ring = [SFLineString lineString];
    [ring addPoint:[SFPoint pointWithXValue:4.96 andYValue:4.18]];
    [ring addPoint:[SFPoint pointWithXValue:2.68 andYValue:4.90]];
    [ring addPoint:[SFPoint pointWithXValue:3.50 andYValue:2.64]];
    [ring addPoint:[SFPoint pointWithXValue:5.20 andYValue:1.86]];
    [ring addPoint:[SFPoint pointWithXValue:8.00 andYValue:2.83]];
    [ring addPoint:[SFPoint pointWithXValue:3.50 andYValue:2.64]];
    SFPolygon *polygon = [SFPolygon polygonWithRing:ring];
    
    [self complex:polygon];
    
    ring = [SFLineString lineString];
    [ring addPoint:[SFPoint pointWithXValue:4.96 andYValue:4.18]];
    [ring addPoint:[SFPoint pointWithXValue:2.68 andYValue:4.90]];
    [ring addPoint:[SFPoint pointWithXValue:3.50 andYValue:2.64]];
    [ring addPoint:[SFPoint pointWithXValue:5.20 andYValue:1.86]];
    [ring addPoint:[SFPoint pointWithXValue:8.00 andYValue:2.83]];
    [ring addPoint:[SFPoint pointWithXValue:3.500000000000001 andYValue:2.64]];
    polygon = [SFPolygon polygonWithRing:ring];
    
    [self simple:polygon];
    
}

-(void) simple: (SFPolygon *) polygon{
    [self validate:polygon asSimple:YES];
}

-(void) complex: (SFPolygon *) polygon{
    [self validate:polygon asSimple:NO];
}

-(void) validate: (SFPolygon *) polygon asSimple: (BOOL) simple{
    
    [SFTestUtils assertEqualBoolWithValue:simple andValue2:[polygon isSimple]];
    
    SFPolygon *copy = [SFPolygon polygonWithPolygon:polygon];
    NSMutableArray<SFPoint *> *points = [copy ringAtIndex:0].points;
    
    SFPoint *first = [points objectAtIndex:0];
    SFPoint *last = [points objectAtIndex:points.count - 1];
    if([first isEqualXYToPoint:last]){
        [points removeObjectAtIndex:points.count - 1];
    }
    
    for(int i = 1; i < points.count; i++){
        
        SFPoint *point = [points firstObject];
        [points removeObjectAtIndex:0];
        [points addObject:point];
        
        [SFTestUtils assertEqualBoolWithValue:simple andValue2:[copy isSimple]];
    }
    
}

-(void) addPoint: (NSMutableArray<SFPoint *> *) points withX: (double) x andY: (double) y{
    [points addObject:[SFPoint pointWithXValue:x andYValue:y]];
}

@end
