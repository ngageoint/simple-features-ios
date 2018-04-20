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
        SFPoint * point = [SFGeometryTestUtils createPointWithHasZ:[SFTestUtils coinFlip] andHasM:[SFTestUtils coinFlip]];
        [SFTestUtils assertEqualIntWithValue:0 andValue2:[SFGeometryUtils dimensionOfGeometry:point]];
        [self geometryCentroidTesterWithGeometry:point];
    }
    
}

-(void) testLineStringCentroid {
    
    for (int i = 0; i < GEOMETRIES_PER_TEST; i++) {
        // Create and test a line string
        SFLineString * lineString = [SFGeometryTestUtils createLineStringWithHasZ:[SFTestUtils coinFlip] andHasM:[SFTestUtils coinFlip]];
        [SFTestUtils assertEqualIntWithValue:1 andValue2:[SFGeometryUtils dimensionOfGeometry:lineString]];
        [self geometryCentroidTesterWithGeometry:lineString];
    }
    
}

-(void) testPolygonCentroid {
    
    for (int i = 0; i < GEOMETRIES_PER_TEST; i++) {
        // Create and test a polygon
        SFPolygon * polygon = [self createPolygon];
        [SFTestUtils assertEqualIntWithValue:2 andValue2:[SFGeometryUtils dimensionOfGeometry:polygon]];
        [self geometryCentroidTesterWithGeometry:polygon];
    }
    
}

-(void) testMultiPointCentroid {
    
    for (int i = 0; i < GEOMETRIES_PER_TEST; i++) {
        // Create and test a multi point
        SFMultiPoint * multiPoint = [SFGeometryTestUtils createMultiPointWithHasZ:[SFTestUtils coinFlip] andHasM:[SFTestUtils coinFlip]];
        [SFTestUtils assertEqualIntWithValue:0 andValue2:[SFGeometryUtils dimensionOfGeometry:multiPoint]];
        [self geometryCentroidTesterWithGeometry:multiPoint];
    }
    
}

-(void) testMultiLineStringCentroid {
    
    for (int i = 0; i < GEOMETRIES_PER_TEST; i++) {
        // Create and test a multi line string
        SFMultiLineString * multiLineString = [SFGeometryTestUtils createMultiLineStringWithHasZ:[SFTestUtils coinFlip] andHasM:[SFTestUtils coinFlip]];
        [SFTestUtils assertEqualIntWithValue:1 andValue2:[SFGeometryUtils dimensionOfGeometry:multiLineString]];
        [self geometryCentroidTesterWithGeometry:multiLineString];
    }
    
}

-(void) testMultiPolygonCentroid {
    
    for (int i = 0; i < GEOMETRIES_PER_TEST; i++) {
        // Create and test a multi polygon
        SFMultiPolygon * multiPolygon = [self createMultiPolygon];
        [SFTestUtils assertEqualIntWithValue:2 andValue2:[SFGeometryUtils dimensionOfGeometry:multiPolygon]];
        [self geometryCentroidTesterWithGeometry:multiPolygon];
    }
    
}

-(void) testGeometryCollectionCentroid {
    
    for (int i = 0; i < GEOMETRIES_PER_TEST; i++) {
        // Create and test a geometry collection
        SFGeometryCollection * geometryCollection = [self createGeometryCollectionWithHasZ:[SFTestUtils coinFlip] andHasM:[SFTestUtils coinFlip]];
        [self geometryCentroidTesterWithGeometry:geometryCollection];
    }
    
}

-(void) testPolygonCentroidWithAndWithoutHole {
    
    SFPolygon * polygon = [[SFPolygon alloc] init];
    SFLineString * lineString = [[SFLineString alloc] init];
    [lineString addPoint:[[SFPoint alloc] initWithXValue:-90 andYValue:45]];
    [lineString addPoint:[[SFPoint alloc] initWithXValue:-90 andYValue:-45]];
    [lineString addPoint:[[SFPoint alloc] initWithXValue:90 andYValue:-45]];
    [lineString addPoint:[[SFPoint alloc] initWithXValue:90 andYValue:45]];
    [polygon addRing:lineString];
    
    [SFTestUtils assertEqualIntWithValue:2 andValue2:[SFGeometryUtils dimensionOfGeometry:polygon]];
    SFPoint * centroid = [self geometryCentroidTesterWithGeometry:polygon];
    
    [SFTestUtils assertEqualDoubleWithValue:0.0 andValue2:[centroid.x doubleValue]];
    [SFTestUtils assertEqualDoubleWithValue:0.0 andValue2:[centroid.y doubleValue]];
    
    SFLineString * holeLineString = [[SFLineString alloc] init];
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
    
    SFPoint * point = [SFGeometryUtils centroidOfGeometry:geometry];
    
    SFGeometryEnvelope * envelope = [SFGeometryEnvelopeBuilder buildEnvelopeWithGeometry:geometry];
    
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
    
    return point;
}

-(SFPolygon *) createPolygon{
    
    SFPolygon * polygon = [[SFPolygon alloc] init];
    SFLineString * lineString = [[SFLineString alloc] init];
    [lineString addPoint:[self createPointWithMinX:-180.0 andMinY:45.0 andXRange:90.0 andYRange:45.0]];
    [lineString addPoint:[self createPointWithMinX:-180.0 andMinY:-90.0 andXRange:90.0 andYRange:45.0]];
    [lineString addPoint:[self createPointWithMinX:90.0 andMinY:-90.0 andXRange:90.0 andYRange:45.0]];
    [lineString addPoint:[self createPointWithMinX:90.0 andMinY:45.0 andXRange:90.0 andYRange:45.0]];
    [polygon addRing:lineString];
    
    SFLineString * holeLineString = [[SFLineString alloc] init];
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
    
    SFPoint * point = [[SFPoint alloc] initWithXValue:x andYValue:y];
    
    return point;
}

-(SFMultiPolygon *) createMultiPolygon{
    
    SFMultiPolygon * multiPolygon = [[SFMultiPolygon alloc] init];
    
    int num = 1 + ((int) ([SFTestUtils randomDouble] * 5));
    
    for (int i = 0; i < num; i++) {
        [multiPolygon addPolygon:[self createPolygon]];
    }
    
    return multiPolygon;
}

-(SFGeometryCollection *) createGeometryCollectionWithHasZ: (BOOL) hasZ andHasM: (BOOL) hasM{

    SFGeometryCollection * geometryCollection = [[SFGeometryCollection alloc] initWithHasZ:hasZ andHasM:hasM];
    
    int num = 1 + ((int) ([SFTestUtils randomDouble] * 5));
    
    for (int i = 0; i < num; i++) {
        
        SFGeometry * geometry = nil;
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
    
    SFPolygon * polygon = [[SFPolygon alloc] init];
    SFLineString * ring = [[SFLineString alloc] init];
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
    
    SFPolygon * polygon2 = [polygon mutableCopy];
    [SFGeometryUtils minimizeGeometry:polygon2 withMaxX:180.0];
    
    SFPolygon * polygon3 = [polygon2 mutableCopy];
    [SFGeometryUtils normalizeGeometry:polygon3 withMaxX:180.0];
    
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
        [SFTestUtils assertEqualDoubleWithValue:[point.x doubleValue] andValue2:[point3.x doubleValue]];
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
    
    double halfWorldWidth = 20037508.342789244;
    
    NSMutableArray<SFPoint *> *points = [[NSMutableArray alloc] init];
    NSMutableArray<NSDecimalNumber *> *distances = [[NSMutableArray alloc] init];
    
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
    
    NSMutableArray<SFPoint *> *points = [[NSMutableArray alloc] init];
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
    
    NSMutableArray<SFPoint *> *points = [[NSMutableArray alloc] init];
    [points addObject:[[SFPoint alloc] initWithXValue:0.1 andYValue:0.2]];
    [points addObject:[[SFPoint alloc] initWithXValue:5.3 andYValue:0.4]];
    [points addObject:[[SFPoint alloc] initWithXValue:5.5 andYValue:5.6]];
    
    [SFTestUtils assertFalse:[SFGeometryUtils closedPolygonPoints:points]];
    
    SFPoint *firstPoint = [points objectAtIndex:0];
    [points addObject:[[SFPoint alloc] initWithX:firstPoint.x andY:firstPoint.y]];
    
    [SFTestUtils assertTrue:[SFGeometryUtils closedPolygonPoints:points]];
}

-(void) testPointOnLine{
    
    NSMutableArray<SFPoint *> *points = [[NSMutableArray alloc] init];
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

@end
