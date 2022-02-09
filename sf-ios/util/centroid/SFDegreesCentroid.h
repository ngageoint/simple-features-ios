//
//  SFDegreesCentroid.h
//  sf-ios
//
//  Created by Brian Osborn on 2/9/22.
//  Copyright © 2022 NGA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFPoint.h"

/**
 * Centroid calculations for geometries in degrees
 */
@interface SFDegreesCentroid : NSObject

/**
 * Get the degree geometry centroid
 *
 * @param geometry
 *            geometry
 * @return centroid point
 */
+(SFPoint *) centroidOfGeometry: (SFGeometry *) geometry;

@end
