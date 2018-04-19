//
//  SFPolyhedralSurface.m
//  sf-ios
//
//  Created by Brian Osborn on 6/2/15.
//  Copyright (c) 2015 NGA. All rights reserved.
//

#import "SFPolyhedralSurface.h"

@implementation SFPolyhedralSurface

-(instancetype) init{
    self = [self initWithHasZ:false andHasM:false];
    return self;
}

-(instancetype) initWithHasZ: (BOOL) hasZ andHasM: (BOOL) hasM{
    return [self initWithType:SF_POLYHEDRALSURFACE andHasZ:hasZ andHasM:hasM];
}

-(instancetype) initWithType: (enum SFGeometryType) geometryType andHasZ: (BOOL) hasZ andHasM: (BOOL) hasM{
    self = [super initWithType:geometryType andHasZ:hasZ andHasM:hasM];
    if(self != nil){
        self.polygons = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void) addPolygon: (SFPolygon *) polygon{
    [self.polygons addObject:polygon];
}

-(NSNumber *) numPolygons{
    return [NSNumber numberWithInteger:[self.polygons count]];
}

-(id) mutableCopyWithZone: (NSZone *) zone{
    SFPolyhedralSurface *polyhedralSurface = [[SFPolyhedralSurface alloc] initWithHasZ:self.hasZ andHasM:self.hasM];
    for(SFPolygon *polygon in self.polygons){
        [polyhedralSurface addPolygon:[polygon mutableCopy]];
    }
    return polyhedralSurface;
}

@end
