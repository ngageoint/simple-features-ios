//
//  SFLine.m
//  sf-ios
//
//  Created by Brian Osborn on 4/25/18.
//  Copyright © 2018 NGA. All rights reserved.
//

#import "SFLine.h"
#import "SFGeometryUtils.h"

@implementation SFLine

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
    if(![self isEmpty] && [self numPoints] != 2){
        [NSException raise:@"Invalid Line" format:@"A line must have exactly 2 points."];
    }
}

-(id) mutableCopyWithZone: (NSZone *) zone{
    SFLine *line = [[SFLine alloc] initWithHasZ:self.hasZ andHasM:self.hasM];
    for(SFPoint *point in self.points){
        [line addPoint:[point mutableCopy]];
    }
    return line;
}

@end
