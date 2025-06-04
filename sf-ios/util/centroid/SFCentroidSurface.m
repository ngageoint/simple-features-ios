//
//  SFCentroidSurface.m
//  sf-ios
//
//  Created by Brian Osborn on 4/14/17.
//  Copyright © 2017 NGA. All rights reserved.
//

#import <SimpleFeatures/SFCentroidSurface.h>
#import <SimpleFeatures/SFMultiPolygon.h>
#import <SimpleFeatures/SFGeometryUtils.h>

@interface SFCentroidSurface()

/**
 * Base point for triangles
 */
@property (nonatomic, strong) SFPoint *base;

/**
 * Area sum
 */
@property (nonatomic) double area;

/**
 * Sum of surface point locations
 */
@property (nonatomic, strong) SFPoint *sum;

@end

@implementation SFCentroidSurface

-(instancetype) init{
    return [self initWithGeometry:nil];
}

-(instancetype) initWithGeometry: (SFGeometry *) geometry{
    self = [super init];
    if(self != nil){
        self.area = 0;
        self.sum = [SFPoint point];
        [self addGeometry:geometry];
    }
    return self;
}

-(void) addGeometry: (SFGeometry *) geometry{
    SFGeometryType geometryType = geometry.geometryType;
    switch (geometryType) {
        case SF_POLYGON:
        case SF_TRIANGLE:
            [self addPolygon:(SFPolygon *) geometry];
            break;
        case SF_MULTIPOLYGON:
            [self addPolygons:[((SFMultiPolygon *)geometry) polygons]];
            break;
        case SF_CURVEPOLYGON:
            [self addCurvePolygon:(SFCurvePolygon *) geometry];
            break;
        case SF_POLYHEDRALSURFACE:
        case SF_TIN:
            [self addPolygons:((SFPolyhedralSurface *)geometry).polygons];
            break;
        case SF_GEOMETRYCOLLECTION:
        case SF_MULTICURVE:
        case SF_MULTISURFACE:
            {
                SFGeometryCollection *geomCollection = (SFGeometryCollection *) geometry;
                for (SFGeometry *subGeometry in geomCollection.geometries) {
                    [self addGeometry:subGeometry];
                }
            
            }
            break;
        case SF_POINT:
        case SF_MULTIPOINT:
        case SF_LINESTRING:
        case SF_CIRCULARSTRING:
        case SF_MULTILINESTRING:
        case SF_COMPOUNDCURVE:
            // Doesn't contribute to surface dimension
            break;
        default:
            [NSException raise:@"Geometry Not Supported" format:@"Unsupported Geometry Type: %ld", geometryType];
    }
}

/**
 * Add polygons to the centroid total
 *
 * @param polygons
 *            polygons
 */
-(void) addPolygons: (NSArray *) polygons{
    for(SFPolygon *polygon in polygons){
        [self addPolygon:polygon];
    }
}

/**
 * Add a polygon to the centroid total
 *
 * @param polygon
 *            polygon
 */
-(void) addPolygon: (SFPolygon *) polygon{
    NSArray *rings = polygon.rings;
    [self addLineString:[rings objectAtIndex:0]];
    for(int i = 1; i < rings.count; i++){
        [self addHoleLineString: [rings objectAtIndex: i]];
    }
}

/**
 * Add a curve polygon to the centroid total
 *
 * @param curvePolygon
 *            curve polygon
 */
-(void) addCurvePolygon: (SFCurvePolygon *) curvePolygon{
    
    NSArray *rings = curvePolygon.rings;
    
    SFCurve *curve = [rings objectAtIndex:0];
    SFGeometryType curveGeometryType = curve.geometryType;
    switch(curveGeometryType){
        case SF_COMPOUNDCURVE:
            {
                SFCompoundCurve *compoundCurve = (SFCompoundCurve *) curve;
                for(SFLineString *lineString in compoundCurve.lineStrings){
                    [self addLineString:lineString];
                }
                break;
            }
        case SF_LINESTRING:
        case SF_CIRCULARSTRING:
            [self addLineString:(SFLineString *)curve];
            break;
        default:
            [NSException raise:@"Curve Type" format:@"Unexpected Curve Type: %ld", curveGeometryType];
    }
    
    for(int i = 1; i < rings.count; i++){
        SFCurve *curveHole = [rings objectAtIndex:i];
        SFGeometryType curveHoleGeometryType = curveHole.geometryType;
        switch(curveHoleGeometryType){
            case SF_COMPOUNDCURVE:
                {
                    SFCompoundCurve *compoundCurveHole = (SFCompoundCurve *) curveHole;
                    for(SFLineString *lineStringHole in compoundCurveHole.lineStrings){
                        [self addHoleLineString:lineStringHole];
                    }
                    break;
                }
            case SF_LINESTRING:
            case SF_CIRCULARSTRING:
                [self addHoleLineString:(SFLineString *)curveHole];
                break;
            default:
                [NSException raise:@"Curve Type" format:@"Unexpected Curve Type: %ld", curveHoleGeometryType];
        }
    }
}

/**
 * Add a line string to the centroid total
 *
 * @param lineString
 *            line string
 */
-(void) addLineString: (SFLineString *) lineString{
    [self addWithPositive:true andLineString:lineString];
}

/**
 * Add a line string hole to subtract from the centroid total
 *
 * @param lineString
 *            line string
 */
-(void) addHoleLineString: (SFLineString *) lineString{
    [self addWithPositive:false andLineString:lineString];
}

/**
 * Add or subtract a line string to or from the centroid total
 *
 * @param positive
 *            true if an addition, false if a subtraction
 * @param lineString
 *            line string
 */
-(void) addWithPositive: (BOOL) positive andLineString: (SFLineString *) lineString{
    NSArray *points = lineString.points;
    SFPoint *firstPoint = [points objectAtIndex:0];
    if(self.base == nil){
        self.base = firstPoint;
    }
    for(int i = 0; i < points.count - 1; i++){
        SFPoint *point = [points objectAtIndex:i];
        SFPoint *nextPoint = [points objectAtIndex:i + 1];
        [self addTriangleWithPositive:positive andPoint1:self.base andPoint2:point andPoint3:nextPoint];
    }
    SFPoint *lastPoint = [points objectAtIndex:points.count - 1];
    if([firstPoint xValue] != [lastPoint xValue] || [firstPoint yValue] != [lastPoint yValue]){
        [self addTriangleWithPositive:positive andPoint1:self.base andPoint2:lastPoint andPoint3:firstPoint];
    }
}

/**
 * Add or subtract a triangle of points to or from the centroid total
 *
 * @param positive
 *            true if an addition, false if a subtraction
 * @param point1
 *            point 1
 * @param point2
 *            point 2
 * @param point3
 *            point 3
 */
-(void) addTriangleWithPositive: (BOOL) positive andPoint1: (SFPoint *) point1 andPoint2: (SFPoint *) point2 andPoint3: (SFPoint *) point3{
    double sign = (positive) ? 1.0 : -1.0;
    SFPoint *triangleCenter3 = [self centroid3WithPoint1:point1 andPoint2:point2 andPoint3:point3];
    double area2 = [self area2WithPoint1:point1 andPoint2:point2 andPoint3:point3];
    [self.sum setX:[self.sum.x decimalNumberByAdding:[[NSDecimalNumber alloc] initWithDouble:sign * area2 * [triangleCenter3 xValue]]]];
    [self.sum setY:[self.sum.y decimalNumberByAdding:[[NSDecimalNumber alloc] initWithDouble:sign * area2 * [triangleCenter3 yValue]]]];
    self.area += sign * area2;
}

/**
 * Calculate three times the centroid of the point triangle
 *
 * @param point1
 *            point 1
 * @param point2
 *            point 2
 * @param point3
 *            point 3
 * @return 3 times centroid point
 */
-(SFPoint *) centroid3WithPoint1: (SFPoint *) point1 andPoint2: (SFPoint *) point2 andPoint3: (SFPoint *) point3{
    double x = [point1 xValue] + [point2 xValue] + [point3 xValue];
    double y = [point1 yValue] + [point2 yValue] + [point3 yValue];
    SFPoint *point = [SFPoint pointWithXValue:x andYValue:y];
    return point;
}

/**
 * Calculate twice the area of the point triangle
 *
 * @param point1
 *            point 1
 * @param point2
 *            point 2
 * @param point3
 *            point 3
 * @return 2 times triangle area
 */
-(double) area2WithPoint1: (SFPoint *) point1 andPoint2: (SFPoint *) point2 andPoint3: (SFPoint *) point3{
    return ([point2 xValue] - [point1 xValue])
				* ([point3 yValue] - [point1 yValue])
				- ([point3 xValue] - [point1 xValue])
				* ([point2 yValue] - [point1 yValue]);
}

-(SFPoint *) centroid{
    SFPoint *centroid = [SFPoint pointWithXValue:([self.sum xValue] / 3 / self.area) andYValue:([self.sum yValue] / 3 / self.area)];
    return centroid;
}

@end
