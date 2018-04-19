//
//  SFMultiPoint.m
//  sf-ios
//
//  Created by Brian Osborn on 6/2/15.
//  Copyright (c) 2015 NGA. All rights reserved.
//

#import "SFMultiPoint.h"

@implementation SFMultiPoint

-(instancetype) init{
    self = [self initWithHasZ:false andHasM:false];
    return self;
}

-(instancetype) initWithHasZ: (BOOL) hasZ andHasM: (BOOL) hasM{
    self = [super initWithType:SF_MULTIPOINT andHasZ:hasZ andHasM:hasM];
    return self;
}

-(NSMutableArray *) getPoints{
    return [self geometries];
}

-(void) setPoints: (NSMutableArray *) points{
    [self setGeometries:points];
}

-(void) addPoint: (SFPoint *) point{
    [self addGeometry:point];
}

-(NSNumber *) numPoints{
    return [self numGeometries];
}

-(id) mutableCopyWithZone: (NSZone *) zone{
    SFMultiPoint *multiPoint = [[SFMultiPoint alloc] initWithHasZ:self.hasZ andHasM:self.hasM];
    for(SFPoint *point in self.geometries){
        [multiPoint addPoint:[point mutableCopy]];
    }
    return multiPoint;
}

@end
