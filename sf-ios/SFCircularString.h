//
//  SFCircularString.h
//  sf-ios
//
//  Created by Brian Osborn on 6/2/15.
//  Copyright (c) 2015 NGA. All rights reserved.
//

#import "SFLineString.h"

/**
 * Circular String, Curve sub type
 */
@interface SFCircularString : SFLineString

/**
 *  Initialize
 *
 *  @return new circular string
 */
-(instancetype) init;

/**
 *  Initialize
 *
 *  @param hasZ has z values
 *  @param hasM has m values
 *
 *  @return new circular string
 */
-(instancetype) initWithHasZ: (BOOL) hasZ andHasM: (BOOL) hasM;

@end
