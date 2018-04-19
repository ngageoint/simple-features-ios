//
//  SFGeometry.h
//  sf-ios
//
//  Created by Brian Osborn on 6/1/15.
//  Copyright (c) 2015 NGA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFGeometryTypes.h"

/**
 *  The root of the geometry type hierarchy
 */
@interface SFGeometry : NSObject <NSMutableCopying, NSCoding>

/**
 *  Geometry type
 */
@property (nonatomic) enum SFGeometryType geometryType;

/**
 *  Has Z values
 */
@property (nonatomic) BOOL hasZ;

/**
 *  Has M values
 */
@property (nonatomic) BOOL hasM;

/**
 *  Initialize
 *
 *  @param geometryType geometry type
 *  @param hasZ         has z values
 *  @param hasM         has m values
 *
 *  @return new geometry
 */
-(instancetype) initWithType: (enum SFGeometryType) geometryType andHasZ: (BOOL) hasZ andHasM: (BOOL) hasM;

@end
