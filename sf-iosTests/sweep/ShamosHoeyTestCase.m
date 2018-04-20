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

    NSMutableArray<SFPoint *> *points = [[NSMutableArray alloc] init];
    
    [self addPoint:points withX:0 andY:0];
    [self addPoint:points withX:1 andY:0];
    [self addPoint:points withX:.5 andY:1];
    
    [SFTestUtils assertTrue:[SFShamosHoey simplePolygonPoints:points]];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:(int)points.count];
    
    [self addPoint:points withX:0 andY:0];
    
    [SFTestUtils assertTrue:[SFShamosHoey simplePolygonPoints:points]];
    [SFTestUtils assertEqualIntWithValue:4 andValue2:(int)points.count];
    
    [points removeAllObjects];
    
    [self addPoint:points withX:0 andY:100];
    [self addPoint:points withX:100 andY:0];
    [self addPoint:points withX:200 andY:100];
    [self addPoint:points withX:100 andY:200];
    [self addPoint:points withX:0 andY:100];
    
    [SFTestUtils assertTrue:[SFShamosHoey simplePolygonPoints:points]];
    [SFTestUtils assertEqualIntWithValue:5 andValue2:(int)points.count];
    
    [points removeAllObjects];
    
    [self addPoint:points withX:-104.8384094 andY:39.753657];
    [self addPoint:points withX:-104.8377228 andY:39.7354422];
    [self addPoint:points withX:-104.7930908 andY:39.7364983];
    [self addPoint:points withX:-104.8233891 andY:39.7440222];
    [self addPoint:points withX:-104.7930908 andY:39.7369603];
    [self addPoint:points withX:-104.808197 andY:39.7541849];
    [self addPoint:points withX:-104.8383236 andY:39.753723];
    
    [SFTestUtils assertTrue:[SFShamosHoey simplePolygonPoints:points]];
    [SFTestUtils assertEqualIntWithValue:7 andValue2:(int)points.count];

    [points removeAllObjects];
    
    [self addPoint:points withX:-106.3256836 andY:40.2962865];
    [self addPoint:points withX:-105.6445313 andY:38.5911138];
    [self addPoint:points withX:-105.0842285 andY:40.3046654];
    [self addPoint:points withX:-105.6445313 andY:38.5911139];
    
    [SFTestUtils assertTrue:[SFShamosHoey simplePolygonPoints:points]];
    [SFTestUtils assertEqualIntWithValue:4 andValue2:(int)points.count];
}

- (void)testNonSimple {
    
    NSMutableArray<SFPoint *> *points = [[NSMutableArray alloc] init];
    
    [self addPoint:points withX:0 andY:0];
    
    [SFTestUtils assertFalse:[SFShamosHoey simplePolygonPoints:points]];
    [SFTestUtils assertEqualIntWithValue:1 andValue2:(int)points.count];
    
    [self addPoint:points withX:1 andY:0];
    
    [SFTestUtils assertFalse:[SFShamosHoey simplePolygonPoints:points]];
    [SFTestUtils assertEqualIntWithValue:2 andValue2:(int)points.count];
    
    [self addPoint:points withX:0 andY:0];
    
    [SFTestUtils assertFalse:[SFShamosHoey simplePolygonPoints:points]];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:(int)points.count];
    
    [points removeAllObjects];
    
    [self addPoint:points withX:0 andY:100];
    [self addPoint:points withX:100 andY:0];
    [self addPoint:points withX:200 andY:100];
    [self addPoint:points withX:100 andY:200];
    [self addPoint:points withX:100.01 andY:200];
    [self addPoint:points withX:0 andY:100];
    
    [SFTestUtils assertFalse:[SFShamosHoey simplePolygonPoints:points]];
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
    [SFTestUtils assertEqualIntWithValue:8 andValue2:(int)points.count];
    
    [points removeAllObjects];
    
    [self addPoint:points withX:-106.3256836 andY:40.2962865];
    [self addPoint:points withX:-105.6445313 andY:38.5911138];
    [self addPoint:points withX:-105.0842285 andY:40.3046654];
    [self addPoint:points withX:-105.6445313 andY:38.5911138];

    [SFTestUtils assertFalse:[SFShamosHoey simplePolygonPoints:points]];
    [SFTestUtils assertEqualIntWithValue:4 andValue2:(int)points.count];
    
}

- (void)testSimpleHole {
    
    SFPolygon *polygon = [[SFPolygon alloc] init];
    
    NSMutableArray<SFPoint *> *points = [[NSMutableArray alloc] init];
    
    [self addPoint:points withX:0 andY:0];
    [self addPoint:points withX:10 andY:0];
    [self addPoint:points withX:5 andY:10];
    
    SFLineString *ring = [[SFLineString alloc] init];
    ring.points = points;
    
    [polygon addRing:ring];
    
    [SFTestUtils assertTrue:[SFShamosHoey simplePolygon:polygon]];
    [SFTestUtils assertEqualIntWithValue:1 andValue2:[polygon numRings]];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:[((SFLineString *)[polygon.rings objectAtIndex:0]) numPoints]];
    
    NSMutableArray<SFPoint *> *holePoints = [[NSMutableArray alloc] init];
    
    [self addPoint:holePoints withX:1 andY:1];
    [self addPoint:holePoints withX:9 andY:1];
    [self addPoint:holePoints withX:5 andY:9];
    
    SFLineString *hole = [[SFLineString alloc] init];
    hole.points = holePoints;
    
    [polygon addRing:hole];
    
    [SFTestUtils assertTrue:[SFShamosHoey simplePolygon:polygon]];
    [SFTestUtils assertEqualIntWithValue:2 andValue2:[polygon numRings]];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:[((SFLineString *)[polygon.rings objectAtIndex:0]) numPoints]];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:[((SFLineString *)[polygon.rings objectAtIndex:1]) numPoints]];

}

- (void)testNonSimpleHole {
    
    SFPolygon *polygon = [[SFPolygon alloc] init];
    
    NSMutableArray<SFPoint *> *points = [[NSMutableArray alloc] init];
    
    [self addPoint:points withX:0 andY:0];
    [self addPoint:points withX:10 andY:0];
    [self addPoint:points withX:5 andY:10];
    
    SFLineString *ring = [[SFLineString alloc] init];
    ring.points = points;
    
    [polygon addRing:ring];
    
    [SFTestUtils assertTrue:[SFShamosHoey simplePolygon:polygon]];
    [SFTestUtils assertEqualIntWithValue:1 andValue2:[polygon numRings]];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:[((SFLineString *)[polygon.rings objectAtIndex:0]) numPoints]];
    
    NSMutableArray<SFPoint *> *holePoints = [[NSMutableArray alloc] init];
    
    [self addPoint:holePoints withX:1 andY:1];
    [self addPoint:holePoints withX:9 andY:1];
    [self addPoint:holePoints withX:5 andY:9];
    [self addPoint:holePoints withX:5.000001 andY:9];
    
    SFLineString *hole = [[SFLineString alloc] init];
    hole.points = holePoints;
    
    [polygon addRing:hole];
    
    [SFTestUtils assertFalse:[SFShamosHoey simplePolygon:polygon]];
    [SFTestUtils assertEqualIntWithValue:2 andValue2:[polygon numRings]];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:[((SFLineString *)[polygon.rings objectAtIndex:0]) numPoints]];
    [SFTestUtils assertEqualIntWithValue:4 andValue2:[((SFLineString *)[polygon.rings objectAtIndex:1]) numPoints]];
    
}

- (void)testIntersectingHole {
    
    SFPolygon *polygon = [[SFPolygon alloc] init];
    
    NSMutableArray<SFPoint *> *points = [[NSMutableArray alloc] init];
    
    [self addPoint:points withX:0 andY:0];
    [self addPoint:points withX:10 andY:0];
    [self addPoint:points withX:5 andY:10];
    
    SFLineString *ring = [[SFLineString alloc] init];
    ring.points = points;
    
    [polygon addRing:ring];
    
    [SFTestUtils assertTrue:[SFShamosHoey simplePolygon:polygon]];
    [SFTestUtils assertEqualIntWithValue:1 andValue2:[polygon numRings]];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:[((SFLineString *)[polygon.rings objectAtIndex:0]) numPoints]];
    
    NSMutableArray<SFPoint *> *holePoints = [[NSMutableArray alloc] init];
    
    [self addPoint:holePoints withX:1 andY:1];
    [self addPoint:holePoints withX:9 andY:1];
    [self addPoint:holePoints withX:5 andY:10];
    
    SFLineString *hole = [[SFLineString alloc] init];
    hole.points = holePoints;
    
    [polygon addRing:hole];
    
    [SFTestUtils assertFalse:[SFShamosHoey simplePolygon:polygon]];
    [SFTestUtils assertEqualIntWithValue:2 andValue2:[polygon numRings]];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:[((SFLineString *)[polygon.rings objectAtIndex:0]) numPoints]];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:[((SFLineString *)[polygon.rings objectAtIndex:1]) numPoints]];

}

- (void)testIntersectingHoles {
    
    SFPolygon *polygon = [[SFPolygon alloc] init];
    
    NSMutableArray<SFPoint *> *points = [[NSMutableArray alloc] init];
    
    [self addPoint:points withX:0 andY:0];
    [self addPoint:points withX:10 andY:0];
    [self addPoint:points withX:5 andY:10];
    
    SFLineString *ring = [[SFLineString alloc] init];
    ring.points = points;
    
    [polygon addRing:ring];
    
    [SFTestUtils assertTrue:[SFShamosHoey simplePolygon:polygon]];
    [SFTestUtils assertEqualIntWithValue:1 andValue2:[polygon numRings]];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:[((SFLineString *)[polygon.rings objectAtIndex:0]) numPoints]];
    
    NSMutableArray<SFPoint *> *holePoints1 = [[NSMutableArray alloc] init];
    
    [self addPoint:holePoints1 withX:1 andY:1];
    [self addPoint:holePoints1 withX:9 andY:1];
    [self addPoint:holePoints1 withX:5 andY:9];
    
    SFLineString *hole1 = [[SFLineString alloc] init];
    hole1.points = holePoints1;
    
    [polygon addRing:hole1];
    
    [SFTestUtils assertTrue:[SFShamosHoey simplePolygon:polygon]];
    [SFTestUtils assertEqualIntWithValue:2 andValue2:[polygon numRings]];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:[((SFLineString *)[polygon.rings objectAtIndex:0]) numPoints]];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:[((SFLineString *)[polygon.rings objectAtIndex:1]) numPoints]];
    
    NSMutableArray<SFPoint *> *holePoints2 = [[NSMutableArray alloc] init];
    
    [self addPoint:holePoints2 withX:5.0 andY:0.1];
    [self addPoint:holePoints2 withX:6.0 andY:0.1];
    [self addPoint:holePoints2 withX:5.5 andY:1.00001];
    
    SFLineString *hole2 = [[SFLineString alloc] init];
    hole2.points = holePoints2;
    
    [polygon addRing:hole2];
    
    [SFTestUtils assertFalse:[SFShamosHoey simplePolygon:polygon]];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:[polygon numRings]];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:[((SFLineString *)[polygon.rings objectAtIndex:0]) numPoints]];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:[((SFLineString *)[polygon.rings objectAtIndex:1]) numPoints]];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:[((SFLineString *)[polygon.rings objectAtIndex:2]) numPoints]];

}

- (void)testHoleInsideHole {
    
    SFPolygon *polygon = [[SFPolygon alloc] init];
    
    NSMutableArray<SFPoint *> *points = [[NSMutableArray alloc] init];
    
    [self addPoint:points withX:0 andY:0];
    [self addPoint:points withX:10 andY:0];
    [self addPoint:points withX:5 andY:10];
    
    SFLineString *ring = [[SFLineString alloc] init];
    ring.points = points;
    
    [polygon addRing:ring];
    
    [SFTestUtils assertTrue:[SFShamosHoey simplePolygon:polygon]];
    [SFTestUtils assertEqualIntWithValue:1 andValue2:[polygon numRings]];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:[((SFLineString *)[polygon.rings objectAtIndex:0]) numPoints]];
    
    NSMutableArray<SFPoint *> *holePoints1 = [[NSMutableArray alloc] init];
    
    [self addPoint:holePoints1 withX:1 andY:1];
    [self addPoint:holePoints1 withX:9 andY:1];
    [self addPoint:holePoints1 withX:5 andY:9];
    
    SFLineString *hole1 = [[SFLineString alloc] init];
    hole1.points = holePoints1;
    
    [polygon addRing:hole1];
    
    [SFTestUtils assertTrue:[SFShamosHoey simplePolygon:polygon]];
    [SFTestUtils assertEqualIntWithValue:2 andValue2:[polygon numRings]];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:[((SFLineString *)[polygon.rings objectAtIndex:0]) numPoints] ];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:[((SFLineString *)[polygon.rings objectAtIndex:1]) numPoints]];

    NSMutableArray<SFPoint *> *holePoints2 = [[NSMutableArray alloc] init];
    
    [self addPoint:holePoints2 withX:2 andY:2];
    [self addPoint:holePoints2 withX:8 andY:2];
    [self addPoint:holePoints2 withX:5 andY:8];
    
    SFLineString *hole2 = [[SFLineString alloc] init];
    hole2.points = holePoints2;
    
    [polygon addRing:hole2];
    
    [SFTestUtils assertFalse:[SFShamosHoey simplePolygon:polygon]];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:[polygon numRings]];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:[((SFLineString *)[polygon.rings objectAtIndex:0]) numPoints]];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:[((SFLineString *)[polygon.rings objectAtIndex:1]) numPoints]];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:[((SFLineString *)[polygon.rings objectAtIndex:2]) numPoints]];

}

- (void)testExternalHole {
    
    SFPolygon *polygon = [[SFPolygon alloc] init];
    
    NSMutableArray<SFPoint *> *points = [[NSMutableArray alloc] init];
    
    [self addPoint:points withX:0 andY:0];
    [self addPoint:points withX:10 andY:0];
    [self addPoint:points withX:5 andY:10];
    
    SFLineString *ring = [[SFLineString alloc] init];
    ring.points = points;
    
    [polygon addRing:ring];
    
    [SFTestUtils assertTrue:[SFShamosHoey simplePolygon:polygon]];
    [SFTestUtils assertEqualIntWithValue:1 andValue2:[polygon numRings]];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:[((SFLineString *)[polygon.rings objectAtIndex:0]) numPoints]];
    
    NSMutableArray<SFPoint *> *holePoints = [[NSMutableArray alloc] init];
    
    [self addPoint:holePoints withX:-1 andY:1];
    [self addPoint:holePoints withX:-1 andY:3];
    [self addPoint:holePoints withX:-2 andY:1];
    
    SFLineString *hole = [[SFLineString alloc] init];
    hole.points = holePoints;
    
    [polygon addRing:hole];
    
    [SFTestUtils assertFalse:[SFShamosHoey simplePolygon:polygon]];
    [SFTestUtils assertEqualIntWithValue:2 andValue2:[polygon numRings]];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:[((SFLineString *)[polygon.rings objectAtIndex:0]) numPoints]];
    [SFTestUtils assertEqualIntWithValue:3 andValue2:[((SFLineString *)[polygon.rings objectAtIndex:1]) numPoints]];
    
}

- (void)testLargeSimple {
    
    double increment = .01;
    double radius = 1250;
    double x = -radius + increment;
    double y = 0;
    
    NSMutableArray<SFPoint *> *points = [[NSMutableArray alloc] init];
    
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
    [SFTestUtils assertEqualIntWithValue:(int) (radius / increment * 4) andValue2:(int)points.count];
    
}

- (void)testLargeNonSimple {
    
    double increment = .01;
    double radius = 1250;
    double x = -radius + increment;
    double y = 0;
    
    NSMutableArray<SFPoint *> *points = [[NSMutableArray alloc] init];
    
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
    [SFTestUtils assertEqualIntWithValue:1 + (int) (radius / increment * 4) andValue2:(int)points.count];

    [points removeObjectAtIndex:invalidIndex];
    previousPoint = [points objectAtIndex:points.count - 3];
    [self addPoint:points withX:[previousPoint.x doubleValue] andY:[previousPoint.y doubleValue] + .000000000000001];
    
    [SFTestUtils assertFalse:[SFShamosHoey simplePolygonPoints:points]];
    [SFTestUtils assertEqualIntWithValue:1 + (int) (radius / increment * 4) andValue2:(int)points.count];

}

-(void) addPoint: (NSMutableArray<SFPoint *> *) points withX: (double) x andY: (double) y{
    [points addObject:[[SFPoint alloc] initWithXValue:x andYValue:y]];
}

@end
