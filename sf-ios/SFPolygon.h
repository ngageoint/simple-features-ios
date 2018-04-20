//
//  SFPolygon.h
//  sf-ios
//
//  Created by Brian Osborn on 6/2/15.
//  Copyright (c) 2015 NGA. All rights reserved.
//

#import "SFCurvePolygon.h"
#import "SFLineString.h"

/**
 * A restricted form of CurvePolygon where each ring is defined as a simple,
 * closed LineString.
 */
@interface SFPolygon : SFCurvePolygon

/**
 *  Initialize
 *
 *  @return new polygon
 */
-(instancetype) init;

/**
 *  Initialize
 *
 *  @param hasZ has z values
 *  @param hasM has m values
 *
 *  @return new polygon
 */
-(instancetype) initWithHasZ: (BOOL) hasZ andHasM: (BOOL) hasM;

/**
 *  Initialize
 *
 *  @param geometryType geometry type
 *  @param hasZ         has z values
 *  @param hasM         has m values
 *
 *  @return new polygon
 */
-(instancetype) initWithType: (enum SFGeometryType) geometryType andHasZ: (BOOL) hasZ andHasM: (BOOL) hasM;

/**
 * Get the line string rings
 *
 * @return line string rings
 */
-(NSMutableArray<SFLineString *> *) lineStrings;

/**
 * Returns the Nth ring where the exterior ring is at 0, interior rings
 * begin at 1
 *
 * @param n
 *            nth ring to return
 * @return ring
 */
-(SFLineString *) ringAtIndex: (int) n;

/**
 * Get the exterior ring
 *
 * @return exterior ring
 */
-(SFLineString *) exteriorRing;

/**
 * Returns the Nth interior ring for this Polygon
 *
 * @param n
 *            interior ring number
 * @return interior ring
 */
-(SFLineString *) interiorRingAtIndex: (int) n;

@end
