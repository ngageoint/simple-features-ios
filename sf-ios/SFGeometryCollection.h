//
//  SFGeometryCollection.h
//  sf-ios
//
//  Created by Brian Osborn on 6/2/15.
//  Copyright (c) 2015 NGA. All rights reserved.
//

#import "SFGeometry.h"

/**
 *  A collection of zero or more Geometry instances.
 */
@interface SFGeometryCollection : SFGeometry

/**
 *  Array of geometries
 */
@property (nonatomic, strong) NSMutableArray<SFGeometry *> *geometries;

/**
 *  Initialize
 *
 *  @return new geometry collection
 */
-(instancetype) init;

/**
 *  Initialize
 *
 *  @param hasZ has z values
 *  @param hasM has m values
 *
 *  @return new geometry collection
 */
-(instancetype) initWithHasZ: (BOOL) hasZ andHasM: (BOOL) hasM;

/**
 *  Initialize
 *
 *  @param geometryType geometry type
 *  @param hasZ         has z values
 *  @param hasM         has m values
 *
 *  @return new geometry collection
 */
-(instancetype) initWithType: (enum SFGeometryType) geometryType andHasZ: (BOOL) hasZ andHasM: (BOOL) hasM;

/**
 *  Add geometry
 *
 *  @param geometry geometry
 */
-(void) addGeometry: (SFGeometry *) geometry;

/**
 * Add geometries
 *
 * @param geometries
 *            geometries
 */
-(void) addGeometries: (NSArray<SFGeometry *> *) geometries;

/**
 *  Get the number of geometries
 *
 *  @return geometry count
 */
-(int) numGeometries;

/**
 * Returns the Nth geometry
 *
 * @param n
 *            nth geometry to return
 * @return geometry
 */
-(SFGeometry *) geometryAtIndex: (int)  n;

// TODO collection methods

@end
