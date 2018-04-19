//
//  SFCurvePolygon.m
//  sf-ios
//
//  Created by Brian Osborn on 6/2/15.
//  Copyright (c) 2015 NGA. All rights reserved.
//

#import "SFCurvePolygon.h"

@implementation SFCurvePolygon

-(instancetype) init{
    self = [self initWithHasZ:false andHasM:false];
    return self;
}

-(instancetype) initWithHasZ: (BOOL) hasZ andHasM: (BOOL) hasM{
    return [self initWithType:SF_CURVEPOLYGON andHasZ:hasZ andHasM:hasM];
}

-(instancetype) initWithType: (enum SFGeometryType) geometryType andHasZ: (BOOL) hasZ andHasM: (BOOL) hasM{
    self = [super initWithType:geometryType andHasZ:hasZ andHasM:hasM];
    if(self != nil){
        self.rings = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void) addRing: (SFCurve *) ring{
    [self.rings addObject:ring];
}

-(NSNumber *) numRings{
    return [NSNumber numberWithInteger:[self.rings count]];
}

-(id) mutableCopyWithZone: (NSZone *) zone{
    SFCurvePolygon *curevePolygon = [[SFCurvePolygon alloc] initWithHasZ:self.hasZ andHasM:self.hasM];
    for(SFCurve *ring in self.rings){
        [curevePolygon addRing:[ring mutableCopy]];
    }
    return curevePolygon;
}

- (void) encodeWithCoder:(NSCoder *)encoder {
    [super encodeWithCoder:encoder];
    
    [encoder encodeObject:self.rings forKey:@"rings"];
}

- (id) initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if (self) {
        _rings = [decoder decodeObjectForKey:@"rings"];
    }
    return self;
}

@end
