//
//  SFGeometryUtils.m
//  sf-ios
//
//  Created by Brian Osborn on 4/14/17.
//  Copyright © 2017 NGA. All rights reserved.
//

#import "SFGeometryUtils.h"
#import "SFGeometryCollection.h"
#import "SFCentroidPoint.h"
#import "SFCentroidCurve.h"
#import "SFCentroidSurface.h"
#import "SFMultiLineString.h"
#import "SFMultiPolygon.h"
#import "SFCompoundCurve.h"
#import "SFPolyhedralSurface.h"
#import "SFTIN.h"
#import "SFCircularString.h"
#import "SFTriangle.h"
#import "SFMultiPoint.h"

@implementation SFGeometryUtils

/**
 * Default epsilon for line tolerance
 */
static float DEFAULT_EPSILON = 0.000000000000001;

+(int) dimensionOfGeometry: (SFGeometry *) geometry{
    
    int dimension = -1;
    
    enum SFGeometryType geometryType = geometry.geometryType;
    switch (geometryType) {
        case SF_POINT:
        case SF_MULTIPOINT:
            dimension = 0;
            break;
        case SF_LINESTRING:
        case SF_MULTILINESTRING:
        case SF_CIRCULARSTRING:
        case SF_COMPOUNDCURVE:
            dimension = 1;
            break;
        case SF_POLYGON:
        case SF_CURVEPOLYGON:
        case SF_MULTIPOLYGON:
        case SF_POLYHEDRALSURFACE:
        case SF_TIN:
        case SF_TRIANGLE:
            dimension = 2;
            break;
        case SF_GEOMETRYCOLLECTION:
        case SF_MULTICURVE:
        case SF_MULTISURFACE:
            {
                SFGeometryCollection * geomCollection = (SFGeometryCollection *) geometry;
                NSArray * geometries = geomCollection.geometries;
                for (SFGeometry * subGeometry in geometries) {
                    dimension = MAX(dimension, [self dimensionOfGeometry:subGeometry]);
                }
            }
            break;
        default:
            [NSException raise:@"Geometry Not Supported" format:@"Unsupported Geometry Type: %d", geometryType];
    }
    
    return dimension;
}

+(double) distanceBetweenPoint1: (SFPoint *) point1 andPoint2: (SFPoint *) point2{
    double diffX = [point1.x doubleValue] - [point2.x doubleValue];
    double diffY = [point1.y doubleValue] - [point2.y doubleValue];
    
    double distance = sqrt(diffX * diffX + diffY * diffY);
    
    return distance;
}

+(SFPoint *) centroidOfGeometry: (SFGeometry *) geometry{
    SFPoint * centroid = nil;
    int dimension = [self dimensionOfGeometry:geometry];
    switch (dimension) {
        case 0:
            {
                SFCentroidPoint * point = [[SFCentroidPoint alloc] initWithGeometry: geometry];
                centroid = [point centroid];
            }
            break;
        case 1:
            {
                SFCentroidCurve * curve = [[SFCentroidCurve alloc] initWithGeometry: geometry];
                centroid = [curve centroid];
            }
            break;
        case 2:
            {
                SFCentroidSurface * surface = [[SFCentroidSurface alloc] initWithGeometry: geometry];
                centroid = [surface centroid];
            }
            break;
    }
    return centroid;
}

+(void) minimizeGeometry: (SFGeometry *) geometry withMaxX: (double) maxX{
    
    enum SFGeometryType geometryType = geometry.geometryType;
    switch (geometryType) {
        case SF_LINESTRING:
            [self minimizeLineString:(SFLineString *)geometry withMaxX:maxX];
            break;
        case SF_POLYGON:
            [self minimizePolygon:(SFPolygon *)geometry withMaxX:maxX];
            break;
        case SF_MULTILINESTRING:
            [self minimizeMultiLineString:(SFMultiLineString *)geometry withMaxX:maxX];
            break;
        case SF_MULTIPOLYGON:
            [self minimizeMultiPolygon:(SFMultiPolygon *)geometry withMaxX:maxX];
            break;
        case SF_CIRCULARSTRING:
            [self minimizeLineString:(SFCircularString *)geometry withMaxX:maxX];
            break;
        case SF_COMPOUNDCURVE:
            [self minimizeCompoundCurve:(SFCompoundCurve *)geometry withMaxX:maxX];
            break;
        case SF_CURVEPOLYGON:
            [self minimizeCurvePolygon:(SFCurvePolygon *)geometry withMaxX:maxX];
            break;
        case SF_POLYHEDRALSURFACE:
            [self minimizePolyhedralSurface:(SFPolyhedralSurface *)geometry withMaxX:maxX];
            break;
        case SF_TIN:
            [self minimizePolyhedralSurface:(SFTIN *)geometry withMaxX:maxX];
            break;
        case SF_TRIANGLE:
            [self minimizePolygon:(SFTriangle *)geometry withMaxX:maxX];
            break;
        case SF_GEOMETRYCOLLECTION:
        case SF_MULTICURVE:
        case SF_MULTISURFACE:
        {
            SFGeometryCollection * geomCollection = (SFGeometryCollection *) geometry;
            NSArray * geometries = geomCollection.geometries;
            for (SFGeometry * subGeometry in geometries) {
                [self minimizeGeometry:subGeometry withMaxX:maxX];
            }
        }
            break;
        default:
            break;
            
    }
    
}

+(void) minimizeLineString: (SFLineString *) lineString withMaxX: (double) maxX{
    
    NSMutableArray * points = lineString.points;
    if(points.count > 1){
        SFPoint *point = [points objectAtIndex:0];
        for(int i = 1; i < points.count; i++){
            SFPoint *nextPoint = [points objectAtIndex:i];
            if([point.x doubleValue] < [nextPoint.x doubleValue]){
                if([nextPoint.x doubleValue] - [point.x doubleValue] > [point.x doubleValue] - [nextPoint.x doubleValue] + (maxX * 2.0)){
                    [nextPoint setX:[nextPoint.x decimalNumberBySubtracting:[[NSDecimalNumber alloc] initWithDouble: maxX * 2.0]]];
                }
            }else if([point.x doubleValue] > [nextPoint.x doubleValue]){
                if([point.x doubleValue] - [nextPoint.x doubleValue] > [nextPoint.x doubleValue] - [point.x doubleValue] + (maxX * 2.0)){
                    [nextPoint setX:[nextPoint.x decimalNumberByAdding:[[NSDecimalNumber alloc] initWithDouble: maxX * 2.0]]];
                }
            }
        }
    }
}

+(void) minimizeMultiLineString: (SFMultiLineString *) multiLineString withMaxX: (double) maxX{
    
    NSArray * lineStrings = [multiLineString lineStrings];
    for(SFLineString * lineString in lineStrings){
        [self minimizeLineString:lineString withMaxX:maxX];
    }
}

+(void) minimizePolygon: (SFPolygon *) polygon withMaxX: (double) maxX{
    
    for(SFLineString * ring in polygon.rings){
        [self minimizeLineString:ring withMaxX:maxX];
    }
}

+(void) minimizeMultiPolygon: (SFMultiPolygon *) multiPolygon withMaxX: (double) maxX{
    
    NSArray * polygons = [multiPolygon polygons];
    for(SFPolygon * polygon in polygons){
        [self minimizePolygon:polygon withMaxX:maxX];
    }
}

+(void) minimizeCompoundCurve: (SFCompoundCurve *) compoundCurve withMaxX: (double) maxX{
    
    for(SFLineString * lineString in compoundCurve.lineStrings){
        [self minimizeLineString:lineString withMaxX:maxX];
    }
}

+(void) minimizeCurvePolygon: (SFCurvePolygon *) curvePolygon withMaxX: (double) maxX{
    
    for(SFCurve * ring in curvePolygon.rings){
        [self minimizeGeometry:ring withMaxX:maxX];
    }
}

+(void) minimizePolyhedralSurface: (SFPolyhedralSurface *) polyhedralSurface withMaxX: (double) maxX{
    
    for(SFPolygon * polygon in polyhedralSurface.polygons){
        [self minimizePolygon:polygon withMaxX:maxX];
    }
}

+(void) normalizeGeometry: (SFGeometry *) geometry withMaxX: (double) maxX{
    
    enum SFGeometryType geometryType = geometry.geometryType;
    switch (geometryType) {
        case SF_POINT:
            [self normalizePoint:(SFPoint *)geometry withMaxX:maxX];
            break;
        case SF_LINESTRING:
            [self normalizeLineString:(SFLineString *)geometry withMaxX:maxX];
            break;
        case SF_POLYGON:
            [self normalizePolygon:(SFPolygon *)geometry withMaxX:maxX];
            break;
        case SF_MULTIPOINT:
            [self normalizeMultiPoint:(SFMultiPoint *)geometry withMaxX:maxX];
            break;
        case SF_MULTILINESTRING:
            [self normalizeMultiLineString:(SFMultiLineString *)geometry withMaxX:maxX];
            break;
        case SF_MULTIPOLYGON:
            [self normalizeMultiPolygon:(SFMultiPolygon *)geometry withMaxX:maxX];
            break;
        case SF_CIRCULARSTRING:
            [self normalizeLineString:(SFCircularString *)geometry withMaxX:maxX];
            break;
        case SF_COMPOUNDCURVE:
            [self normalizeCompoundCurve:(SFCompoundCurve *)geometry withMaxX:maxX];
            break;
        case SF_CURVEPOLYGON:
            [self normalizeCurvePolygon:(SFCurvePolygon *)geometry withMaxX:maxX];
            break;
        case SF_POLYHEDRALSURFACE:
            [self normalizePolyhedralSurface:(SFPolyhedralSurface *)geometry withMaxX:maxX];
            break;
        case SF_TIN:
            [self normalizePolyhedralSurface:(SFTIN *)geometry withMaxX:maxX];
            break;
        case SF_TRIANGLE:
            [self normalizePolygon:(SFTriangle *)geometry withMaxX:maxX];
            break;
        case SF_GEOMETRYCOLLECTION:
        case SF_MULTICURVE:
        case SF_MULTISURFACE:
        {
            SFGeometryCollection * geomCollection = (SFGeometryCollection *) geometry;
            NSArray * geometries = geomCollection.geometries;
            for (SFGeometry * subGeometry in geometries) {
                [self normalizeGeometry:subGeometry withMaxX:maxX];
            }
        }
            break;
        default:
            break;
            
    }
    
}

+(void) normalizePoint: (SFPoint *) point withMaxX: (double) maxX{
    
    if([point.x doubleValue] < -maxX){
        [point setX:[point.x decimalNumberByAdding:[[NSDecimalNumber alloc] initWithDouble: maxX * 2.0]]];
    }else if([point.x doubleValue] > maxX){
        [point setX:[point.x decimalNumberBySubtracting:[[NSDecimalNumber alloc] initWithDouble: maxX * 2.0]]];
    }
}

+(void) normalizeMultiPoint: (SFMultiPoint *) multiPoint withMaxX: (double) maxX{
    
    NSArray * points = [multiPoint points];
    for(SFPoint * point in points){
        [self normalizePoint:point withMaxX:maxX];
    }
}

+(void) normalizeLineString: (SFLineString *) lineString withMaxX: (double) maxX{
    
    for(SFPoint * point in lineString.points){
        [self normalizePoint:point withMaxX:maxX];
    }
}

+(void) normalizeMultiLineString: (SFMultiLineString *) multiLineString withMaxX: (double) maxX{
    
    NSArray * lineStrings = [multiLineString lineStrings];
    for(SFLineString * lineString in lineStrings){
        [self normalizeLineString:lineString withMaxX:maxX];
    }
}

+(void) normalizePolygon: (SFPolygon *) polygon withMaxX: (double) maxX{
    
    for(SFLineString * ring in polygon.rings){
        [self normalizeLineString:ring withMaxX:maxX];
    }
}

+(void) normalizeMultiPolygon: (SFMultiPolygon *) multiPolygon withMaxX: (double) maxX{
    
    NSArray * polygons = [multiPolygon polygons];
    for(SFPolygon * polygon in polygons){
        [self normalizePolygon:polygon withMaxX:maxX];
    }
}

+(void) normalizeCompoundCurve: (SFCompoundCurve *) compoundCurve withMaxX: (double) maxX{
    
    for(SFLineString * lineString in compoundCurve.lineStrings){
        [self normalizeLineString:lineString withMaxX:maxX];
    }
}

+(void) normalizeCurvePolygon: (SFCurvePolygon *) curvePolygon withMaxX: (double) maxX{
    
    for(SFCurve * ring in curvePolygon.rings){
        [self normalizeGeometry:ring withMaxX:maxX];
    }
}

+(void) normalizePolyhedralSurface: (SFPolyhedralSurface *) polyhedralSurface withMaxX: (double) maxX{
    
    for(SFPolygon * polygon in polyhedralSurface.polygons){
        [self normalizePolygon:polygon withMaxX:maxX];
    }
}

+ (NSArray<SFPoint *> *) simplifyPoints: (NSArray<SFPoint *> *) points withTolerance : (double) tolerance{
    return [self simplifyPoints:points withTolerance:tolerance andStartIndex:0 andEndIndex:(int)[points count]-1];
}

+(NSArray<SFPoint *> *) simplifyPoints: (NSArray<SFPoint *> *) points withTolerance: (double) tolerance andStartIndex: (int) startIndex andEndIndex: (int) endIndex {
    
    NSArray *result = nil;
    
    double dmax = 0.0;
    int index = 0;
    
    SFPoint *startPoint = [points objectAtIndex:startIndex];
    SFPoint *endPoint = [points objectAtIndex:endIndex];
    
    for (int i = startIndex + 1; i < endIndex; i++) {
        SFPoint *point = [points objectAtIndex:i];
        
        double d = [SFGeometryUtils perpendicularDistanceBetweenPoint:point lineStart:startPoint lineEnd:endPoint];
        
        if (d > dmax) {
            index = i;
            dmax = d;
        }
    }
    
    if (dmax > tolerance) {
        
        NSArray * recResults1 = [self simplifyPoints:points withTolerance:tolerance andStartIndex:startIndex andEndIndex:index];
        NSArray * recResults2 = [self simplifyPoints:points withTolerance:tolerance andStartIndex:index andEndIndex:endIndex];
        
        result = [recResults1 subarrayWithRange:NSMakeRange(0, recResults1.count - 1)];
        result = [result arrayByAddingObjectsFromArray:recResults2];
        
    }else{
        result = [[NSArray alloc] initWithObjects:startPoint, endPoint, nil];
    }
    
    return result;
}

+(double) perpendicularDistanceBetweenPoint: (SFPoint *) point lineStart: (SFPoint *) lineStart lineEnd: (SFPoint *) lineEnd {
    
    double x = [point.x doubleValue];
    double y = [point.y doubleValue];
    double startX = [lineStart.x doubleValue];
    double startY = [lineStart.y doubleValue];
    double endX = [lineEnd.x doubleValue];
    double endY = [lineEnd.y doubleValue];
    
    double vX = endX - startX;
    double vY = endY - startY;
    double wX = x - startX;
    double wY = y - startY;
    double c1 = wX * vX + wY * vY;
    double c2 = vX * vX + vY * vY;
    
    double x2;
    double y2;
    if(c1 <=0){
        x2 = startX;
        y2 = startY;
    }else if(c2 <= c1){
        x2 = endX;
        y2 = endY;
    }else{
        double b = c1 / c2;
        x2 = startX + b * vX;
        y2 = startY + b * vY;
    }
    
    double distance = sqrt(pow(x2 - x, 2) + pow(y2 - y, 2));
    
    return distance;
}

+(BOOL) point: (SFPoint *) point inPolygon: (SFPolygon *) polygon{
    return [self point:point inPolygon:polygon withEpsilon:DEFAULT_EPSILON];
}

+(BOOL) point: (SFPoint *) point inPolygon: (SFPolygon *) polygon withEpsilon: (double) epsilon{
    
    BOOL contains = NO;
    NSArray *rings = polygon.rings;
    if(rings.count > 0){
        contains = [self point:point inPolygonRing:[rings objectAtIndex:0] withEpsilon:epsilon];
        if(contains){
            // Check the holes
            for(int i = 1; i < rings.count; i++){
                if([self point:point inPolygonRing:[rings objectAtIndex:i] withEpsilon:epsilon]){
                    contains = NO;
                    break;
                }
            }
        }
    }
    
    return contains;
}

+(BOOL) point: (SFPoint *) point inPolygonRing: (SFLineString *) ring{
    return [self point:point inPolygonRing:ring withEpsilon:DEFAULT_EPSILON];
}

+(BOOL) point: (SFPoint *) point inPolygonRing: (SFLineString *) ring withEpsilon: (double) epsilon{
    return [self point:point inPolygonPoints:ring.points withEpsilon:epsilon];
}

+(BOOL) point: (SFPoint *) point inPolygonPoints: (NSArray<SFPoint *> *) points{
    return [self point:point inPolygonPoints:points withEpsilon:DEFAULT_EPSILON];
}

+(BOOL) point: (SFPoint *) point inPolygonPoints: (NSArray<SFPoint *> *) points withEpsilon: (double) epsilon{
    
    BOOL contains = NO;
    
    int i = 0;
    int j = (int)points.count - 1;
    if([self closedPolygonPoints:points]){
        j = i++;
    }
    
    for(; i < points.count; j = i++){
        SFPoint *point1 = [points objectAtIndex:i];
        SFPoint *point2 = [points objectAtIndex:j];
        
        double px = [point.x doubleValue];
        double py = [point.y doubleValue];
        
        double p1x = [point1.x doubleValue];
        double p1y = [point1.y doubleValue];
        
        // Shortcut check if polygon contains the point within tolerance
        if(ABS(p1x - px) <= epsilon && ABS(p1y - py) <= epsilon){
            contains = YES;
            break;
        }
        
        double p2x = [point2.x doubleValue];
        double p2y = [point2.y doubleValue];
        
        if(((p1y > py) != (p2y > py))
           && (px < (p2x - p1x) * (py - p1y) / (p2y - p1y) + p1x)){
            contains = !contains;
        }
    }
    
    if(!contains){
        // Check the polygon edges
        contains = [self point:point onPolygonPointsEdge:points];
    }
    
    return contains;
}

+(BOOL) point: (SFPoint *) point onPolygonEdge: (SFPolygon *) polygon{
    return [self point:point onPolygonEdge:polygon withEpsilon:DEFAULT_EPSILON];
}

+(BOOL) point: (SFPoint *) point onPolygonEdge: (SFPolygon *) polygon withEpsilon: (double) epsilon{
    return [polygon numRings] > 0 && [self point:point onPolygonRingEdge:[polygon ringAtIndex:0] withEpsilon:epsilon];
}

+(BOOL) point: (SFPoint *) point onPolygonRingEdge: (SFLineString *) ring{
    return [self point:point onPolygonRingEdge:ring withEpsilon:DEFAULT_EPSILON];
}

+(BOOL) point: (SFPoint *) point onPolygonRingEdge: (SFLineString *) ring withEpsilon: (double) epsilon{
    return [self point:point onPolygonPointsEdge:ring.points withEpsilon:epsilon];
}

+(BOOL) point: (SFPoint *) point onPolygonPointsEdge: (NSArray<SFPoint *> *) points{
    return [self point:point onPolygonPointsEdge:points withEpsilon:DEFAULT_EPSILON];
}

+(BOOL) point: (SFPoint *) point onPolygonPointsEdge: (NSArray<SFPoint *> *) points withEpsilon: (double) epsilon{
    return [self point:point onPath:points withEpsilon:epsilon andCircular:![self closedPolygonPoints:points]];
}

+(BOOL) closedPolygon: (SFPolygon *) polygon{
    return [polygon numRings] > 0 && [self closedPolygonRing:[polygon ringAtIndex:0]];
}

+(BOOL) closedPolygonRing: (SFLineString *) ring{
    return [self closedPolygonPoints:ring.points];
}

+(BOOL) closedPolygonPoints: (NSArray<SFPoint *> *) points{
    BOOL closed = NO;
    if(points.count > 0){
        SFPoint *first = [points objectAtIndex:0];
        SFPoint *last = [points objectAtIndex:points.count - 1];
        closed = [first.x compare:last.x] == NSOrderedSame && [first.y compare:last.y] == NSOrderedSame;
    }
    return closed;
}

+(BOOL) point: (SFPoint *) point onLine: (SFLineString *) line{
    return [self point:point onLine:line withEpsilon:DEFAULT_EPSILON];
}

+(BOOL) point: (SFPoint *) point onLine: (SFLineString *) line withEpsilon: (double) epsilon{
    return [self point:point onLinePoints:line.points withEpsilon:epsilon];
}

+(BOOL) point: (SFPoint *) point onLinePoints: (NSArray<SFPoint *> *) points{
    return [self point:point onLinePoints:points withEpsilon:DEFAULT_EPSILON];
}

+(BOOL) point: (SFPoint *) point onLinePoints: (NSArray<SFPoint *> *) points withEpsilon: (double) epsilon{
    return [self point:point onPath:points withEpsilon:epsilon andCircular:NO];
}

+(BOOL) point: (SFPoint *) point onPathPoint1: (SFPoint *) point1 andPoint2: (SFPoint *) point2{
    return [self point:point onPathPoint1:point1 andPoint2:point2 withEpsilon:DEFAULT_EPSILON];
}

+(BOOL) point: (SFPoint *) point onPathPoint1: (SFPoint *) point1 andPoint2: (SFPoint *) point2 withEpsilon: (double) epsilon{
    
    BOOL contains = NO;
    
    double px = [point.x doubleValue];
    double py = [point.y doubleValue];
    double p1x = [point1.x doubleValue];
    double p1y = [point1.y doubleValue];
    double p2x = [point2.x doubleValue];
    double p2y = [point2.y doubleValue];
    
    double x21 = p2x - p1x;
    double y21 = p2y - p1y;
    double xP1 = px - p1x;
    double yP1 = py - p1y;
    
    double dp = xP1 * x21 + yP1 * y21;
    if(dp >= 0.0){
        
        double lengthP1 = xP1 * xP1 + yP1 * yP1;
        double length21 = x21 * x21 + y21 * y21;
        
        if(lengthP1 <= length21){
            contains = ABS(dp * dp - lengthP1 * length21) <= epsilon;
        }
    }
    
    return contains;
}

+(BOOL) point: (SFPoint *) point onPath: (NSArray<SFPoint *> *) points withEpsilon: (double) epsilon andCircular: (BOOL) circular{
    
    BOOL onPath = NO;
    
    int i = 0;
    int j = (int)points.count - 1;
    if(!circular){
        j = i++;
    }
    
    for(; i < points.count; j= i++){
        SFPoint *point1 = [points objectAtIndex:i];
        SFPoint *point2 = [points objectAtIndex:j];
        if([self point:point onPathPoint1:point1 andPoint2:point2 withEpsilon:epsilon]){
            onPath = YES;
            break;
        }
    }
    
    return onPath;
}

+(BOOL) hasZ: (NSArray<SFGeometry *> *) geometries{
    BOOL hasZ = NO;
    for (SFGeometry *geometry in geometries) {
        if ([geometry hasZ]) {
            hasZ = YES;
            break;
        }
    }
    return hasZ;
}

+(BOOL) hasM: (NSArray<SFGeometry *> *) geometries{
    BOOL hasM = NO;
    for (SFGeometry *geometry in geometries) {
        if ([geometry hasM]) {
            hasM = YES;
            break;
        }
    }
    return hasM;
}

+(NSArray<NSNumber *> *) parentHierarchyOfType: (enum SFGeometryType) geometryType{
    
    NSMutableArray<NSNumber *> *hierarchy = [[NSMutableArray alloc] init];
    
    enum SFGeometryType parentType = [self parentTypeOfType:geometryType];
    while(parentType != SF_NONE && parentType >= 0){
        [hierarchy addObject:[NSNumber numberWithInt:parentType]];
        parentType = [self parentTypeOfType:parentType];
    }
    
    return hierarchy;
}

+(enum SFGeometryType) parentTypeOfType: (enum SFGeometryType) geometryType{
    
    enum SFGeometryType parentType = SF_NONE;
    
    switch(geometryType){
            
        case SF_GEOMETRY:
            break;
        case SF_POINT:
            parentType = SF_GEOMETRY;
            break;
        case SF_LINESTRING:
            parentType = SF_CURVE;
            break;
        case SF_POLYGON:
            parentType = SF_CURVEPOLYGON;
            break;
        case SF_MULTIPOINT:
            parentType = SF_GEOMETRYCOLLECTION;
            break;
        case SF_MULTILINESTRING:
            parentType = SF_MULTICURVE;
            break;
        case SF_MULTIPOLYGON:
            parentType = SF_MULTISURFACE;
            break;
        case SF_GEOMETRYCOLLECTION:
            parentType = SF_GEOMETRY;
            break;
        case SF_CIRCULARSTRING:
            parentType = SF_LINESTRING;
            break;
        case SF_COMPOUNDCURVE:
            parentType = SF_CURVE;
            break;
        case SF_CURVEPOLYGON:
            parentType = SF_SURFACE;
            break;
        case SF_MULTICURVE:
            parentType = SF_GEOMETRYCOLLECTION;
            break;
        case SF_MULTISURFACE:
            parentType = SF_GEOMETRYCOLLECTION;
            break;
        case SF_CURVE:
            parentType = SF_GEOMETRY;
            break;
        case SF_SURFACE:
            parentType = SF_GEOMETRY;
            break;
        case SF_POLYHEDRALSURFACE:
            parentType = SF_SURFACE;
            break;
        case SF_TIN:
            parentType = SF_POLYHEDRALSURFACE;
            break;
        case SF_TRIANGLE:
            parentType = SF_POLYGON;
            break;
        default:
            [NSException raise:@"Geometry Type Not Supported" format:@"Geomery Type is not supported: %@", [SFGeometryTypes name:geometryType]];
    }
    
    return parentType;
}


+(NSDictionary<NSNumber *, NSDictionary *> *) childHierarchyOfType: (enum SFGeometryType) geometryType{
    
    NSMutableDictionary<NSNumber *, NSDictionary *> *hierarchy = [[NSMutableDictionary alloc] init];
    
    NSArray<NSNumber *> *childTypes = [self childTypesOfType:geometryType];
    
    if(childTypes.count > 0){
        
        for(NSNumber *childTypeNumber in childTypes){
            enum SFGeometryType childType = [childTypeNumber intValue];
            [hierarchy setObject:[self childHierarchyOfType:childType] forKey:childTypeNumber];
        }
    }
    
    return hierarchy;
}

+(NSArray<NSNumber *> *) childTypesOfType: (enum SFGeometryType) geometryType{
    
    NSMutableArray<NSNumber *> *childTypes = [[NSMutableArray alloc] init];
    
    switch (geometryType) {
            
        case SF_GEOMETRY:
            [childTypes addObject:[NSNumber numberWithInt:SF_POINT]];
            [childTypes addObject:[NSNumber numberWithInt:SF_GEOMETRYCOLLECTION]];
            [childTypes addObject:[NSNumber numberWithInt:SF_CURVE]];
            [childTypes addObject:[NSNumber numberWithInt:SF_SURFACE]];
            break;
        case SF_POINT:
            break;
        case SF_LINESTRING:
            [childTypes addObject:[NSNumber numberWithInt:SF_CIRCULARSTRING]];
            break;
        case SF_POLYGON:
            [childTypes addObject:[NSNumber numberWithInt:SF_TRIANGLE]];
            break;
        case SF_MULTIPOINT:
            break;
        case SF_MULTILINESTRING:
            break;
        case SF_MULTIPOLYGON:
            break;
        case SF_GEOMETRYCOLLECTION:
            [childTypes addObject:[NSNumber numberWithInt:SF_MULTIPOINT]];
            [childTypes addObject:[NSNumber numberWithInt:SF_MULTICURVE]];
            [childTypes addObject:[NSNumber numberWithInt:SF_MULTISURFACE]];
            break;
        case SF_CIRCULARSTRING:
            break;
        case SF_COMPOUNDCURVE:
            break;
        case SF_CURVEPOLYGON:
            [childTypes addObject:[NSNumber numberWithInt:SF_POLYGON]];
            break;
        case SF_MULTICURVE:
            [childTypes addObject:[NSNumber numberWithInt:SF_MULTILINESTRING]];
            break;
        case SF_MULTISURFACE:
            [childTypes addObject:[NSNumber numberWithInt:SF_MULTIPOLYGON]];
            break;
        case SF_CURVE:
            [childTypes addObject:[NSNumber numberWithInt:SF_LINESTRING]];
            [childTypes addObject:[NSNumber numberWithInt:SF_COMPOUNDCURVE]];
            break;
        case SF_SURFACE:
            [childTypes addObject:[NSNumber numberWithInt:SF_CURVEPOLYGON]];
            [childTypes addObject:[NSNumber numberWithInt:SF_POLYHEDRALSURFACE]];
            break;
        case SF_POLYHEDRALSURFACE:
            [childTypes addObject:[NSNumber numberWithInt:SF_TIN]];
            break;
        case SF_TIN:
            break;
        case SF_TRIANGLE:
            break;
        default:
            [NSException raise:@"Geometry Type Not Supported" format:@"Geomery Type is not supported: %@", [SFGeometryTypes name:geometryType]];
    }
    
    return childTypes;
}

+(NSData *) encodeGeometry: (SFGeometry *) geometry{
    return [NSKeyedArchiver archivedDataWithRootObject:geometry];
}

+(SFGeometry *) decodeGeometry: (NSData *) data{
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

@end
