//
//  SFLinearRing.m
//  sf-ios
//
//  Created by Brian Osborn on 4/25/18.
//  Copyright © 2018 NGA. All rights reserved.
//

#import "SFLinearRing.h"
#import "SFGeometryUtils.h"

@implementation SFLinearRing

-(instancetype) init{
    self = [self initWithHasZ:false andHasM:false];
    return self;
}

-(instancetype) initWithHasZ: (BOOL) hasZ andHasM: (BOOL) hasM{
    return [super initWithHasZ:hasZ andHasM:hasM];
}

-(instancetype) initWithPoints: (NSMutableArray<SFPoint *> *) points{
    self = [self initWithHasZ:[SFGeometryUtils hasZ:points] andHasM:[SFGeometryUtils hasM:points]];
    if(self != nil){
        [self setPoints:points];
    }
    return self;
}

-(void) setPoints:(NSMutableArray<SFPoint *> *)points{
    [super setPoints:points];
    if(![self isEmpty]){
        if(![self isClosed]){
            [self addPoint:[points objectAtIndex:0]];
        }
        if([self numPoints] < 4){
            [NSException raise:@"Invalid Linear Ring" format:@"A closed linear ring must have at least four points."];
        }
    }
}

-(id) mutableCopyWithZone: (NSZone *) zone{
    SFLinearRing *linearRing = [[SFLinearRing alloc] initWithHasZ:self.hasZ andHasM:self.hasM];
    for(SFPoint *point in self.points){
        [linearRing addPoint:[point mutableCopy]];
    }
    return linearRing;
}

@end
