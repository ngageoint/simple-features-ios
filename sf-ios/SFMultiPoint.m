//
//  SFMultiPoint.m
//  sf-ios
//
//  Created by Brian Osborn on 6/2/15.
//  Copyright (c) 2015 NGA. All rights reserved.
//

#import "SFMultiPoint.h"

@implementation SFMultiPoint

-(instancetype) init{
    self = [self initWithHasZ:false andHasM:false];
    return self;
}

-(instancetype) initWithHasZ: (BOOL) hasZ andHasM: (BOOL) hasM{
    self = [super initWithType:SF_MULTIPOINT andHasZ:hasZ andHasM:hasM];
    return self;
}

-(NSMutableArray<SFPoint *> *) points{
    return (NSMutableArray<SFPoint *> *)[self geometries];
}

-(void) setPoints: (NSMutableArray<SFPoint *> *) points{
    [self setGeometries:(NSMutableArray<SFGeometry *> *)points];
}

-(void) addPoint: (SFPoint *) point{
    [self addGeometry:point];
}

-(void) addPoints: (NSArray<SFPoint *> *) points{
    [self addGeometries:points];
}

-(int) numPoints{
    return [self numGeometries];
}

-(SFPoint *) pointAtIndex: (int) n{
    return (SFPoint *)[self geometryAtIndex:n];
}

-(BOOL) isSimple{
    NSSet<SFPoint *> *points = [[NSSet alloc] initWithArray:[self points]];
    return points.count == [self numPoints];
}

-(id) mutableCopyWithZone: (NSZone *) zone{
    SFMultiPoint *multiPoint = [[SFMultiPoint alloc] initWithHasZ:self.hasZ andHasM:self.hasM];
    for(SFPoint *point in self.geometries){
        [multiPoint addPoint:[point mutableCopy]];
    }
    return multiPoint;
}

@end
