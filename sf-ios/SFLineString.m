//
//  SFLineString.m
//  sf-ios
//
//  Created by Brian Osborn on 6/2/15.
//  Copyright (c) 2015 NGA. All rights reserved.
//

#import "SFLineString.h"

@implementation SFLineString

-(instancetype) init{
    self = [self initWithHasZ:false andHasM:false];
    return self;
}

-(instancetype) initWithHasZ: (BOOL) hasZ andHasM: (BOOL) hasM{
    return [self initWithType:SF_LINESTRING andHasZ:hasZ andHasM:hasM];
}

-(instancetype) initWithType: (enum SFGeometryType) geometryType andHasZ: (BOOL) hasZ andHasM: (BOOL) hasM{
    self = [super initWithType:geometryType andHasZ:hasZ andHasM:hasM];
    if(self != nil){
        self.points = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void) addPoint: (SFPoint *) point{
    [self.points addObject:point];
}

-(NSNumber *) numPoints{
    return [NSNumber numberWithInteger:[self.points count] ];
}

-(id) mutableCopyWithZone: (NSZone *) zone{
    SFLineString *lineString = [[SFLineString alloc] initWithHasZ:self.hasZ andHasM:self.hasM];
    for(SFPoint *point in self.points){
        [lineString addPoint:[point mutableCopy]];
    }
    return lineString;
}

- (void) encodeWithCoder:(NSCoder *)encoder {
    [super encodeWithCoder:encoder];
    
    [encoder encodeObject:self.points forKey:@"points"];
}

- (id) initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if (self) {
        _points = [decoder decodeObjectForKey:@"points"];
    }
    return self;
}

@end
