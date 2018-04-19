//
//  SFMultiLineString.m
//  sf-ios
//
//  Created by Brian Osborn on 6/2/15.
//  Copyright (c) 2015 NGA. All rights reserved.
//

#import "SFMultiLineString.h"

@implementation SFMultiLineString

-(instancetype) init{
    self = [self initWithHasZ:false andHasM:false];
    return self;
}

-(instancetype) initWithHasZ: (BOOL) hasZ andHasM: (BOOL) hasM{
    self = [super initWithType:SF_MULTILINESTRING andHasZ:hasZ andHasM:hasM];
    return self;
}

-(NSMutableArray *) getLineStrings{
    return [self geometries];
}

-(void) setLineStrings: (NSMutableArray *) lineStrings{
    [self setGeometries:lineStrings];
}

-(void) addLineString: (SFLineString *) lineString{
    [self addGeometry:lineString];
}

-(NSNumber *) numLineStrings{
    return [self numGeometries];
}

-(id) mutableCopyWithZone: (NSZone *) zone{
    SFMultiLineString *multiLineString = [[SFMultiLineString alloc] initWithHasZ:self.hasZ andHasM:self.hasM];
    for(SFLineString *lineString in self.geometries){
        [multiLineString addLineString:[lineString mutableCopy]];
    }
    return multiLineString;
}

@end
