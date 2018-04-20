//
//  SFMultiPolygon.m
//  sf-ios
//
//  Created by Brian Osborn on 6/2/15.
//  Copyright (c) 2015 NGA. All rights reserved.
//

#import "SFMultiPolygon.h"

@implementation SFMultiPolygon

-(instancetype) init{
    self = [self initWithHasZ:false andHasM:false];
    return self;
}

-(instancetype) initWithHasZ: (BOOL) hasZ andHasM: (BOOL) hasM{
    self = [super initWithType:SF_MULTIPOLYGON andHasZ:hasZ andHasM:hasM];
    return self;
}

-(NSMutableArray<SFPolygon *> *) polygons{
    return (NSMutableArray<SFPolygon *> *)[self surfaces];
}

-(void) setPolygons: (NSMutableArray<SFPolygon *> *) polygons{
    [self setSurfaces:(NSMutableArray<SFSurface *> *)polygons];
}

-(void) addPolygon: (SFPolygon *) polygon{
    [self addSurface:polygon];
}

-(void) addPolygons: (NSArray<SFPolygon *> *) polygons{
    [self addSurfaces:polygons];
}

-(int) numPolygons{
    return [self numSurfaces];
}

-(SFPolygon *) polygonAtIndex: (int) n{
    return (SFPolygon *)[self surfaceAtIndex:n];
}

-(id) mutableCopyWithZone: (NSZone *) zone{
    SFMultiPolygon *multiPolygon = [[SFMultiPolygon alloc] initWithHasZ:self.hasZ andHasM:self.hasM];
    for(SFPolygon *polygon in self.geometries){
        [multiPolygon addPolygon:[polygon mutableCopy]];
    }
    return multiPolygon;
}

@end
