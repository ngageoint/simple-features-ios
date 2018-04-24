//
//  SFTriangle.h
//  sf-ios
//
//  Created by Brian Osborn on 6/2/15.
//  Copyright (c) 2015 NGA. All rights reserved.
//

#import "SFPolygon.h"

/**
 * Triangle
 */
@interface SFTriangle : SFPolygon

/**
 *  Initialize
 *
 *  @return new triangle
 */
-(instancetype) init;

/**
 *  Initialize
 *
 *  @param hasZ has z values
 *  @param hasM has m values
 *
 *  @return new triangle
 */
-(instancetype) initWithHasZ: (BOOL) hasZ andHasM: (BOOL) hasM;

/**
 * Initialize
 *
 * @param rings
 *            list of rings
 *
 *  @return new triangle
 */
-(instancetype) initWithRings: (NSMutableArray<SFLineString *> *) rings;

/**
 * Initialize
 *
 * @param ring
 *            ring
 *
 *  @return new triangle
 */
-(instancetype) initWithRing: (SFLineString *) ring;

@end
