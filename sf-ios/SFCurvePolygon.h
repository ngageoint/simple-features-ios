//
//  SFCurvePolygon.h
//  sf-ios
//
//  Created by Brian Osborn on 6/2/15.
//  Copyright (c) 2015 NGA. All rights reserved.
//

#import "SFSurface.h"
#import "SFCurve.h"

/**
 * A planar surface defined by an exterior ring and zero or more interior ring.
 * Each ring is defined by a Curve instance.
 */
@interface SFCurvePolygon : SFSurface

/**
 *  Array of rings
 */
@property (nonatomic, strong) NSMutableArray * rings;

/**
 *  Initialize
 *
 *  @return new curve polygon
 */
-(instancetype) init;

/**
 *  Initialize
 *
 *  @param hasZ has z values
 *  @param hasM has m values
 *
 *  @return new curve polygon
 */
-(instancetype) initWithHasZ: (BOOL) hasZ andHasM: (BOOL) hasM;

/**
 *  Initialize
 *
 *  @param geometryType geometry type
 *  @param hasZ         has z values
 *  @param hasM         has m values
 *
 *  @return new curve polygon
 */
-(instancetype) initWithType: (enum SFGeometryType) geometryType andHasZ: (BOOL) hasZ andHasM: (BOOL) hasM;

/**
 *  Add a ring
 *
 *  @param ring curve ring
 */
-(void) addRing: (SFCurve *) ring;

/**
 *  Get the number of rings
 *
 *  @return ring count
 */
-(NSNumber *) numRings;

@end
