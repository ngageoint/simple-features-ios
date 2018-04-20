//
//  SFPolyhedralSurface.h
//  sf-ios
//
//  Created by Brian Osborn on 6/2/15.
//  Copyright (c) 2015 NGA. All rights reserved.
//

#import "SFSurface.h"
#import "SFPolygon.h"

/**
 *  Contiguous collection of polygons which share common boundary segments.
 */
@interface SFPolyhedralSurface : SFSurface

/**
 *  Array of polygons
 */
@property (nonatomic, strong) NSMutableArray<SFPolygon *> *polygons;

/**
 *  Initialize
 *
 *  @return new polyhedral surface
 */
-(instancetype) init;

/**
 *  Initialize
 *
 *  @param hasZ has z values
 *  @param hasM has m values
 *
 *  @return new polyhedral surface
 */
-(instancetype) initWithHasZ: (BOOL) hasZ andHasM: (BOOL) hasM;

/**
 *  Initialize
 *
 *  @param geometryType geometry type
 *  @param hasZ         has z values
 *  @param hasM         has m values
 *
 *  @return new polyhedral surface
 */
-(instancetype) initWithType: (enum SFGeometryType) geometryType andHasZ: (BOOL) hasZ andHasM: (BOOL) hasM;

/**
 * Get patches
 *
 * @return patches
 */
-(NSMutableArray<SFPolygon *> *) patches;

/**
 * Set patches
 *
 * @param patches
 *            patches
 */
-(void) setPatches: (NSMutableArray<SFPolygon *> *) patches;

/**
 *  Add a polygon
 *
 *  @param polygon polygon
 */
-(void) addPolygon: (SFPolygon *) polygon;

/**
 * Add patch
 *
 * @param patch
 *            patch
 */
-(void) addPatch: (SFPolygon *) patch;

/**
 * Add polygons
 *
 * @param polygons
 *            polygons
 */
-(void) addPolygons: (NSArray<SFPolygon *> *) polygons;

/**
 * Add patches
 *
 * @param patches
 *            patches
 */
-(void) addPatches: (NSArray<SFPolygon *> *) patches;

/**
 *  Get the number of polygons
 *
 *  @return polygon count
 */
-(int) numPolygons;

/**
 *  Get the number of patches
 *
 *  @return patch count
 */
-(int) numPatches;

/**
 * Get the Nth polygon
 *
 * @param n
 *            nth polygon to return
 * @return polygon
 */
-(SFPolygon *) polygonAtIndex: (int) n;

/**
 * Get the Nth polygon patch
 *
 * @param n
 *            nth polygon patch to return
 * @return polygon patch
 */
-(SFPolygon *) patchAtIndex: (int) n;

@end
