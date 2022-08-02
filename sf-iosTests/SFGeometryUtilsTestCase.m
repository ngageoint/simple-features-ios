//
//  SFGeometryUtilsTestCase.m
//  sf-ios
//
//  Created by Brian Osborn on 4/17/17.
//  Copyright © 2017 NGA. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SFTestUtils.h"
#import "SFGeometryTestUtils.h"
#import "SFGeometryUtils.h"
#import "SFGeometryEnvelopeBuilder.h"
#import "SFGeometryConstants.h"

@interface SFGeometryUtilsTestCase : XCTestCase

@end

@implementation SFGeometryUtilsTestCase

static NSUInteger GEOMETRIES_PER_TEST = 10;

-(void) setUp {
    [super setUp];
}

-(void) tearDown {
    [super tearDown];
}

-(void) testPointCentroid {
    
    for (int i = 0; i < GEOMETRIES_PER_TEST; i++) {
        // Create and test a point
        SFPoint *point = [SFGeometryTestUtils createPointWithHasZ:[SFTestUtils coinFlip] andHasM:[SFTestUtils coinFlip]];
        [SFTestUtils assertEqualIntWithValue:0 andValue2:[SFGeometryUtils dimensionOfGeometry:point]];
        [self geometryCentroidTesterWithGeometry:point];
    }
    
}

-(void) testLineStringCentroid {
    
    for (int i = 0; i < GEOMETRIES_PER_TEST; i++) {
        // Create and test a line string
        SFLineString *lineString = [SFGeometryTestUtils createLineStringWithHasZ:[SFTestUtils coinFlip] andHasM:[SFTestUtils coinFlip]];
        [SFTestUtils assertEqualIntWithValue:1 andValue2:[SFGeometryUtils dimensionOfGeometry:lineString]];
        [self geometryCentroidTesterWithGeometry:lineString];
    }
    
}

-(void) testPolygonCentroid {
    
    for (int i = 0; i < GEOMETRIES_PER_TEST; i++) {
        // Create and test a polygon
        SFPolygon *polygon = [self createPolygon];
        [SFTestUtils assertEqualIntWithValue:2 andValue2:[SFGeometryUtils dimensionOfGeometry:polygon]];
        [self geometryCentroidTesterWithGeometry:polygon];
    }
    
}

-(void) testMultiPointCentroid {
    
    for (int i = 0; i < GEOMETRIES_PER_TEST; i++) {
        // Create and test a multi point
        SFMultiPoint *multiPoint = [SFGeometryTestUtils createMultiPointWithHasZ:[SFTestUtils coinFlip] andHasM:[SFTestUtils coinFlip]];
        [SFTestUtils assertEqualIntWithValue:0 andValue2:[SFGeometryUtils dimensionOfGeometry:multiPoint]];
        [self geometryCentroidTesterWithGeometry:multiPoint];
    }
    
}

-(void) testMultiLineStringCentroid {
    
    for (int i = 0; i < GEOMETRIES_PER_TEST; i++) {
        // Create and test a multi line string
        SFMultiLineString *multiLineString = [SFGeometryTestUtils createMultiLineStringWithHasZ:[SFTestUtils coinFlip] andHasM:[SFTestUtils coinFlip]];
        [SFTestUtils assertEqualIntWithValue:1 andValue2:[SFGeometryUtils dimensionOfGeometry:multiLineString]];
        [self geometryCentroidTesterWithGeometry:multiLineString];
    }
    
}

-(void) testMultiPolygonCentroid {
    
    for (int i = 0; i < GEOMETRIES_PER_TEST; i++) {
        // Create and test a multi polygon
        SFMultiPolygon *multiPolygon = [self createMultiPolygon];
        [SFTestUtils assertEqualIntWithValue:2 andValue2:[SFGeometryUtils dimensionOfGeometry:multiPolygon]];
        [self geometryCentroidTesterWithGeometry:multiPolygon];
    }
    
}

-(void) testGeometryCollectionCentroid {
    
    for (int i = 0; i < GEOMETRIES_PER_TEST; i++) {
        // Create and test a geometry collection
        SFGeometryCollection *geometryCollection = [self createGeometryCollectionWithHasZ:[SFTestUtils coinFlip] andHasM:[SFTestUtils coinFlip]];
        [self geometryCentroidTesterWithGeometry:geometryCollection];
    }
    
}

-(void) testPolygonCentroidWithAndWithoutHole {
    
    SFPolygon *polygon = [[SFPolygon alloc] init];
    SFLineString *lineString = [[SFLineString alloc] init];
    [lineString addPoint:[[SFPoint alloc] initWithXValue:-90 andYValue:45]];
    [lineString addPoint:[[SFPoint alloc] initWithXValue:-90 andYValue:-45]];
    [lineString addPoint:[[SFPoint alloc] initWithXValue:90 andYValue:-45]];
    [lineString addPoint:[[SFPoint alloc] initWithXValue:90 andYValue:45]];
    [polygon addRing:lineString];
    
    [SFTestUtils assertEqualIntWithValue:2 andValue2:[SFGeometryUtils dimensionOfGeometry:polygon]];
    SFPoint *centroid = [self geometryCentroidTesterWithGeometry:polygon];
    
    [SFTestUtils assertEqualDoubleWithValue:0.0 andValue2:[centroid.x doubleValue]];
    [SFTestUtils assertEqualDoubleWithValue:0.0 andValue2:[centroid.y doubleValue]];
    
    SFLineString *holeLineString = [[SFLineString alloc] init];
    [holeLineString addPoint:[[SFPoint alloc] initWithXValue:0 andYValue:45]];
    [holeLineString addPoint:[[SFPoint alloc] initWithXValue:0 andYValue:0]];
    [holeLineString addPoint:[[SFPoint alloc] initWithXValue:90 andYValue:0]];
    [holeLineString addPoint:[[SFPoint alloc] initWithXValue:90 andYValue:45]];
    [polygon addRing:holeLineString];
    
    [SFTestUtils assertEqualIntWithValue:2 andValue2:[SFGeometryUtils dimensionOfGeometry:polygon]];
    centroid = [self geometryCentroidTesterWithGeometry:polygon];
    
    [SFTestUtils assertEqualDoubleWithValue:-15.0 andValue2:[centroid.x doubleValue]];
    [SFTestUtils assertEqualDoubleWithValue:-7.5 andValue2:[centroid.y doubleValue]];
}

-(SFPoint *) geometryCentroidTesterWithGeometry: (SFGeometry *) geometry{
    
    SFPoint *point = [geometry centroid];
    
    SFGeometryEnvelope *envelope = [geometry envelope];
    
    if(geometry.geometryType == SF_POINT){
        [SFTestUtils assertEqualDoubleWithValue:[envelope.minX doubleValue] andValue2:[point.x doubleValue]];
        [SFTestUtils assertEqualDoubleWithValue:[envelope.maxX doubleValue] andValue2:[point.x doubleValue]];
        [SFTestUtils assertEqualDoubleWithValue:[envelope.minY doubleValue] andValue2:[point.y doubleValue]];
        [SFTestUtils assertEqualDoubleWithValue:[envelope.maxY doubleValue] andValue2:[point.y doubleValue]];
    }
    
    [SFTestUtils assertTrue:[point.x doubleValue] >= [envelope.minX doubleValue]];
    [SFTestUtils assertTrue:[point.x doubleValue] <= [envelope.maxX doubleValue]];
    [SFTestUtils assertTrue:[point.y doubleValue] >= [envelope.minY doubleValue]];
    [SFTestUtils assertTrue:[point.y doubleValue] <= [envelope.maxY doubleValue]];
    
    SFPoint *envelopeCentroid1 = [[envelope buildGeometry] centroid];
    SFPoint *envelopeCentroid2 = [envelope centroid];
    [SFTestUtils assertEqualDoubleWithValue:[envelopeCentroid1.x doubleValue] andValue2:[envelopeCentroid2.x doubleValue] andDelta:0.0000000000001];
    [SFTestUtils assertEqualDoubleWithValue:[envelopeCentroid1.y doubleValue] andValue2:[envelopeCentroid2.y doubleValue] andDelta:0.0000000000001];
    
    return point;
}

-(SFPolygon *) createPolygon{
    
    SFPolygon *polygon = [[SFPolygon alloc] init];
    SFLineString *lineString = [[SFLineString alloc] init];
    [lineString addPoint:[self createPointWithMinX:-180.0 andMinY:45.0 andXRange:90.0 andYRange:45.0]];
    [lineString addPoint:[self createPointWithMinX:-180.0 andMinY:-90.0 andXRange:90.0 andYRange:45.0]];
    [lineString addPoint:[self createPointWithMinX:90.0 andMinY:-90.0 andXRange:90.0 andYRange:45.0]];
    [lineString addPoint:[self createPointWithMinX:90.0 andMinY:45.0 andXRange:90.0 andYRange:45.0]];
    [polygon addRing:lineString];
    
    SFLineString *holeLineString = [[SFLineString alloc] init];
    [holeLineString addPoint:[self createPointWithMinX:-90.0 andMinY:0.0 andXRange:90.0 andYRange:45.0]];
    [holeLineString addPoint:[self createPointWithMinX:-90.0 andMinY:-45.0 andXRange:90.0 andYRange:45.0]];
    [holeLineString addPoint:[self createPointWithMinX:0.0 andMinY:-45.0 andXRange:90.0 andYRange:45.0]];
    [holeLineString addPoint:[self createPointWithMinX:0.0 andMinY:0.0 andXRange:90.0 andYRange:45.0]];
    [polygon addRing:holeLineString];
    
    return polygon;
}

-(SFPoint *) createPointWithMinX: (double) minX andMinY: (double) minY andXRange: (double) xRange andYRange: (double) yRange{
    
    double x = minX + ([SFTestUtils randomDouble] * xRange);
    double y = minY + ([SFTestUtils randomDouble] * yRange);
    
    SFPoint *point = [[SFPoint alloc] initWithXValue:x andYValue:y];
    
    return point;
}

-(SFMultiPolygon *) createMultiPolygon{
    
    SFMultiPolygon *multiPolygon = [[SFMultiPolygon alloc] init];
    
    int num = 1 + ((int) ([SFTestUtils randomDouble] * 5));
    
    for (int i = 0; i < num; i++) {
        [multiPolygon addPolygon:[self createPolygon]];
    }
    
    return multiPolygon;
}

-(SFGeometryCollection *) createGeometryCollectionWithHasZ: (BOOL) hasZ andHasM: (BOOL) hasM{

    SFGeometryCollection *geometryCollection = [[SFGeometryCollection alloc] initWithHasZ:hasZ andHasM:hasM];
    
    int num = 1 + ((int) ([SFTestUtils randomDouble] * 5));
    
    for (int i = 0; i < num; i++) {
        
        SFGeometry *geometry = nil;
        int randomGeometry = (int) ([SFTestUtils randomDouble] * 6);
        
        switch (randomGeometry) {
            case 0:
                geometry = [SFGeometryTestUtils createPointWithHasZ:hasZ andHasM:hasM];
                break;
            case 1:
                geometry = [SFGeometryTestUtils createLineStringWithHasZ:hasZ andHasM:hasM];
                break;
            case 2:
                geometry = [self createPolygon];
                break;
            case 3:
                geometry = [SFGeometryTestUtils createMultiPointWithHasZ:hasZ andHasM:hasM];
                break;
            case 4:
                geometry = [SFGeometryTestUtils createMultiLineStringWithHasZ:hasZ andHasM:hasM];
                break;
            case 5:
                geometry = [self createMultiPolygon];
                break;
        }
        
        [geometryCollection addGeometry:geometry];
    }
    
    return geometryCollection;
}

-(void) testCopyMinimizeAndNormalize{
    
    SFPolygon *polygon = [[SFPolygon alloc] init];
    SFLineString *ring = [[SFLineString alloc] init];
    double random = [SFTestUtils randomDouble];
    if(random < .5){
        [ring addPoint:[self createPointWithMinX:90.0 andMinY:0.0 andXRange:90.0 andYRange:90.0]];
        [ring addPoint:[self createPointWithMinX:90.0 andMinY:-90.0 andXRange:90.0 andYRange:90.0]];
        [ring addPoint:[self createPointWithMinX:-180.0 andMinY:-90.0 andXRange:89.0 andYRange:90.0]];
        [ring addPoint:[self createPointWithMinX:-180.0 andMinY:0.0 andXRange:89.0 andYRange:90.0]];
    }else{
        [ring addPoint:[self createPointWithMinX:-180.0 andMinY:0.0 andXRange:89.0 andYRange:90.0]];
        [ring addPoint:[self createPointWithMinX:-180.0 andMinY:-90.0 andXRange:89.0 andYRange:90.0]];
        [ring addPoint:[self createPointWithMinX:90.0 andMinY:-90.0 andXRange:90.0 andYRange:90.0]];
        [ring addPoint:[self createPointWithMinX:90.0 andMinY:0.0 andXRange:90.0 andYRange:90.0]];
    }
    [polygon addRing:ring];
    
    SFPolygon *polygon2 = [polygon mutableCopy];
    [SFGeometryUtils minimizeWGS84Geometry:polygon2];
    
    SFPolygon *polygon3 = [polygon2 mutableCopy];
    [SFGeometryUtils normalizeWGS84Geometry:polygon3];
    
    NSArray *points = ring.points;
    SFLineString *ring2 = [polygon2 ringAtIndex:0];
    NSArray *points2 = ring2.points;
    SFLineString *ring3 = [polygon3 ringAtIndex:0];
    NSArray *points3 = ring3.points;
    
    for(int i = 0; i < points.count; i++){
        
        SFPoint *point = [points objectAtIndex:i];
        SFPoint *point2 = [points2 objectAtIndex:i];
        SFPoint *point3 = [points3 objectAtIndex:i];
        
        [SFTestUtils assertEqualDoubleWithValue:[point.y doubleValue] andValue2:[point2.y doubleValue]];
        [SFTestUtils assertEqualDoubleWithValue:[point.y doubleValue] andValue2:[point3.y doubleValue]];
        [SFTestUtils assertEqualDoubleWithValue:[point.x doubleValue] andValue2:[point3.x doubleValue] andDelta:.0000000001];
        if(i < 2){
            [SFTestUtils assertEqualDoubleWithValue:[point.x doubleValue] andValue2:[point2.x doubleValue]];
        }else{
            double point2Value = [point2.x doubleValue];
            if(random < .5){
                point2Value -= 360.0;
            }else{
                point2Value += 360.0;
            }
            [SFTestUtils assertEqualDoubleWithValue:[point.x doubleValue] andValue2:point2Value andDelta:.0000000001];
        }
    }
    
}

-(void) testSimplifyPoints{
    
    double halfWorldWidth = SF_WEB_MERCATOR_HALF_WORLD_WIDTH;
    
    NSMutableArray<SFPoint *> *points = [NSMutableArray array];
    NSMutableArray<NSDecimalNumber *> *distances = [NSMutableArray array];
    
    double x = ([SFTestUtils randomDouble] * halfWorldWidth * 2) - halfWorldWidth;
    double y = ([SFTestUtils randomDouble] * halfWorldWidth * 2) - halfWorldWidth;
    SFPoint *point = [[SFPoint alloc] initWithXValue:x andYValue:y];
    [points addObject:point];
    
    for (int i = 1; i < 100; i++) {
        
        double xChange = 100000.0 * [SFTestUtils randomDouble] * ([SFTestUtils randomDouble] < .5 ? 1 : -1);
        x += xChange;
        
        double yChange = 100000.0 * [SFTestUtils randomDouble] * ([SFTestUtils randomDouble] < .5 ? 1 : -1);
        y += yChange;
        if (y > halfWorldWidth || y < -halfWorldWidth) {
            y -= 2 * yChange;
        }
        
        SFPoint *previousPoint = point;
        point = [[SFPoint alloc] initWithXValue:x andYValue:y];
        [points addObject:point];
        
        double distance = [SFGeometryUtils distanceBetweenPoint1:previousPoint andPoint2:point];
        [distances addObject:[[NSDecimalNumber alloc] initWithDouble:distance]];
        
    }
    
    NSArray<NSDecimalNumber *> *sortedDistances = [distances sortedArrayUsingSelector:@selector(compare:)];
    double tolerance = [[sortedDistances objectAtIndex:sortedDistances.count / 2] doubleValue];
    
    NSArray<SFPoint *> *simplifiedPoints = [SFGeometryUtils simplifyPoints:points withTolerance:tolerance];
    [SFTestUtils assertTrue:simplifiedPoints.count <= points.count];
    
    SFPoint *firstPoint = [points objectAtIndex:0];
    SFPoint *lastPoint = [points objectAtIndex:points.count - 1];
    SFPoint *firstSimplifiedPoint = [simplifiedPoints objectAtIndex:0];
    SFPoint *lastSimplifiedPoint = [simplifiedPoints objectAtIndex:simplifiedPoints.count - 1];
    
    [SFTestUtils assertEqualDoubleWithValue:[firstPoint.x doubleValue] andValue2:[firstSimplifiedPoint.x doubleValue]];
    [SFTestUtils assertEqualDoubleWithValue:[firstPoint.y doubleValue] andValue2:[firstSimplifiedPoint.y doubleValue]];
    [SFTestUtils assertEqualDoubleWithValue:[lastPoint.x doubleValue] andValue2:[lastSimplifiedPoint.x doubleValue]];
    [SFTestUtils assertEqualDoubleWithValue:[lastPoint.y doubleValue] andValue2:[lastSimplifiedPoint.y doubleValue]];
    
    int pointIndex = 0;
    for (int i = 1; i < simplifiedPoints.count; i++) {
        SFPoint *simplifiedPoint = [simplifiedPoints objectAtIndex:i];
        double simplifiedDistance = [SFGeometryUtils distanceBetweenPoint1:[simplifiedPoints objectAtIndex:i-1] andPoint2:simplifiedPoint];
        [SFTestUtils assertTrue:simplifiedDistance >= tolerance];
        
        for (pointIndex++; pointIndex < points.count; pointIndex++) {
            SFPoint *newPoint = [points objectAtIndex:pointIndex];
            if ([newPoint.x doubleValue] == [simplifiedPoint.x doubleValue]
                && [newPoint.y doubleValue] == [simplifiedPoint.y doubleValue]) {
                break;
            }
        }
        [SFTestUtils assertTrue:pointIndex < points.count];
    }
    
}

-(void) testPointInPolygon{
    
    NSMutableArray<SFPoint *> *points = [NSMutableArray array];
    [points addObject:[[SFPoint alloc] initWithXValue:0 andYValue:5]];
    [points addObject:[[SFPoint alloc] initWithXValue:5 andYValue:0]];
    [points addObject:[[SFPoint alloc] initWithXValue:10 andYValue:5]];
    [points addObject:[[SFPoint alloc] initWithXValue:5 andYValue:10]];
    
    [SFTestUtils assertFalse:[SFGeometryUtils closedPolygonPoints:points]];
    
    double deviation = 0.000000000000001;
    
    for(SFPoint *point in points){
        [SFTestUtils assertTrue:[SFGeometryUtils point:point inPolygonPoints:points]];
    }
    
    [SFTestUtils assertTrue:[SFGeometryUtils point:[[SFPoint alloc] initWithXValue:0 + deviation andYValue:5] inPolygonPoints:points]];
    [SFTestUtils assertTrue:[SFGeometryUtils point:[[SFPoint alloc] initWithXValue:5 andYValue:0 + deviation] inPolygonPoints:points]];
    [SFTestUtils assertTrue:[SFGeometryUtils point:[[SFPoint alloc] initWithXValue:10 - deviation andYValue:5] inPolygonPoints:points]];
    [SFTestUtils assertTrue:[SFGeometryUtils point:[[SFPoint alloc] initWithXValue:5 andYValue:10 - deviation] inPolygonPoints:points]];
    
    [SFTestUtils assertTrue:[SFGeometryUtils point:[[SFPoint alloc] initWithXValue:5 andYValue:5] inPolygonPoints:points]];
    
    [SFTestUtils assertTrue:[SFGeometryUtils point:[[SFPoint alloc] initWithXValue:2.5 + deviation andYValue:7.5 - deviation] inPolygonPoints:points]];
    [SFTestUtils assertTrue:[SFGeometryUtils point:[[SFPoint alloc] initWithXValue:2.5 + deviation andYValue:2.5 + deviation] inPolygonPoints:points]];
    [SFTestUtils assertTrue:[SFGeometryUtils point:[[SFPoint alloc] initWithXValue:7.5 - deviation andYValue:2.5 + deviation] inPolygonPoints:points]];
    [SFTestUtils assertTrue:[SFGeometryUtils point:[[SFPoint alloc] initWithXValue:7.5 - deviation andYValue:7.5 - deviation] inPolygonPoints:points]];
    
    [SFTestUtils assertTrue:[SFGeometryUtils point:[[SFPoint alloc] initWithXValue:2.5 andYValue:7.5] inPolygonPoints:points]];
    [SFTestUtils assertTrue:[SFGeometryUtils point:[[SFPoint alloc] initWithXValue:2.5 andYValue:2.5] inPolygonPoints:points]];
    [SFTestUtils assertTrue:[SFGeometryUtils point:[[SFPoint alloc] initWithXValue:7.5 andYValue:2.5] inPolygonPoints:points]];
    [SFTestUtils assertTrue:[SFGeometryUtils point:[[SFPoint alloc] initWithXValue:7.5 andYValue:7.5] inPolygonPoints:points]];
    
    deviation = .0000001;
    
    [SFTestUtils assertFalse:[SFGeometryUtils point:[[SFPoint alloc] initWithXValue:0 andYValue:0] inPolygonPoints:points]];
    [SFTestUtils assertFalse:[SFGeometryUtils point:[[SFPoint alloc] initWithXValue:0 - deviation andYValue:5] inPolygonPoints:points]];
    [SFTestUtils assertFalse:[SFGeometryUtils point:[[SFPoint alloc] initWithXValue:5 andYValue:0 - deviation] inPolygonPoints:points]];
    [SFTestUtils assertFalse:[SFGeometryUtils point:[[SFPoint alloc] initWithXValue:10 + deviation andYValue:5] inPolygonPoints:points]];
    [SFTestUtils assertFalse:[SFGeometryUtils point:[[SFPoint alloc] initWithXValue:5 andYValue:10 + deviation] inPolygonPoints:points]];
    
    [SFTestUtils assertFalse:[SFGeometryUtils point:[[SFPoint alloc] initWithXValue:2.5 - deviation andYValue:7.5 + deviation] inPolygonPoints:points]];
    [SFTestUtils assertFalse:[SFGeometryUtils point:[[SFPoint alloc] initWithXValue:2.5 - deviation andYValue:2.5 - deviation] inPolygonPoints:points]];
    [SFTestUtils assertFalse:[SFGeometryUtils point:[[SFPoint alloc] initWithXValue:7.5 + deviation andYValue:2.5 - deviation] inPolygonPoints:points]];
    [SFTestUtils assertFalse:[SFGeometryUtils point:[[SFPoint alloc] initWithXValue:7.5 + deviation andYValue:7.5 + deviation] inPolygonPoints:points]];
    
    SFPoint *firstPoint = [points objectAtIndex:0];
    [points addObject:[[SFPoint alloc] initWithX:firstPoint.x andY:firstPoint.y]];
    
    [SFTestUtils assertTrue:[SFGeometryUtils closedPolygonPoints:points]];
    
    for(SFPoint *point in points){
        [SFTestUtils assertTrue:[SFGeometryUtils point:point inPolygonPoints:points]];
    }
    [SFTestUtils assertTrue:[SFGeometryUtils point:[[SFPoint alloc] initWithXValue:2.5 + deviation andYValue:7.5 - deviation] inPolygonPoints:points]];
    [SFTestUtils assertTrue:[SFGeometryUtils point:[[SFPoint alloc] initWithXValue:2.5 andYValue:7.5] inPolygonPoints:points]];
    [SFTestUtils assertFalse:[SFGeometryUtils point:[[SFPoint alloc] initWithXValue:2.5 - deviation andYValue:7.5 + deviation] inPolygonPoints:points]];
    
}

-(void) testClosePolygon{
    
    NSMutableArray<SFPoint *> *points = [NSMutableArray array];
    [points addObject:[[SFPoint alloc] initWithXValue:0.1 andYValue:0.2]];
    [points addObject:[[SFPoint alloc] initWithXValue:5.3 andYValue:0.4]];
    [points addObject:[[SFPoint alloc] initWithXValue:5.5 andYValue:5.6]];
    
    [SFTestUtils assertFalse:[SFGeometryUtils closedPolygonPoints:points]];
    
    SFPoint *firstPoint = [points objectAtIndex:0];
    [points addObject:[[SFPoint alloc] initWithX:firstPoint.x andY:firstPoint.y]];
    
    [SFTestUtils assertTrue:[SFGeometryUtils closedPolygonPoints:points]];
}

-(void) testPointOnLine{
    
    NSMutableArray<SFPoint *> *points = [NSMutableArray array];
    [points addObject:[[SFPoint alloc] initWithXValue:0 andYValue:0]];
    [points addObject:[[SFPoint alloc] initWithXValue:5 andYValue:0]];
    [points addObject:[[SFPoint alloc] initWithXValue:5 andYValue:5]];
    
    for(SFPoint *point in points){
        [SFTestUtils assertTrue:[SFGeometryUtils point:point onLinePoints:points]];
    }
    [SFTestUtils assertTrue:[SFGeometryUtils point:[[SFPoint alloc] initWithXValue:2.5 andYValue:0] onLinePoints:points]];
    [SFTestUtils assertTrue:[SFGeometryUtils point:[[SFPoint alloc] initWithXValue:5 andYValue:2.5] onLinePoints:points]];
    [SFTestUtils assertTrue:[SFGeometryUtils point:[[SFPoint alloc] initWithXValue:2.5 andYValue:0.00000001] onLinePoints:points]];
    [SFTestUtils assertFalse:[SFGeometryUtils point:[[SFPoint alloc] initWithXValue:2.5 andYValue:0.0000001] onLinePoints:points]];
    [SFTestUtils assertTrue:[SFGeometryUtils point:[[SFPoint alloc] initWithXValue:5 andYValue:2.5000000001] onLinePoints:points]];
    [SFTestUtils assertFalse:[SFGeometryUtils point:[[SFPoint alloc] initWithXValue:5 andYValue:2.500000001] onLinePoints:points]];
    [SFTestUtils assertTrue:[SFGeometryUtils point:[[SFPoint alloc] initWithXValue:-0.0000000000000001 andYValue:0] onLinePoints:points]];
    [SFTestUtils assertFalse:[SFGeometryUtils point:[[SFPoint alloc] initWithXValue:-0.000000000000001 andYValue:0] onLinePoints:points]];
    [SFTestUtils assertTrue:[SFGeometryUtils point:[[SFPoint alloc] initWithXValue:5 andYValue:5.0000000000000001] onLinePoints:points]];
    [SFTestUtils assertFalse:[SFGeometryUtils point:[[SFPoint alloc] initWithXValue:5 andYValue:5.000000000000001] onLinePoints:points]];
    
}

/**
 * Test line intersection
 */
-(void) testIntersection{
    
    SFLine *line1 = [[SFLine alloc] initWithPoint1:[[SFPoint alloc] initWithXValue:-40.0 andYValue:-40.0] andPoint2:[[SFPoint alloc] initWithXValue:40.0 andYValue:40.0]];
    SFLine *line2 = [[SFLine alloc] initWithPoint1:[[SFPoint alloc] initWithXValue:-40.0 andYValue:40.0] andPoint2:[[SFPoint alloc] initWithXValue:40.0 andYValue:-40.0]];
    
    SFPoint *point = [SFGeometryUtils intersectionBetweenLine1:line1 andLine2:line2];
    [SFTestUtils assertEqualDoubleWithValue:0.0 andValue2:[point.x doubleValue]];
    [SFTestUtils assertEqualDoubleWithValue:0.0 andValue2:[point.y doubleValue]];
    
    line1 = [[SFLine alloc] initWithPoints:[SFGeometryUtils degreesToMetersWithLine:line1].points];
    line2 = [[SFLine alloc] initWithPoints:[SFGeometryUtils degreesToMetersWithLine:line2].points];
    
    point = [SFGeometryUtils intersectionBetweenLine1:line1 andLine2:line2];
    [SFTestUtils assertEqualDoubleWithValue:0.0 andValue2:[point.x doubleValue] andDelta:0.00000001];
    [SFTestUtils assertEqualDoubleWithValue:0.0 andValue2:[point.y doubleValue] andDelta:0.00000001];
    
    line1 = [[SFLine alloc] initWithPoint1:[[SFPoint alloc] initWithXValue:-40.0 andYValue:-10.0] andPoint2:[[SFPoint alloc] initWithXValue:20.0 andYValue:70.0]];
    line2 = [[SFLine alloc] initWithPoint1:[[SFPoint alloc] initWithXValue:-40.0 andYValue:70.0] andPoint2:[[SFPoint alloc] initWithXValue:20.0 andYValue:-10.0]];
    
    point = [SFGeometryUtils intersectionBetweenLine1:line1 andLine2:line2];
    [SFTestUtils assertEqualDoubleWithValue:-10.0 andValue2:[point.x doubleValue]];
    [SFTestUtils assertEqualDoubleWithValue:30.0 andValue2:[point.y doubleValue]];
    
    line1 = [SFGeometryUtils degreesToMetersWithLine:line1];
    line2 = [SFGeometryUtils degreesToMetersWithLine:line2];
    
    point = [SFGeometryUtils intersectionBetweenLine1:line1 andLine2:line2];
    [SFTestUtils assertEqualDoubleWithValue:-1113194.9079327362 andValue2:[point.x doubleValue] andDelta:0.00000001];
    [SFTestUtils assertEqualDoubleWithValue:4974912.842260765 andValue2:[point.y doubleValue] andDelta:0.00000001];
    
    point = [SFGeometryUtils metersToDegreesWithPoint:point];
    [SFTestUtils assertEqualDoubleWithValue:-10.0 andValue2:[point.x doubleValue] andDelta:0.0000000000001];
    [SFTestUtils assertEqualDoubleWithValue:40.745756618323014 andValue2:[point.y doubleValue] andDelta:0.0000000000001];
    
    line1 = [[SFLine alloc] initWithPoint1:[[SFPoint alloc] initWithXValue:-SF_WEB_MERCATOR_HALF_WORLD_WIDTH andYValue:SF_WEB_MERCATOR_HALF_WORLD_WIDTH / 2] andPoint2:[[SFPoint alloc] initWithXValue:-SF_WEB_MERCATOR_HALF_WORLD_WIDTH / 2 andYValue:SF_WEB_MERCATOR_HALF_WORLD_WIDTH]];
    line2 = [[SFLine alloc] initWithPoint1:[[SFPoint alloc] initWithXValue:-SF_WEB_MERCATOR_HALF_WORLD_WIDTH andYValue:SF_WEB_MERCATOR_HALF_WORLD_WIDTH] andPoint2:[[SFPoint alloc] initWithXValue:-SF_WEB_MERCATOR_HALF_WORLD_WIDTH / 2 andYValue:SF_WEB_MERCATOR_HALF_WORLD_WIDTH / 2]];
    
    point = [SFGeometryUtils intersectionBetweenLine1:line1 andLine2:line2];
    [SFTestUtils assertEqualDoubleWithValue:0.75 * -SF_WEB_MERCATOR_HALF_WORLD_WIDTH andValue2:[point.x doubleValue] andDelta:0.00000001];
    [SFTestUtils assertEqualDoubleWithValue:0.75 * SF_WEB_MERCATOR_HALF_WORLD_WIDTH andValue2:[point.y doubleValue] andDelta:0.00000001];
    
    point = [SFGeometryUtils metersToDegreesWithPoint:point];
    [SFTestUtils assertEqualDoubleWithValue:-135.0 andValue2:[point.x doubleValue] andDelta:0.0000000000001];
    [SFTestUtils assertEqualDoubleWithValue:79.17133464081945 andValue2:[point.y doubleValue] andDelta:0.0000000000001];
    
}

/**
 * Test point conversion
 */
-(void) testConversion{
    
    SFPoint *point = [[SFPoint alloc] initWithXValue:-112.500003 andYValue:21.943049];
    
    SFPoint *point2 = [SFGeometryUtils degreesToMetersWithPoint:point];
    [SFTestUtils assertEqualDoubleWithValue:-12523443.048201751 andValue2:[point2.x doubleValue] andDelta:0.00000001];
    [SFTestUtils assertEqualDoubleWithValue:2504688.958883909 andValue2:[point2.y doubleValue] andDelta:0.00000001];
    
    SFPoint *point3 = [SFGeometryUtils metersToDegreesWithPoint:point2];
    [SFTestUtils assertEqualDoubleWithValue:-112.500003 andValue2:[point3.x doubleValue] andDelta:0.0000000000001];
    [SFTestUtils assertEqualDoubleWithValue:21.943049 andValue2:[point3.y doubleValue] andDelta:0.0000000000001];
    
}

/**
 * Test crop
 */
-(void) testCrop{
    
    double side = 40;
    double sideC = sqrt(2 * pow(side, 2));

    double min = 10;
    double max = min + side;
    double mid = (min + max) / 2;

    double extraWidth = (sideC - side) / 2;
    double starLength = 11.7157287525381;

    // Test with two squares forming a star (Star of Lakshmi)
    // Polygon as the diamond, square as the crop bounds
    
    SFPolygon *polygon = [[SFPolygon alloc] init];
    SFLineString *ring = [[SFLineString alloc] init];
    [ring addPoint:[[SFPoint alloc] initWithXValue:min - extraWidth andYValue:mid]];
    [ring addPoint:[[SFPoint alloc] initWithXValue:mid andYValue:min - extraWidth]];
    [ring addPoint:[[SFPoint alloc] initWithXValue:max + extraWidth andYValue:mid]];
    [ring addPoint:[[SFPoint alloc] initWithXValue:mid andYValue:max + extraWidth]];
    [polygon addRing:ring];
    
    SFGeometryEnvelope *envelope = [[SFGeometryEnvelope alloc] initWithMinXDouble:min andMinYDouble:min andMaxXDouble:max andMaxYDouble:max];
    
    SFPolygon *crop = [SFGeometryUtils cropPolygon:polygon withEnvelope:envelope];
    
    SFLineString *cropRing = [crop ringAtIndex:0];
    [SFTestUtils assertEqualIntWithValue:9 andValue2:[cropRing numPoints]];
    [SFTestUtils assertTrue:[cropRing isClosed]];
    
    [SFTestUtils assertEqualDoubleWithValue:min andValue2:[[cropRing pointAtIndex:0].x doubleValue] andDelta:0.0];
    [SFTestUtils assertEqualDoubleWithValue:min + starLength andValue2:[[cropRing pointAtIndex:0].y doubleValue] andDelta:0.00000000001];

    [SFTestUtils assertEqualDoubleWithValue:min + starLength andValue2:[[cropRing pointAtIndex:1].x doubleValue] andDelta:0.00000000001];
    [SFTestUtils assertEqualDoubleWithValue:min andValue2:[[cropRing pointAtIndex:1].y doubleValue] andDelta:0.000001];

    [SFTestUtils assertEqualDoubleWithValue:max - starLength andValue2:[[cropRing pointAtIndex:2].x doubleValue] andDelta:0.00000000001];
    [SFTestUtils assertEqualDoubleWithValue:min andValue2:[[cropRing pointAtIndex:2].y doubleValue] andDelta:0.000001];

    [SFTestUtils assertEqualDoubleWithValue:max andValue2:[[cropRing pointAtIndex:3].x doubleValue] andDelta:0.0];
    [SFTestUtils assertEqualDoubleWithValue:min + starLength andValue2:[[cropRing pointAtIndex:3].y doubleValue] andDelta:0.00000000001];

    [SFTestUtils assertEqualDoubleWithValue:max andValue2:[[cropRing pointAtIndex:4].x doubleValue] andDelta:0.0];
    [SFTestUtils assertEqualDoubleWithValue:max - starLength andValue2:[[cropRing pointAtIndex:4].y doubleValue] andDelta:0.00000000001];

    [SFTestUtils assertEqualDoubleWithValue:max - starLength andValue2:[[cropRing pointAtIndex:5].x doubleValue] andDelta:0.00000000001];
    [SFTestUtils assertEqualDoubleWithValue:max andValue2:[[cropRing pointAtIndex:5].y doubleValue] andDelta:0.0];

    [SFTestUtils assertEqualDoubleWithValue:min + starLength andValue2:[[cropRing pointAtIndex:6].x doubleValue] andDelta:0.00000000001];
    [SFTestUtils assertEqualDoubleWithValue:max andValue2:[[cropRing pointAtIndex:6].y doubleValue] andDelta:0.0];

    [SFTestUtils assertEqualDoubleWithValue:min andValue2:[[cropRing pointAtIndex:7].x doubleValue] andDelta:0.0];
    [SFTestUtils assertEqualDoubleWithValue:max - starLength andValue2:[[cropRing pointAtIndex:7].y doubleValue] andDelta:0.00000000001];

    [SFTestUtils assertEqualDoubleWithValue:min andValue2:[[cropRing pointAtIndex:8].x doubleValue] andDelta:0.0];
    [SFTestUtils assertEqualDoubleWithValue:min + starLength andValue2:[[cropRing pointAtIndex:8].y doubleValue] andDelta:0.00000000001];
    
    crop = [SFGeometryUtils cropPolygon:[SFGeometryUtils degreesToMetersWithPolygon:polygon] withEnvelope:[[SFGeometryUtils degreesToMetersWithGeometry:[envelope buildGeometry]] envelope]];
    crop = [SFGeometryUtils metersToDegreesWithPolygon:crop];
    
    cropRing = [crop ringAtIndex:0];
    [SFTestUtils assertEqualIntWithValue:9 andValue2:[cropRing numPoints]];
    [SFTestUtils assertTrue:[cropRing isClosed]];
    
    [SFTestUtils assertEqualDoubleWithValue:min andValue2:[[cropRing pointAtIndex:0].x doubleValue] andDelta:0.00000000001];
    [SFTestUtils assertEqualDoubleWithValue:22.181521688501903 andValue2:[[cropRing pointAtIndex:0].y doubleValue] andDelta:0.00000000001];

    [SFTestUtils assertEqualDoubleWithValue:22.077332337134834 andValue2:[[cropRing pointAtIndex:1].x doubleValue] andDelta:0.00000000001];
    [SFTestUtils assertEqualDoubleWithValue:min andValue2:[[cropRing pointAtIndex:1].y doubleValue] andDelta:0.000001];

    [SFTestUtils assertEqualDoubleWithValue:37.922667662865166 andValue2:[[cropRing pointAtIndex:2].x doubleValue] andDelta:0.00000000001];
    [SFTestUtils assertEqualDoubleWithValue:min andValue2:[[cropRing pointAtIndex:2].y doubleValue] andDelta:0.000001];

    [SFTestUtils assertEqualDoubleWithValue:max andValue2:[[cropRing pointAtIndex:3].x doubleValue] andDelta:0.00000000001];
    [SFTestUtils assertEqualDoubleWithValue:22.181521688501903 andValue2:[[cropRing pointAtIndex:3].y doubleValue] andDelta:0.00000000001];

    [SFTestUtils assertEqualDoubleWithValue:max andValue2:[[cropRing pointAtIndex:4].x doubleValue] andDelta:0.00000000001];
    [SFTestUtils assertEqualDoubleWithValue:39.74197667744292 andValue2:[[cropRing pointAtIndex:4].y doubleValue] andDelta:0.00000000001];

    [SFTestUtils assertEqualDoubleWithValue:39.88507567296453 andValue2:[[cropRing pointAtIndex:5].x doubleValue] andDelta:0.00000000001];
    [SFTestUtils assertEqualDoubleWithValue:max andValue2:[[cropRing pointAtIndex:5].y doubleValue] andDelta:0.0];

    [SFTestUtils assertEqualDoubleWithValue:20.114924327035485 andValue2:[[cropRing pointAtIndex:6].x doubleValue] andDelta:0.00000000001];
    [SFTestUtils assertEqualDoubleWithValue:max andValue2:[[cropRing pointAtIndex:6].y doubleValue] andDelta:0.0];

    [SFTestUtils assertEqualDoubleWithValue:min andValue2:[[cropRing pointAtIndex:7].x doubleValue] andDelta:0.00000000001];
    [SFTestUtils assertEqualDoubleWithValue:39.74197667744289 andValue2:[[cropRing pointAtIndex:7].y doubleValue] andDelta:0.00000000001];

    [SFTestUtils assertEqualDoubleWithValue:min andValue2:[[cropRing pointAtIndex:8].x doubleValue] andDelta:0.00000000001];
    [SFTestUtils assertEqualDoubleWithValue:22.181521688501903 andValue2:[[cropRing pointAtIndex:8].y doubleValue] andDelta:0.00000000001];
    
    // Test with a diamond fully fitting within the crop bounds
    
    polygon = [[SFPolygon alloc] init];
    ring = [[SFLineString alloc] init];
    [ring addPoint:[[SFPoint alloc] initWithXValue:min andYValue:mid]];
    [ring addPoint:[[SFPoint alloc] initWithXValue:mid andYValue:min]];
    [ring addPoint:[[SFPoint alloc] initWithXValue:max andYValue:mid]];
    [ring addPoint:[[SFPoint alloc] initWithXValue:mid andYValue:max]];
    [polygon addRing:ring];
    
    crop = [SFGeometryUtils cropPolygon:polygon withEnvelope:envelope];
    
    cropRing = [crop ringAtIndex:0];
    [SFTestUtils assertEqualIntWithValue:5 andValue2:[cropRing numPoints]];
    [SFTestUtils assertTrue:[cropRing isClosed]];
    
    [SFTestUtils assertEqualDoubleWithValue:min andValue2:[[cropRing pointAtIndex:0].x doubleValue] andDelta:0.0];
    [SFTestUtils assertEqualDoubleWithValue:mid andValue2:[[cropRing pointAtIndex:0].y doubleValue] andDelta:0.0];

    [SFTestUtils assertEqualDoubleWithValue:mid andValue2:[[cropRing pointAtIndex:1].x doubleValue] andDelta:0.0];
    [SFTestUtils assertEqualDoubleWithValue:min andValue2:[[cropRing pointAtIndex:1].y doubleValue] andDelta:0.0];

    [SFTestUtils assertEqualDoubleWithValue:max andValue2:[[cropRing pointAtIndex:2].x doubleValue] andDelta:0.0];
    [SFTestUtils assertEqualDoubleWithValue:mid andValue2:[[cropRing pointAtIndex:2].y doubleValue] andDelta:0.0];

    [SFTestUtils assertEqualDoubleWithValue:mid andValue2:[[cropRing pointAtIndex:3].x doubleValue] andDelta:0.0];
    [SFTestUtils assertEqualDoubleWithValue:max andValue2:[[cropRing pointAtIndex:3].y doubleValue] andDelta:0.0];

    [SFTestUtils assertEqualDoubleWithValue:min andValue2:[[cropRing pointAtIndex:4].x doubleValue] andDelta:0.0];
    [SFTestUtils assertEqualDoubleWithValue:mid andValue2:[[cropRing pointAtIndex:4].y doubleValue] andDelta:0.0];
    
    crop = [SFGeometryUtils cropPolygon:[SFGeometryUtils degreesToMetersWithPolygon:polygon] withEnvelope:[[SFGeometryUtils degreesToMetersWithGeometry:[envelope buildGeometry]] envelope]];
    crop = [SFGeometryUtils metersToDegreesWithPolygon:crop];
    
    cropRing = [crop ringAtIndex:0];
    [SFTestUtils assertEqualIntWithValue:5 andValue2:[cropRing numPoints]];
    [SFTestUtils assertTrue:[cropRing isClosed]];
    
    [SFTestUtils assertEqualDoubleWithValue:min andValue2:[[cropRing pointAtIndex:0].x doubleValue] andDelta:0.0000000000001];
    [SFTestUtils assertEqualDoubleWithValue:mid andValue2:[[cropRing pointAtIndex:0].y doubleValue] andDelta:0.0];

    [SFTestUtils assertEqualDoubleWithValue:mid andValue2:[[cropRing pointAtIndex:1].x doubleValue] andDelta:0.0000000000001];
    [SFTestUtils assertEqualDoubleWithValue:min andValue2:[[cropRing pointAtIndex:1].y doubleValue] andDelta:0.0000000000001];

    [SFTestUtils assertEqualDoubleWithValue:max andValue2:[[cropRing pointAtIndex:2].x doubleValue] andDelta:0.0000000000001];
    [SFTestUtils assertEqualDoubleWithValue:mid andValue2:[[cropRing pointAtIndex:2].y doubleValue] andDelta:0.0];

    [SFTestUtils assertEqualDoubleWithValue:mid andValue2:[[cropRing pointAtIndex:3].x doubleValue] andDelta:0.0000000000001];
    [SFTestUtils assertEqualDoubleWithValue:max andValue2:[[cropRing pointAtIndex:3].y doubleValue] andDelta:0.0];

    [SFTestUtils assertEqualDoubleWithValue:min andValue2:[[cropRing pointAtIndex:4].x doubleValue] andDelta:0.0000000000001];
    [SFTestUtils assertEqualDoubleWithValue:mid andValue2:[[cropRing pointAtIndex:4].y doubleValue] andDelta:0.0];
    
    // Test with a star (Star of Lakshmi outer border) polygon and square as
    // the crop bounds
    
    polygon = [[SFPolygon alloc] init];
    ring = [[SFLineString alloc] init];
    [ring addPoint:[[SFPoint alloc] initWithXValue:min - extraWidth andYValue:mid]];
    [ring addPoint:[[SFPoint alloc] initWithXValue:min andYValue:min + extraWidth]];
    [ring addPoint:[[SFPoint alloc] initWithXValue:min andYValue:min]];
    [ring addPoint:[[SFPoint alloc] initWithXValue:min + extraWidth andYValue:min]];
    [ring addPoint:[[SFPoint alloc] initWithXValue:mid andYValue:min - extraWidth]];
    [ring addPoint:[[SFPoint alloc] initWithXValue:max - extraWidth andYValue:min]];
    [ring addPoint:[[SFPoint alloc] initWithXValue:max andYValue:min]];
    [ring addPoint:[[SFPoint alloc] initWithXValue:max andYValue:min + extraWidth]];
    [ring addPoint:[[SFPoint alloc] initWithXValue:max + extraWidth andYValue:mid]];
    [ring addPoint:[[SFPoint alloc] initWithXValue:max andYValue:max - extraWidth]];
    [ring addPoint:[[SFPoint alloc] initWithXValue:max andYValue:max]];
    [ring addPoint:[[SFPoint alloc] initWithXValue:max - extraWidth andYValue:max]];
    [ring addPoint:[[SFPoint alloc] initWithXValue:mid andYValue:max + extraWidth]];
    [ring addPoint:[[SFPoint alloc] initWithXValue:min + extraWidth andYValue:max]];
    [ring addPoint:[[SFPoint alloc] initWithXValue:min andYValue:max]];
    [ring addPoint:[[SFPoint alloc] initWithXValue:min andYValue:max - extraWidth]];
    [polygon addRing:ring];
    
    crop = [SFGeometryUtils cropPolygon:polygon withEnvelope:envelope];
    
    cropRing = [crop ringAtIndex:0];
    [SFTestUtils assertEqualIntWithValue:10 andValue2:[cropRing numPoints]];
    [SFTestUtils assertTrue:[cropRing isClosed]];
    
    [SFTestUtils assertEqualDoubleWithValue:min andValue2:[[cropRing pointAtIndex:0].x doubleValue] andDelta:0.0];
    [SFTestUtils assertEqualDoubleWithValue:min + extraWidth andValue2:[[cropRing pointAtIndex:0].y doubleValue] andDelta:0.0000000000001];

    [SFTestUtils assertEqualDoubleWithValue:min andValue2:[[cropRing pointAtIndex:1].x doubleValue] andDelta:0.0];
    [SFTestUtils assertEqualDoubleWithValue:min andValue2:[[cropRing pointAtIndex:1].y doubleValue] andDelta:0.0];

    [SFTestUtils assertEqualDoubleWithValue:max - extraWidth andValue2:[[cropRing pointAtIndex:2].x doubleValue] andDelta:0.0000000000001];
    [SFTestUtils assertEqualDoubleWithValue:min andValue2:[[cropRing pointAtIndex:2].y doubleValue] andDelta:0.0];
    
    [SFTestUtils assertEqualDoubleWithValue:max andValue2:[[cropRing pointAtIndex:3].x doubleValue] andDelta:0.0];
    [SFTestUtils assertEqualDoubleWithValue:min andValue2:[[cropRing pointAtIndex:3].y doubleValue] andDelta:0.0];

    [SFTestUtils assertEqualDoubleWithValue:max andValue2:[[cropRing pointAtIndex:4].x doubleValue] andDelta:0.0];
    [SFTestUtils assertEqualDoubleWithValue:max - extraWidth andValue2:[[cropRing pointAtIndex:4].y doubleValue] andDelta:0.0000000000001];
    
    [SFTestUtils assertEqualDoubleWithValue:max andValue2:[[cropRing pointAtIndex:5].x doubleValue] andDelta:0.0];
    [SFTestUtils assertEqualDoubleWithValue:max andValue2:[[cropRing pointAtIndex:5].y doubleValue] andDelta:0.0];

    [SFTestUtils assertEqualDoubleWithValue:max - extraWidth andValue2:[[cropRing pointAtIndex:6].x doubleValue] andDelta:0.0000000000001];
    [SFTestUtils assertEqualDoubleWithValue:max andValue2:[[cropRing pointAtIndex:6].y doubleValue] andDelta:0.0];
    
    [SFTestUtils assertEqualDoubleWithValue:min andValue2:[[cropRing pointAtIndex:7].x doubleValue] andDelta:0.0];
    [SFTestUtils assertEqualDoubleWithValue:max andValue2:[[cropRing pointAtIndex:7].y doubleValue] andDelta:0.0];
    
    [SFTestUtils assertEqualDoubleWithValue:min andValue2:[[cropRing pointAtIndex:8].x doubleValue] andDelta:0.0];
    [SFTestUtils assertEqualDoubleWithValue:max - extraWidth andValue2:[[cropRing pointAtIndex:8].y doubleValue] andDelta:0.0000000000001];
    
    [SFTestUtils assertEqualDoubleWithValue:min andValue2:[[cropRing pointAtIndex:9].x doubleValue] andDelta:0.0];
    [SFTestUtils assertEqualDoubleWithValue:min + extraWidth andValue2:[[cropRing pointAtIndex:9].y doubleValue] andDelta:0.0000000000001];
    
    crop = [SFGeometryUtils cropPolygon:[SFGeometryUtils degreesToMetersWithPolygon:polygon] withEnvelope:[[SFGeometryUtils degreesToMetersWithGeometry:[envelope buildGeometry]] envelope]];
    crop = [SFGeometryUtils metersToDegreesWithPolygon:crop];
    
    cropRing = [crop ringAtIndex:0];
    [SFTestUtils assertEqualIntWithValue:9 andValue2:[cropRing numPoints]];
    [SFTestUtils assertTrue:[cropRing isClosed]];
    
    [SFTestUtils assertEqualDoubleWithValue:min andValue2:[[cropRing pointAtIndex:0].x doubleValue] andDelta:0.0000000000001];
    [SFTestUtils assertEqualDoubleWithValue:min + extraWidth andValue2:[[cropRing pointAtIndex:0].y doubleValue] andDelta:0.0000000000001];

    [SFTestUtils assertEqualDoubleWithValue:min andValue2:[[cropRing pointAtIndex:1].x doubleValue] andDelta:0.0000000000001];
    [SFTestUtils assertEqualDoubleWithValue:min andValue2:[[cropRing pointAtIndex:1].y doubleValue] andDelta:0.0000000000001];

    [SFTestUtils assertEqualDoubleWithValue:max - extraWidth andValue2:[[cropRing pointAtIndex:2].x doubleValue] andDelta:0.0000000000001];
    [SFTestUtils assertEqualDoubleWithValue:min andValue2:[[cropRing pointAtIndex:2].y doubleValue] andDelta:0.0000000000001];

    [SFTestUtils assertEqualDoubleWithValue:max andValue2:[[cropRing pointAtIndex:3].x doubleValue] andDelta:0.0000000000001];
    [SFTestUtils assertEqualDoubleWithValue:min andValue2:[[cropRing pointAtIndex:3].y doubleValue] andDelta:0.0000000000001];

    [SFTestUtils assertEqualDoubleWithValue:max andValue2:[[cropRing pointAtIndex:4].x doubleValue] andDelta:0.0000000000001];
    [SFTestUtils assertEqualDoubleWithValue:max andValue2:[[cropRing pointAtIndex:4].y doubleValue] andDelta:0.0000000000001];
    
    [SFTestUtils assertEqualDoubleWithValue:min + extraWidth andValue2:[[cropRing pointAtIndex:5].x doubleValue] andDelta:0.0000000000001];
    [SFTestUtils assertEqualDoubleWithValue:max andValue2:[[cropRing pointAtIndex:5].y doubleValue] andDelta:0.0];
    
    [SFTestUtils assertEqualDoubleWithValue:min andValue2:[[cropRing pointAtIndex:6].x doubleValue] andDelta:0.0000000000001];
    [SFTestUtils assertEqualDoubleWithValue:max andValue2:[[cropRing pointAtIndex:6].y doubleValue] andDelta:0.0];
    
    [SFTestUtils assertEqualDoubleWithValue:min andValue2:[[cropRing pointAtIndex:7].x doubleValue] andDelta:0.0000000000001];
    [SFTestUtils assertEqualDoubleWithValue:max - extraWidth andValue2:[[cropRing pointAtIndex:7].y doubleValue] andDelta:0.0000000000001];
    
    [SFTestUtils assertEqualDoubleWithValue:min andValue2:[[cropRing pointAtIndex:8].x doubleValue] andDelta:0.0000000000001];
    [SFTestUtils assertEqualDoubleWithValue:min + extraWidth andValue2:[[cropRing pointAtIndex:8].y doubleValue] andDelta:0.0000000000001];
    
}

/**
 * Test crop over the international date line
 */
-(void) testCropIDL{
    
    SFPolygon *polygon = [[SFPolygon alloc] init];
    SFLineString *ring = [[SFLineString alloc] init];
    [ring addPoint:[[SFPoint alloc] initWithXValue:-168.967 andYValue:67.0]];
    [ring addPoint:[[SFPoint alloc] initWithXValue:-168.967 andYValue:90.0]];
    [ring addPoint:[[SFPoint alloc] initWithXValue:-180.0000000001 andYValue:90.0000001148]];
    [ring addPoint:[[SFPoint alloc] initWithXValue:-180.0000000001 andYValue:67.0]];
    [ring addPoint:[[SFPoint alloc] initWithXValue:-168.967 andYValue:67.0]];
    [polygon addRing:ring];
    
    SFPolygon *meters = [SFGeometryUtils degreesToMetersWithPolygon:polygon];
    SFPolygon *crop = (SFPolygon *) [SFGeometryUtils cropWebMercatorGeometry:meters];
    SFPolygon *degrees = [SFGeometryUtils metersToDegreesWithPolygon:crop];
    [SFGeometryUtils minimizeWGS84Geometry:degrees];
    
    SFLineString *cropRing = [degrees ringAtIndex:0];
    [SFTestUtils assertEqualIntWithValue:5 andValue2:[cropRing numPoints]];
    [SFTestUtils assertTrue:[cropRing isClosed]];
    
    [SFTestUtils assertEqualDoubleWithValue:-168.967 andValue2:[[cropRing pointAtIndex:0].x doubleValue] andDelta:0.00000000001];
    [SFTestUtils assertEqualDoubleWithValue:67.0 andValue2:[[cropRing pointAtIndex:0].y doubleValue] andDelta:0.00000000001];

    [SFTestUtils assertEqualDoubleWithValue:-168.967 andValue2:[[cropRing pointAtIndex:1].x doubleValue] andDelta:0.00000000001];
    [SFTestUtils assertEqualDoubleWithValue:SF_WEB_MERCATOR_MAX_LAT_RANGE andValue2:[[cropRing pointAtIndex:1].y doubleValue] andDelta:0.00000000001];

    [SFTestUtils assertEqualDoubleWithValue:-180.0000000001 andValue2:[[cropRing pointAtIndex:2].x doubleValue] andDelta:0.00000000001];
    [SFTestUtils assertEqualDoubleWithValue:SF_WEB_MERCATOR_MAX_LAT_RANGE andValue2:[[cropRing pointAtIndex:2].y doubleValue] andDelta:0.00000000001];

    [SFTestUtils assertEqualDoubleWithValue:-180.0000000001 andValue2:[[cropRing pointAtIndex:3].x doubleValue] andDelta:0.00000000001];
    [SFTestUtils assertEqualDoubleWithValue:67.0 andValue2:[[cropRing pointAtIndex:3].y doubleValue] andDelta:0.00000000001];

    [SFTestUtils assertEqualDoubleWithValue:-168.967 andValue2:[[cropRing pointAtIndex:4].x doubleValue] andDelta:0.00000000001];
    [SFTestUtils assertEqualDoubleWithValue:67.0 andValue2:[[cropRing pointAtIndex:4].y doubleValue] andDelta:0.00000000001];
    
    polygon = [[SFPolygon alloc] init];
    ring = [[SFLineString alloc] init];
    [ring addPoint:[[SFPoint alloc] initWithXValue:-18809320.400867056 andYValue:10156058.722522344]];
    [ring addPoint:[[SFPoint alloc] initWithXValue:-18809320.400867056 andYValue:238107693.26496765]];
    [ring addPoint:[[SFPoint alloc] initWithXValue:-20037508.342800375 andYValue:238107693.26496765]];
    [ring addPoint:[[SFPoint alloc] initWithXValue:-20037508.342800375 andYValue:10156058.722522344]];
    [ring addPoint:[[SFPoint alloc] initWithXValue:-18809320.400867056 andYValue:10156058.722522344]];
    [polygon addRing:ring];
    
    SFGeometryEnvelope *envelope = [SFGeometryUtils webMercatorEnvelope];
    [envelope setMinX:[[NSDecimalNumber alloc] initWithDouble:-20037508.342800375]];

    crop = [SFGeometryUtils cropPolygon:polygon withEnvelope:envelope];
    
    cropRing = [crop ringAtIndex:0];
    [SFTestUtils assertEqualIntWithValue:5 andValue2:[cropRing numPoints]];
    [SFTestUtils assertTrue:[cropRing isClosed]];
    
    [SFTestUtils assertEqualDoubleWithValue:-18809320.400867056 andValue2:[[cropRing pointAtIndex:0].x doubleValue] andDelta:0.0000001];
    [SFTestUtils assertEqualDoubleWithValue:10156058.722522344 andValue2:[[cropRing pointAtIndex:0].y doubleValue] andDelta:0.0000001];

    [SFTestUtils assertEqualDoubleWithValue:-18809320.400867056 andValue2:[[cropRing pointAtIndex:1].x doubleValue] andDelta:0.0000001];
    [SFTestUtils assertEqualDoubleWithValue:SF_WEB_MERCATOR_HALF_WORLD_WIDTH andValue2:[[cropRing pointAtIndex:1].y doubleValue] andDelta:0.00000001];

    [SFTestUtils assertEqualDoubleWithValue:-20037508.342800375 andValue2:[[cropRing pointAtIndex:2].x doubleValue] andDelta:0.00000000001];
    [SFTestUtils assertEqualDoubleWithValue:SF_WEB_MERCATOR_HALF_WORLD_WIDTH andValue2:[[cropRing pointAtIndex:2].y doubleValue] andDelta:0.00000000001];

    [SFTestUtils assertEqualDoubleWithValue:-20037508.342800375 andValue2:[[cropRing pointAtIndex:3].x doubleValue] andDelta:0.00000000001];
    [SFTestUtils assertEqualDoubleWithValue:10156058.722522344 andValue2:[[cropRing pointAtIndex:3].y doubleValue] andDelta:0.0000001];

    [SFTestUtils assertEqualDoubleWithValue:-18809320.400867056 andValue2:[[cropRing pointAtIndex:4].x doubleValue] andDelta:0.0000001];
    [SFTestUtils assertEqualDoubleWithValue:10156058.722522344 andValue2:[[cropRing pointAtIndex:4].y doubleValue] andDelta:0.0000001];
    
    polygon = [[SFPolygon alloc] init];
    ring = [[SFLineString alloc] init];
    [ring addPoint:[[SFPoint alloc] initWithXValue:-120.0 andYValue:-90.0]];
    [ring addPoint:[[SFPoint alloc] initWithXValue:-120.0 andYValue:0.0]];
    [ring addPoint:[[SFPoint alloc] initWithXValue:-180.0 andYValue:0.0]];
    [ring addPoint:[[SFPoint alloc] initWithXValue:-180.0 andYValue:-90.0]];
    [ring addPoint:[[SFPoint alloc] initWithXValue:-120.0 andYValue:-90.0]];
    [polygon addRing:ring];
    
    meters = [SFGeometryUtils degreesToMetersWithPolygon:polygon];
    crop = (SFPolygon *) [SFGeometryUtils cropWebMercatorGeometry:meters];
    degrees = [SFGeometryUtils metersToDegreesWithPolygon:crop];
    [SFGeometryUtils minimizeWGS84Geometry:degrees];
    
    cropRing = [degrees ringAtIndex:0];
    [SFTestUtils assertEqualIntWithValue:5 andValue2:[cropRing numPoints]];
    [SFTestUtils assertTrue:[cropRing isClosed]];
    
    [SFTestUtils assertEqualDoubleWithValue:-120.0 andValue2:[[cropRing pointAtIndex:0].x doubleValue] andDelta:0.00000000001];
    [SFTestUtils assertEqualDoubleWithValue:SF_WEB_MERCATOR_MIN_LAT_RANGE andValue2:[[cropRing pointAtIndex:0].y doubleValue] andDelta:0.00000000001];

    [SFTestUtils assertEqualDoubleWithValue:-120.0 andValue2:[[cropRing pointAtIndex:1].x doubleValue] andDelta:0.00000000001];
    [SFTestUtils assertEqualDoubleWithValue:0.0 andValue2:[[cropRing pointAtIndex:1].y doubleValue] andDelta:0.0];

    [SFTestUtils assertEqualDoubleWithValue:-180.0 andValue2:[[cropRing pointAtIndex:2].x doubleValue] andDelta:0.0];
    [SFTestUtils assertEqualDoubleWithValue:0.0 andValue2:[[cropRing pointAtIndex:2].y doubleValue] andDelta:0.0];

    [SFTestUtils assertEqualDoubleWithValue:-180.0 andValue2:[[cropRing pointAtIndex:3].x doubleValue] andDelta:0.0];
    [SFTestUtils assertEqualDoubleWithValue:SF_WEB_MERCATOR_MIN_LAT_RANGE andValue2:[[cropRing pointAtIndex:3].y doubleValue] andDelta:0.00000000001];

    [SFTestUtils assertEqualDoubleWithValue:-120.0 andValue2:[[cropRing pointAtIndex:4].x doubleValue] andDelta:0.00000000001];
    [SFTestUtils assertEqualDoubleWithValue:SF_WEB_MERCATOR_MIN_LAT_RANGE andValue2:[[cropRing pointAtIndex:4].y doubleValue] andDelta:0.00000000001];
    
    polygon = [[SFPolygon alloc] init];
    ring = [[SFLineString alloc] init];
    [ring addPoint:[[SFPoint alloc] initWithXValue:-13358338.89519283 andYValue:-233606567.09255272]];
    [ring addPoint:[[SFPoint alloc] initWithXValue:-13358338.89519283 andYValue:0.0]];
    [ring addPoint:[[SFPoint alloc] initWithXValue:-SF_WEB_MERCATOR_HALF_WORLD_WIDTH andYValue:0.0]];
    [ring addPoint:[[SFPoint alloc] initWithXValue:-SF_WEB_MERCATOR_HALF_WORLD_WIDTH andYValue:-233606567.09255272]];
    [ring addPoint:[[SFPoint alloc] initWithXValue:-13358338.89519283 andYValue:-233606567.09255272]];
    [polygon addRing:ring];

    crop = (SFPolygon *)[SFGeometryUtils cropWebMercatorGeometry:polygon];
    
    cropRing = [crop ringAtIndex:0];
    [SFTestUtils assertEqualIntWithValue:5 andValue2:[cropRing numPoints]];
    [SFTestUtils assertTrue:[cropRing isClosed]];
    
    [SFTestUtils assertEqualDoubleWithValue:-13358338.89519283 andValue2:[[cropRing pointAtIndex:0].x doubleValue] andDelta:0.00000001];
    [SFTestUtils assertEqualDoubleWithValue:-SF_WEB_MERCATOR_HALF_WORLD_WIDTH andValue2:[[cropRing pointAtIndex:0].y doubleValue] andDelta:0.00000001];

    [SFTestUtils assertEqualDoubleWithValue:-13358338.89519283 andValue2:[[cropRing pointAtIndex:1].x doubleValue] andDelta:0.00000001];
    [SFTestUtils assertEqualDoubleWithValue:0.0 andValue2:[[cropRing pointAtIndex:1].y doubleValue] andDelta:0.0];

    [SFTestUtils assertEqualDoubleWithValue:-SF_WEB_MERCATOR_HALF_WORLD_WIDTH andValue2:[[cropRing pointAtIndex:2].x doubleValue] andDelta:0.0];
    [SFTestUtils assertEqualDoubleWithValue:0.0 andValue2:[[cropRing pointAtIndex:2].y doubleValue] andDelta:0.0];

    [SFTestUtils assertEqualDoubleWithValue:-SF_WEB_MERCATOR_HALF_WORLD_WIDTH andValue2:[[cropRing pointAtIndex:3].x doubleValue] andDelta:0.0];
    [SFTestUtils assertEqualDoubleWithValue:-SF_WEB_MERCATOR_HALF_WORLD_WIDTH andValue2:[[cropRing pointAtIndex:3].y doubleValue] andDelta:0.00000001];

    [SFTestUtils assertEqualDoubleWithValue:-13358338.89519283 andValue2:[[cropRing pointAtIndex:4].x doubleValue] andDelta:0.00000001];
    [SFTestUtils assertEqualDoubleWithValue:-SF_WEB_MERCATOR_HALF_WORLD_WIDTH andValue2:[[cropRing pointAtIndex:4].y doubleValue] andDelta:0.00000001];
    
}

/**
 * Test bound
 */
-(void) testBound{
    
    SFPolygon *polygon = [[SFPolygon alloc] init];
    SFLineString *ring = [[SFLineString alloc] init];
    [ring addPoint:[[SFPoint alloc] initWithXValue:-180.01 andYValue:90.01]];
    [ring addPoint:[[SFPoint alloc] initWithXValue:-90.0 andYValue:0.0]];
    [ring addPoint:[[SFPoint alloc] initWithXValue:-181.0 andYValue:-91.0]];
    [ring addPoint:[[SFPoint alloc] initWithXValue:0 andYValue:-45.0]];
    [ring addPoint:[[SFPoint alloc] initWithXValue:180.00000000001 andYValue:-90.00000000001]];
    [ring addPoint:[[SFPoint alloc] initWithXValue:90.0 andYValue:0.0]];
    [ring addPoint:[[SFPoint alloc] initWithXValue:180.0 andYValue:90.0]];
    [ring addPoint:[[SFPoint alloc] initWithXValue:0 andYValue:45.0]];
    [ring addPoint:[[SFPoint alloc] initWithXValue:-180.01 andYValue:90.01]];
    [polygon addRing:ring];
    
    [SFTestUtils assertFalse:[[SFGeometryUtils wgs84Envelope] containsEnvelope:[polygon envelope]]];
    
    SFPolygon *bounded = (SFPolygon *) [polygon mutableCopy];
    
    [SFGeometryUtils boundWGS84Geometry:bounded];
    
    SFLineString *boundedRing = [bounded ringAtIndex:0];
    [SFTestUtils assertEqualIntWithValue:[ring numPoints] andValue2:[boundedRing numPoints]];
    [SFTestUtils assertTrue:[boundedRing isClosed]];
    [SFTestUtils assertTrue:[[SFGeometryUtils wgs84Envelope] containsEnvelope:[bounded envelope]]];
    
    [SFTestUtils assertEqualDoubleWithValue:-SF_WGS84_HALF_WORLD_LON_WIDTH andValue2:[[boundedRing pointAtIndex:0].x doubleValue] andDelta:0.0];
    [SFTestUtils assertEqualDoubleWithValue:SF_WGS84_HALF_WORLD_LAT_HEIGHT andValue2:[[boundedRing pointAtIndex:0].y doubleValue] andDelta:0.0];

    [SFTestUtils assertEqualDoubleWithValue:-90.0 andValue2:[[boundedRing pointAtIndex:1].x doubleValue] andDelta:0.0];
    [SFTestUtils assertEqualDoubleWithValue:0.0 andValue2:[[boundedRing pointAtIndex:1].y doubleValue] andDelta:0.0];

    [SFTestUtils assertEqualDoubleWithValue:-SF_WGS84_HALF_WORLD_LON_WIDTH andValue2:[[boundedRing pointAtIndex:2].x doubleValue] andDelta:0.0];
    [SFTestUtils assertEqualDoubleWithValue:-SF_WGS84_HALF_WORLD_LAT_HEIGHT andValue2:[[boundedRing pointAtIndex:2].y doubleValue] andDelta:0.0];

    [SFTestUtils assertEqualDoubleWithValue:0.0 andValue2:[[boundedRing pointAtIndex:3].x doubleValue] andDelta:0.0];
    [SFTestUtils assertEqualDoubleWithValue:-45.0 andValue2:[[boundedRing pointAtIndex:3].y doubleValue] andDelta:0.0];

    [SFTestUtils assertEqualDoubleWithValue:SF_WGS84_HALF_WORLD_LON_WIDTH andValue2:[[boundedRing pointAtIndex:4].x doubleValue] andDelta:0.0];
    [SFTestUtils assertEqualDoubleWithValue:-SF_WGS84_HALF_WORLD_LAT_HEIGHT andValue2:[[boundedRing pointAtIndex:4].y doubleValue] andDelta:0.0];
    
    [SFTestUtils assertEqualDoubleWithValue:90.0 andValue2:[[boundedRing pointAtIndex:5].x doubleValue] andDelta:0.0];
    [SFTestUtils assertEqualDoubleWithValue:0.0 andValue2:[[boundedRing pointAtIndex:5].y doubleValue] andDelta:0.0];

    [SFTestUtils assertEqualDoubleWithValue:SF_WGS84_HALF_WORLD_LON_WIDTH andValue2:[[boundedRing pointAtIndex:6].x doubleValue] andDelta:0.0];
    [SFTestUtils assertEqualDoubleWithValue:SF_WGS84_HALF_WORLD_LAT_HEIGHT andValue2:[[boundedRing pointAtIndex:6].y doubleValue] andDelta:0.0];

    [SFTestUtils assertEqualDoubleWithValue:0.0 andValue2:[[boundedRing pointAtIndex:7].x doubleValue] andDelta:0.0];
    [SFTestUtils assertEqualDoubleWithValue:45.0 andValue2:[[boundedRing pointAtIndex:7].y doubleValue] andDelta:0.0];

    [SFTestUtils assertEqualDoubleWithValue:-SF_WGS84_HALF_WORLD_LON_WIDTH andValue2:[[boundedRing pointAtIndex:8].x doubleValue] andDelta:0.0];
    [SFTestUtils assertEqualDoubleWithValue:SF_WGS84_HALF_WORLD_LAT_HEIGHT andValue2:[[boundedRing pointAtIndex:8].y doubleValue] andDelta:0.0];
    
    [SFTestUtils assertFalse:[[SFGeometryUtils wgs84EnvelopeWithWebMercator] containsEnvelope:[polygon envelope]]];
    
    bounded = (SFPolygon *) [polygon mutableCopy];
    
    [SFGeometryUtils boundWGS84WithWebMercatorGeometry:bounded];
    
    boundedRing = [bounded ringAtIndex:0];
    [SFTestUtils assertEqualIntWithValue:[ring numPoints] andValue2:[boundedRing numPoints]];
    [SFTestUtils assertTrue:[boundedRing isClosed]];
    [SFTestUtils assertTrue:[[SFGeometryUtils wgs84EnvelopeWithWebMercator] containsEnvelope:[bounded envelope]]];
    
    [SFTestUtils assertEqualDoubleWithValue:-SF_WGS84_HALF_WORLD_LON_WIDTH andValue2:[[boundedRing pointAtIndex:0].x doubleValue] andDelta:0.0];
    [SFTestUtils assertEqualDoubleWithValue:SF_WEB_MERCATOR_MAX_LAT_RANGE andValue2:[[boundedRing pointAtIndex:0].y doubleValue] andDelta:0.0];

    [SFTestUtils assertEqualDoubleWithValue:-90.0 andValue2:[[boundedRing pointAtIndex:1].x doubleValue] andDelta:0.0];
    [SFTestUtils assertEqualDoubleWithValue:0.0 andValue2:[[boundedRing pointAtIndex:1].y doubleValue] andDelta:0.0];

    [SFTestUtils assertEqualDoubleWithValue:-SF_WGS84_HALF_WORLD_LON_WIDTH andValue2:[[boundedRing pointAtIndex:2].x doubleValue] andDelta:0.0];
    [SFTestUtils assertEqualDoubleWithValue:SF_WEB_MERCATOR_MIN_LAT_RANGE andValue2:[[boundedRing pointAtIndex:2].y doubleValue] andDelta:0.00000000001];

    [SFTestUtils assertEqualDoubleWithValue:0.0 andValue2:[[boundedRing pointAtIndex:3].x doubleValue] andDelta:0.0];
    [SFTestUtils assertEqualDoubleWithValue:-45.0 andValue2:[[boundedRing pointAtIndex:3].y doubleValue] andDelta:0.0];

    [SFTestUtils assertEqualDoubleWithValue:SF_WGS84_HALF_WORLD_LON_WIDTH andValue2:[[boundedRing pointAtIndex:4].x doubleValue] andDelta:0.0];
    [SFTestUtils assertEqualDoubleWithValue:SF_WEB_MERCATOR_MIN_LAT_RANGE andValue2:[[boundedRing pointAtIndex:4].y doubleValue] andDelta:0.00000000001];
    
    [SFTestUtils assertEqualDoubleWithValue:90.0 andValue2:[[boundedRing pointAtIndex:5].x doubleValue] andDelta:0.0];
    [SFTestUtils assertEqualDoubleWithValue:0.0 andValue2:[[boundedRing pointAtIndex:5].y doubleValue] andDelta:0.0];

    [SFTestUtils assertEqualDoubleWithValue:SF_WGS84_HALF_WORLD_LON_WIDTH andValue2:[[boundedRing pointAtIndex:6].x doubleValue] andDelta:0.0];
    [SFTestUtils assertEqualDoubleWithValue:SF_WEB_MERCATOR_MAX_LAT_RANGE andValue2:[[boundedRing pointAtIndex:6].y doubleValue] andDelta:0.0];

    [SFTestUtils assertEqualDoubleWithValue:0.0 andValue2:[[boundedRing pointAtIndex:7].x doubleValue] andDelta:0.0];
    [SFTestUtils assertEqualDoubleWithValue:45.0 andValue2:[[boundedRing pointAtIndex:7].y doubleValue] andDelta:0.0];

    [SFTestUtils assertEqualDoubleWithValue:-SF_WGS84_HALF_WORLD_LON_WIDTH andValue2:[[boundedRing pointAtIndex:8].x doubleValue] andDelta:0.0];
    [SFTestUtils assertEqualDoubleWithValue:SF_WEB_MERCATOR_MAX_LAT_RANGE andValue2:[[boundedRing pointAtIndex:8].y doubleValue] andDelta:0.0];
    
}

/**
 * Test the geometry type parent and child hierarchy methods
 */
-(void) testHierarchy{
    
    for(int geometryTypeNumber = 0; geometryTypeNumber < SF_NONE; geometryTypeNumber++){
        enum SFGeometryType geometryType = geometryTypeNumber;
        
        enum SFGeometryType parentType = [SFGeometryUtils parentTypeOfType:geometryType];
        NSArray<NSNumber *> *parentHierarchy = [SFGeometryUtils parentHierarchyOfType:geometryType];
        
        enum SFGeometryType previousParentType = SF_NONE;
        
        while (parentType != SF_NONE) {
            [SFTestUtils assertEqualIntWithValue:parentType andValue2:[[parentHierarchy objectAtIndex:0] intValue]];
            
            if (previousParentType != SF_NONE) {
                NSArray<NSNumber *> *childTypes = [SFGeometryUtils childTypesOfType:parentType];
                [SFTestUtils assertTrue:[childTypes containsObject:[NSNumber numberWithInt:previousParentType]]];
                NSDictionary<NSNumber *, NSDictionary *> *childHierarchy = [SFGeometryUtils childHierarchyOfType:parentType];
                NSDictionary *previousParentChildHierarchy = [childHierarchy objectForKey:[NSNumber numberWithInt:previousParentType]];
                [SFTestUtils assertTrue:previousParentChildHierarchy != nil && previousParentChildHierarchy.count > 0];
            }
            
            previousParentType = parentType;
            parentType = [SFGeometryUtils parentTypeOfType:previousParentType];
            parentHierarchy = [SFGeometryUtils parentHierarchyOfType:previousParentType];
            
        }
        [SFTestUtils assertTrue:parentHierarchy.count == 0];
        
        NSDictionary<NSNumber *, NSDictionary *> *childHierarchy = [SFGeometryUtils childHierarchyOfType:geometryType];
        [self testChildHierarchyWithType:geometryType andHierarchy:childHierarchy];
        
    }
    
}

/**
 * Test the child hierarchy recursively
 *
 * @param geometryType
 *            geometry type
 * @param childHierarchy
 *            child hierarchy
 */
-(void) testChildHierarchyWithType: (enum SFGeometryType) geometryType andHierarchy: (NSDictionary *) childHierachy{

    NSArray<NSNumber *> *childTypes = [SFGeometryUtils childTypesOfType:geometryType];
    if(childTypes.count == 0){
        [SFTestUtils assertTrue:childHierachy.count == 0];
    }else{
        [SFTestUtils assertEqualIntWithValue:(int)childTypes.count andValue2:(int)childHierachy.count];
        for(NSNumber *childTypeNumber in childTypes){
            enum SFGeometryType childType = [childTypeNumber intValue];
            NSDictionary *child = [childHierachy objectForKey:childTypeNumber];
            [SFTestUtils assertTrue:child != nil];
            
            [SFTestUtils assertEqualIntWithValue:geometryType andValue2:[SFGeometryUtils parentTypeOfType:childType]];
            [SFTestUtils assertEqualIntWithValue:geometryType andValue2:[[[SFGeometryUtils parentHierarchyOfType:childType] objectAtIndex:0] intValue]];
             
             [self testChildHierarchyWithType:childType andHierarchy:[SFGeometryUtils childHierarchyOfType:childType]];
        }
    }
}

/**
 * Test centroid and degrees centroid
 */
-(void) testCentroid{

    SFPoint *point = [[SFPoint alloc] initWithXValue:15 andYValue:35];

    SFPoint *centroid = [point centroid];

    [SFTestUtils assertEqualDoubleWithValue:15.0 andValue2:[centroid.x doubleValue]];
    [SFTestUtils assertEqualDoubleWithValue:35.0 andValue2:[centroid.y doubleValue]];

    SFPoint *degreesCentroid = [point degreesCentroid];

    [SFTestUtils assertEqualDoubleWithValue:15.0 andValue2:[degreesCentroid.x doubleValue]];
    [SFTestUtils assertEqualDoubleWithValue:35.0 andValue2:[degreesCentroid.y doubleValue]];

    SFLineString *lineString = [[SFLineString alloc] init];
    [lineString addPoint:[[SFPoint alloc] initWithXValue:0 andYValue:5]];
    [lineString addPoint:point];
    
    centroid = [lineString centroid];

    [SFTestUtils assertEqualDoubleWithValue:7.5 andValue2:[centroid.x doubleValue] andDelta:0.000001];
    [SFTestUtils assertEqualDoubleWithValue:20.0 andValue2:[centroid.y doubleValue] andDelta:0.000001];

    degreesCentroid = [lineString degreesCentroid];
    
    [SFTestUtils assertEqualDoubleWithValue:6.764392425440724 andValue2:[degreesCentroid.x doubleValue] andDelta:0.000001];
    [SFTestUtils assertEqualDoubleWithValue:20.157209770845522 andValue2:[degreesCentroid.y doubleValue] andDelta:0.000001];

    [lineString addPoint:[[SFPoint alloc] initWithXValue:2 andYValue:65]];

    centroid = [lineString centroid];
    
    [SFTestUtils assertEqualDoubleWithValue:7.993617921179541 andValue2:[centroid.x doubleValue] andDelta:0.000001];
    [SFTestUtils assertEqualDoubleWithValue:34.808537635386266 andValue2:[centroid.y doubleValue] andDelta:0.000001];

    degreesCentroid = [lineString degreesCentroid];
    
    [SFTestUtils assertEqualDoubleWithValue:5.85897989020252 andValue2:[degreesCentroid.x doubleValue] andDelta:0.000001];
    [SFTestUtils assertEqualDoubleWithValue:35.20025371999032 andValue2:[degreesCentroid.y doubleValue] andDelta:0.000001];

    SFPolygon *polygon = [[SFPolygon alloc] initWithRing:lineString];

    centroid = [polygon centroid];
    
    [SFTestUtils assertEqualDoubleWithValue:5.666666666666667 andValue2:[centroid.x doubleValue]];
    [SFTestUtils assertEqualDoubleWithValue:35.0 andValue2:[centroid.y doubleValue]];

    degreesCentroid = [polygon degreesCentroid];
    
    [SFTestUtils assertEqualDoubleWithValue:5.85897989020252 andValue2:[degreesCentroid.x doubleValue] andDelta:0.000001];
    [SFTestUtils assertEqualDoubleWithValue:35.20025371999032 andValue2:[degreesCentroid.y doubleValue] andDelta:0.000001];

    [lineString addPoint:[[SFPoint alloc] initWithXValue:-20 andYValue:40]];
    [lineString addPoint:[[SFPoint alloc] initWithXValue:0 andYValue:5]];

    centroid = [polygon centroid];
    
    [SFTestUtils assertEqualDoubleWithValue:-1.3554502369668247 andValue2:[centroid.x doubleValue] andDelta:0.000001];
    [SFTestUtils assertEqualDoubleWithValue:36.00315955766193 andValue2:[centroid.y doubleValue] andDelta:0.000001];

    degreesCentroid = [polygon degreesCentroid];
    
    [SFTestUtils assertEqualDoubleWithValue:-0.6891904581641471 andValue2:[degreesCentroid.x doubleValue] andDelta:0.000001];
    [SFTestUtils assertEqualDoubleWithValue:37.02524099014426 andValue2:[degreesCentroid.y doubleValue] andDelta:0.000001];

}

@end
