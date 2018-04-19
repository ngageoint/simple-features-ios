//
//  SFCentroidCurve.h
//  sf-ios
//
//  Created by Brian Osborn on 4/14/17.
//  Copyright © 2017 NGA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFPoint.h"

/**
 * Calculate the centroid from curve based geometries. Implementation based on
 * the JTS (Java Topology Suite) CentroidLine.
 *
 * @author osbornb
 */
@interface SFCentroidCurve : NSObject

/**
 *  Initialize
 *
 *  @return new instance
 */
-(instancetype) init;

/**
 *  Initialize
 *
 * @param geometry
 *            geometry to add
 *  @return new instance
 */
-(instancetype) initWithGeometry: (SFGeometry *) geometry;

/**
 * Add a curve based dimension 1 geometry to the centroid total. Ignores
 * dimension 0 geometries.
 *
 * @param geometry
 *            geometry
 */
-(void) addGeometry: (SFGeometry *) geometry;

/**
 * Get the centroid point
 *
 * @return centroid point
 */
-(SFPoint *) centroid;

@end
