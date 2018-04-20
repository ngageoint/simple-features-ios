//
//  SFCurvePolygon.m
//  sf-ios
//
//  Created by Brian Osborn on 6/2/15.
//  Copyright (c) 2015 NGA. All rights reserved.
//

#import "SFCurvePolygon.h"
#import "SFGeometryUtils.h"

@implementation SFCurvePolygon

-(instancetype) init{
    self = [self initWithHasZ:false andHasM:false];
    return self;
}

-(instancetype) initWithHasZ: (BOOL) hasZ andHasM: (BOOL) hasM{
    return [self initWithType:SF_CURVEPOLYGON andHasZ:hasZ andHasM:hasM];
}

-(instancetype) initWithRings: (NSMutableArray<SFCurve *> *) rings{
    self = [self initWithHasZ:[SFGeometryUtils hasZ:rings] andHasM:[SFGeometryUtils hasM:rings]];
    if(self != nil){
        [self setRings:rings];
    }
    return self;
}

-(instancetype) initWithRing: (SFCurve *) ring{
    self = [self initWithHasZ:ring.hasZ andHasM:ring.hasM];
    if(self != nil){
        [self addRing:ring];
    }
    return self;
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

-(void) addRings: (NSArray<SFCurve *> *) rings{
    [self.rings addObjectsFromArray:rings];
}

-(int) numRings{
    return (int) self.rings.count;
}

-(SFCurve *) ringAtIndex: (int) n{
    return [self.rings objectAtIndex:n];
}

-(SFCurve *) exteriorRing{
    return [self.rings objectAtIndex:0];
}

-(int) numInteriorRings{
    return (int)self.rings.count - 1;
}

-(SFCurve *) interiorRingAtIndex: (int) n{
    return [self.rings objectAtIndex:n + 1];
}

-(BOOL) isEmpty{
    return self.rings.count == 0;
}

-(BOOL) isSimple{
    [NSException raise:@"Unsupported" format:@"Is Simple not implemented for Curve Polygon"];
    return NO;
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

- (BOOL)isEqualToCurvePolygon:(SFCurvePolygon *)curvePolygon {
    if (self == curvePolygon)
        return YES;
    if (curvePolygon == nil)
        return NO;
    if (![super isEqual:curvePolygon])
        return NO;
    if (self.rings == nil) {
        if (curvePolygon.rings != nil)
            return NO;
    } else if (![self.rings isEqual:curvePolygon.rings])
        return NO;
    return YES;
}

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[SFCurvePolygon class]]) {
        return NO;
    }
    
    return [self isEqualToCurvePolygon:(SFCurvePolygon *)object];
}

- (NSUInteger)hash {
    NSUInteger prime = 31;
    NSUInteger result = [super hash];
    result = prime * result
        + ((self.rings == nil) ? 0 : [self.rings hash]);
    return result;
}

@end
