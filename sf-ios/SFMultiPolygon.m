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

-(NSMutableArray *) getPolygons{
    return [self geometries];
}

-(void) setPolygons: (NSMutableArray *) polygons{
    [self setGeometries:polygons];
}

-(void) addPolygon: (SFPolygon *) polygon{
    [self addGeometry:polygon];
}

-(NSNumber *) numPolygons{
    return [self numGeometries];
}

-(id) mutableCopyWithZone: (NSZone *) zone{
    SFMultiPolygon *multiPolygon = [[SFMultiPolygon alloc] initWithHasZ:self.hasZ andHasM:self.hasM];
    for(SFPolygon *polygon in self.geometries){
        [multiPolygon addPolygon:[polygon mutableCopy]];
    }
    return multiPolygon;
}

@end
