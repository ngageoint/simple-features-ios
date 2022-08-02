//
//  SFPolygon.m
//  sf-ios
//
//  Created by Brian Osborn on 6/2/15.
//  Copyright (c) 2015 NGA. All rights reserved.
//

#import "SFPolygon.h"
#import "SFLineString.h"
#import "SFShamosHoey.h"
#import "SFGeometryUtils.h"

@implementation SFPolygon

+(SFPolygon *) polygon{
    return [[SFPolygon alloc] init];
}

+(SFPolygon *) polygonWithHasZ: (BOOL) hasZ andHasM: (BOOL) hasM{
    return [[SFPolygon alloc] initWithHasZ:hasZ andHasM:hasM];
}

+(SFPolygon *) polygonWithRings: (NSMutableArray<SFLineString *> *) rings{
    return [[SFPolygon alloc] initWithRings:rings];
}

+(SFPolygon *) polygonWithRing: (SFLineString *) ring{
    return [[SFPolygon alloc] initWithRing:ring];
}

-(instancetype) init{
    self = [self initWithHasZ:false andHasM:false];
    return self;
}

-(instancetype) initWithHasZ: (BOOL) hasZ andHasM: (BOOL) hasM{
    return [self initWithType:SF_POLYGON andHasZ:hasZ andHasM:hasM];
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

-(instancetype) initWithType: (enum SFGeometryType) geometryType andHasZ: (BOOL) hasZ andHasM: (BOOL) hasM{
    self = [super initWithType:geometryType andHasZ:hasZ andHasM:hasM];
    return self;
}

-(NSMutableArray<SFLineString *> *) lineStrings{
    return (NSMutableArray<SFLineString *> *) self.rings;
}

-(void) setRings: (NSMutableArray<SFLineString *> *) rings{
    [super setRings:(NSMutableArray<SFCurve *> *)rings];
}

-(SFLineString *) ringAtIndex: (int) n{
    return (SFLineString *)[super ringAtIndex:n];
}

-(SFLineString *) exteriorRing{
    return (SFLineString *)[super exteriorRing];
}

-(SFLineString *) interiorRingAtIndex: (int) n{
    return (SFLineString *)[super interiorRingAtIndex:n];
}

-(BOOL) isSimple{
    return [SFShamosHoey simplePolygon:self];
}

-(id) mutableCopyWithZone: (NSZone *) zone{
    SFPolygon *polygon = [SFPolygon polygonWithHasZ:self.hasZ andHasM:self.hasM];
    for(SFLineString *ring in self.rings){
        [polygon addRing:[ring mutableCopy]];
    }
    return polygon;
}

@end
