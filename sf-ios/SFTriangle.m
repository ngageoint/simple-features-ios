//
//  SFTriangle.m
//  sf-ios
//
//  Created by Brian Osborn on 6/2/15.
//  Copyright (c) 2015 NGA. All rights reserved.
//

#import "SFTriangle.h"
#import "SFLineString.h"
#import "SFGeometryUtils.h"

@implementation SFTriangle

-(instancetype) init{
    self = [self initWithHasZ:false andHasM:false];
    return self;
}

-(instancetype) initWithHasZ: (BOOL) hasZ andHasM: (BOOL) hasM{
    self = [super initWithType:SF_TRIANGLE andHasZ:hasZ andHasM:hasM];
    return self;
}

-(instancetype) initWithRings: (NSMutableArray<SFLineString *> *) rings{
    self = [self initWithHasZ:[SFGeometryUtils hasZ:rings] andHasM:[SFGeometryUtils hasM:rings]];
    if(self != nil){
        [self setRings:rings];
    }
    return self;
}

-(instancetype) initWithRing: (SFLineString *) ring{
    self = [self initWithHasZ:ring.hasZ andHasM:ring.hasM];
    if(self != nil){
        [self addRing:ring];
    }
    return self;
}

-(id) mutableCopyWithZone: (NSZone *) zone{
    SFTriangle *triangle = [[SFTriangle alloc] initWithHasZ:self.hasZ andHasM:self.hasM];
    for(SFLineString *ring in self.rings){
        [triangle addRing:[ring mutableCopy]];
    }
    return triangle;
}

@end
