//
//  SFLine.h
//  sf-ios
//
//  Created by Brian Osborn on 4/25/18.
//  Copyright © 2018 NGA. All rights reserved.
//

#import "SFLineString.h"

/**
 * A LineString with exactly 2 Points.
 */
@interface SFLine : SFLineString

/**
 *  Initialize
 *
 *  @return new line
 */
-(instancetype) init;

/**
 *  Initialize
 *
 *  @param hasZ has z values
 *  @param hasM has m values
 *
 *  @return new line
 */
-(instancetype) initWithHasZ: (BOOL) hasZ andHasM: (BOOL) hasM;

/**
 * Initialize
 *
 * @param points
 *            list of points
 *
 *  @return new line
 */
-(instancetype) initWithPoints: (NSMutableArray<SFPoint *> *) points;

/**
 *  Initialize
 *
 *  @param point1 first point
 *  @param point2 second point
 *
 *  @return new line
 */
-(instancetype) initWithPoint1: (SFPoint *) point1 andPoint2: (SFPoint *) point2;

@end
