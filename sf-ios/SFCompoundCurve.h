//
//  SFCompoundCurve.h
//  sf-ios
//
//  Created by Brian Osborn on 6/2/15.
//  Copyright (c) 2015 NGA. All rights reserved.
//

#import "SFCurve.h"
#import "SFLineString.h"

/**
 * Compound Curve, Curve sub type
 */
@interface SFCompoundCurve : SFCurve

/**
 *  Array of line strings
 */
@property (nonatomic, strong) NSMutableArray * lineStrings;

/**
 *  Initialize
 *
 *  @return new compound curve
 */
-(instancetype) init;

/**
 *  Initialize
 *
 *  @param hasZ has z values
 *  @param hasM has m values
 *
 *  @return new compound curve
 */
-(instancetype) initWithHasZ: (BOOL) hasZ andHasM: (BOOL) hasM;

/**
 *  Add a line string
 *
 *  @param lineString line string
 */
-(void) addLineString: (SFLineString *) lineString;

/**
 *  Get the number of line strings
 *
 *  @return line string count
 */
-(NSNumber *) numLineStrings;

@end
