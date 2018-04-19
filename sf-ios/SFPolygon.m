//
//  SFPolygon.m
//  sf-ios
//
//  Created by Brian Osborn on 6/2/15.
//  Copyright (c) 2015 NGA. All rights reserved.
//

#import "SFPolygon.h"
#import "SFLineString.h"

@implementation SFPolygon

-(instancetype) init{
    self = [self initWithHasZ:false andHasM:false];
    return self;
}

-(instancetype) initWithHasZ: (BOOL) hasZ andHasM: (BOOL) hasM{
    return [self initWithType:SF_POLYGON andHasZ:hasZ andHasM:hasM];
}

-(instancetype) initWithType: (enum SFGeometryType) geometryType andHasZ: (BOOL) hasZ andHasM: (BOOL) hasM{
    self = [super initWithType:geometryType andHasZ:hasZ andHasM:hasM];
    return self;
}

-(id) mutableCopyWithZone: (NSZone *) zone{
    SFPolygon *polygon = [[SFPolygon alloc] initWithHasZ:self.hasZ andHasM:self.hasM];
    for(SFLineString *ring in self.rings){
        [polygon addRing:[ring mutableCopy]];
    }
    return polygon;
}

@end
