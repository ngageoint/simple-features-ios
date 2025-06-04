//
//  SFCentroidPoint.m
//  sf-ios
//
//  Created by Brian Osborn on 4/14/17.
//  Copyright © 2017 NGA. All rights reserved.
//

#import <SimpleFeatures/SFCentroidPoint.h>
#import <SimpleFeatures/SFMultiPoint.h>

@interface SFCentroidPoint()

/**
 * Point count
 */
@property (nonatomic) int count;

/**
 * Sum of point locations
 */
@property (nonatomic, strong) SFPoint *sum;

@end

@implementation SFCentroidPoint

-(instancetype) init{
    return [self initWithGeometry:nil];
}

-(instancetype) initWithGeometry: (SFGeometry *) geometry{
    self = [super init];
    if(self != nil){
        self.count = 0;
        self.sum = [SFPoint point];
        [self addGeometry:geometry];
    }
    return self;
}

-(void) addGeometry: (SFGeometry *) geometry{
    SFGeometryType geometryType = geometry.geometryType;
    switch (geometryType) {
        case SF_POINT:
            [self addPoint:(SFPoint *)geometry];
            break;
        case SF_MULTIPOINT:
            {
                SFMultiPoint *multiPoint = (SFMultiPoint *) geometry;
                for(SFPoint *point in [multiPoint points]){
                    [self addPoint:point];
                }
            }
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
        default:
            [NSException raise:@"Geometry Not Supported" format:@"Unsupported Geometry Type: %ld", geometryType];
    }
}

/**
 * Add a point to the centroid total
 *
 * @param point
 *            point
 */
-(void) addPoint: (SFPoint *) point{
    self.count++;
    [self.sum setX:[self.sum.x decimalNumberByAdding:point.x]];
    [self.sum setY:[self.sum.y decimalNumberByAdding:point.y]];
}

-(SFPoint *) centroid{
    SFPoint *centroid = [SFPoint pointWithXValue:([self.sum xValue] / self.count) andYValue:([self.sum yValue] / self.count)];
    return centroid;
}

@end
