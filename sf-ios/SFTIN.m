//
//  SFTIN.m
//  sf-ios
//
//  Created by Brian Osborn on 6/2/15.
//  Copyright (c) 2015 NGA. All rights reserved.
//

#import "SFTIN.h"

@implementation SFTIN

-(instancetype) init{
    self = [self initWithHasZ:false andHasM:false];
    return self;
}

-(instancetype) initWithHasZ: (BOOL) hasZ andHasM: (BOOL) hasM{
    self = [super initWithType:SF_TIN andHasZ:hasZ andHasM:hasM];
    return self;
}

-(id) mutableCopyWithZone: (NSZone *) zone{
    SFTIN *tin = [[SFTIN alloc] initWithHasZ:self.hasZ andHasM:self.hasM];
    for(SFPolygon *polygon in self.polygons){
        [tin addPolygon:[polygon mutableCopy]];
    }
    return tin;
}

@end
