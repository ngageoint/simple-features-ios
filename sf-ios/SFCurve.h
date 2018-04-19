//
//  SFCurve.h
//  sf-ios
//
//  Created by Brian Osborn on 6/2/15.
//  Copyright (c) 2015 NGA. All rights reserved.
//

#import "SFGeometry.h"

/**
 * The base type for all 1-dimensional geometry types. A 1-dimensional geometry
 * is a geometry that has a length, but no area. A curve is considered simple if
 * it does not intersect itself (except at the start and end point). A curve is
 * considered closed its start and end point are coincident. A simple, closed
 * curve is called a ring.
 */
@interface SFCurve : SFGeometry

/**
 *  Initialize
 *
 *  @param geometryType geometry type
 *  @param hasZ         has z values
 *  @param hasM         has m values
 *
 *  @return new curve
 */
-(instancetype) initWithType: (enum SFGeometryType) geometryType andHasZ: (BOOL) hasZ andHasM: (BOOL) hasM;

@end
