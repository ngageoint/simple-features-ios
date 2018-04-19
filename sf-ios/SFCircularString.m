//
//  SFCircularString.m
//  sf-ios
//
//  Created by Brian Osborn on 6/2/15.
//  Copyright (c) 2015 NGA. All rights reserved.
//

#import "SFCircularString.h"

@implementation SFCircularString

-(instancetype) init{
    self = [self initWithHasZ:false andHasM:false];
    return self;
}

-(instancetype) initWithHasZ: (BOOL) hasZ andHasM: (BOOL) hasM{
    self = [super initWithType:SF_CIRCULARSTRING andHasZ:hasZ andHasM:hasM];
    return self;
}

-(id) mutableCopyWithZone: (NSZone *) zone{
    SFCircularString *circularString = [[SFCircularString alloc] initWithHasZ:self.hasZ andHasM:self.hasM];
    for(SFPoint *point in self.points){
        [circularString addPoint:[point mutableCopy]];
    }
    return circularString;
}

@end
