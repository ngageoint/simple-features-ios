//
//  SFExtendedGeometryCollection.h
//  sf-ios
//
//  Created by Brian Osborn on 4/25/18.
//  Copyright © 2018 NGA. All rights reserved.
//

#import "SFGeometryCollection.h"

/**
 * Extended Geometry Collection providing abstract geometry collection type
 * support
 */
@interface SFExtendedGeometryCollection : SFGeometryCollection

/**
 * Initialize
 *
 * @param geometryCollection
 *            geometry collection
 *
 *  @return new extended geometry collection
 */
-(instancetype) initWithGeometryCollection: (SFGeometryCollection *) geometryCollection;

/**
 * Update the extended geometry type based upon the contained geometries
 */
-(void) updateGeometryType;

@end
