//
//  SFMultiPolygon.h
//  sf-ios
//
//  Created by Brian Osborn on 6/2/15.
//  Copyright (c) 2015 NGA. All rights reserved.
//

#import "SFMultiSurface.h"
#import "SFPolygon.h"

/**
 * A restricted form of MultiSurface where each Surface in the collection must
 * be of type Polygon.
 */
@interface SFMultiPolygon : SFMultiSurface

/**
 *  Initialize
 *
 *  @return new multi polygon
 */
-(instancetype) init;

/**
 *  Initialize
 *
 *  @param hasZ has z values
 *  @param hasM has m values
 *
 *  @return new multi polygon
 */
-(instancetype) initWithHasZ: (BOOL) hasZ andHasM: (BOOL) hasM;

/**
 *  Get the polygons
 *
 *  @return polygons
 */
-(NSMutableArray<SFPolygon *> *) polygons;

/**
 *  Set the polygons
 *
 *  @param polygons polygons
 */
-(void) setPolygons: (NSMutableArray<SFPolygon *> *) polygons;

/**
 *  Add a polygon
 *
 *  @param polygon polygon
 */
-(void) addPolygon: (SFPolygon *) polygon;

/**
 * Add polygons
 *
 * @param polygons
 *            polygons
 */
-(void) addPolygons: (NSArray<SFPolygon *> *) polygons;

/**
 *  Get the number of polygons
 *
 *  @return polygon count
 */
-(int) numPolygons;

/**
 * Returns the Nth polygon
 *
 * @param n
 *            nth polygon to return
 * @return polygon
 */
-(SFPolygon *) polygonAtIndex: (int) n;

@end
