//
//  SFLinearRing.h
//  sf-ios
//
//  Created by Brian Osborn on 4/25/18.
//  Copyright © 2018 NGA. All rights reserved.
//

#import "SFLineString.h"

/**
 * A LineString that is both closed and simple.
 */
@interface SFLinearRing : SFLineString

/**
 *  Create
 *
 *  @return new linear ring
 */
+(SFLinearRing *) linearRing;

/**
 *  Create
 *
 *  @param hasZ has z values
 *  @param hasM has m values
 *
 *  @return new linear ring
 */
+(SFLinearRing *) linearRingWithHasZ: (BOOL) hasZ andHasM: (BOOL) hasM;

/**
 * Create
 *
 * @param points
 *            list of points
 *
 *  @return new linear ring
 */
+(SFLinearRing *) linearRingWithPoints: (NSMutableArray<SFPoint *> *) points;

/**
 *  Initialize
 *
 *  @return new linear ring
 */
-(instancetype) init;

/**
 *  Initialize
 *
 *  @param hasZ has z values
 *  @param hasM has m values
 *
 *  @return new linear ring
 */
-(instancetype) initWithHasZ: (BOOL) hasZ andHasM: (BOOL) hasM;

/**
 * Initialize
 *
 * @param points
 *            list of points
 *
 *  @return new linear ring
 */
-(instancetype) initWithPoints: (NSMutableArray<SFPoint *> *) points;

@end
