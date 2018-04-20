//
//  SFGeometryCollection.m
//  sf-ios
//
//  Created by Brian Osborn on 6/2/15.
//  Copyright (c) 2015 NGA. All rights reserved.
//

#import "SFGeometryCollection.h"
#import "SFGeometryUtils.h"

@implementation SFGeometryCollection

-(instancetype) init{
    self = [self initWithHasZ:false andHasM:false];
    return self;
}

-(instancetype) initWithHasZ: (BOOL) hasZ andHasM: (BOOL) hasM{
    return [self initWithType:SF_GEOMETRYCOLLECTION andHasZ:hasZ andHasM:hasM];
}

-(instancetype) initWithGeometries: (NSMutableArray<SFGeometry *> *) geometries{
    self = [self initWithHasZ:[SFGeometryUtils hasZ:geometries] andHasM:[SFGeometryUtils hasM:geometries]];
    if(self != nil){
        [self setGeometries:geometries];
    }
    return self;
}

-(instancetype) initWithGeometry: (SFGeometry *) geometry{
    self = [self initWithHasZ:geometry.hasZ andHasM:geometry.hasM];
    if(self != nil){
        [self addGeometry:geometry];
    }
    return self;
}

-(instancetype) initWithType: (enum SFGeometryType) geometryType andHasZ: (BOOL) hasZ andHasM: (BOOL) hasM{
    self = [super initWithType:geometryType andHasZ:hasZ andHasM:hasM];
    if(self != nil){
        self.geometries = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void) addGeometry: (SFGeometry *) geometry{
    [self.geometries addObject:geometry];
}

-(void) addGeometries: (NSArray<SFGeometry *> *) geometries{
    [self.geometries addObjectsFromArray:geometries];
}

-(int) numGeometries{
    return (int)self.geometries.count;
}

-(SFGeometry *) geometryAtIndex: (int)  n{
    return [self.geometries objectAtIndex:n];
}

-(BOOL) isEmpty{
    return self.geometries.count == 0;
}

-(BOOL) isSimple{
    [NSException raise:@"Unsupported" format:@"Is Simple not implemented for Geometry Collection"];
    return NO;
}

-(id) mutableCopyWithZone: (NSZone *) zone{
    SFGeometryCollection *geometryCollection = [[SFGeometryCollection alloc] initWithHasZ:self.hasZ andHasM:self.hasM];
    for(SFGeometry *geometry in self.geometries){
        [geometryCollection addGeometry:[geometry mutableCopy]];
    }
    return geometryCollection;
}

- (void) encodeWithCoder:(NSCoder *)encoder {
    [super encodeWithCoder:encoder];
    
    [encoder encodeObject:self.geometries forKey:@"geometries"];
}

- (id) initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if (self) {
        _geometries = [decoder decodeObjectForKey:@"geometries"];
    }
    return self;
}

- (BOOL)isEqualToGeometryCollection:(SFGeometryCollection *)geometryCollection {
    if (self == geometryCollection)
        return YES;
    if (geometryCollection == nil)
        return NO;
    if (![super isEqual:geometryCollection])
        return NO;
    if (self.geometries == nil) {
        if (geometryCollection.geometries != nil)
            return NO;
    } else if (![self.geometries isEqual:geometryCollection.geometries])
        return NO;
    return YES;
}

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[SFGeometryCollection class]]) {
        return NO;
    }
    
    return [self isEqualToGeometryCollection:(SFGeometryCollection *)object];
}

- (NSUInteger)hash {
    NSUInteger prime = 31;
    NSUInteger result = [super hash];
    result = prime * result
        + ((self.geometries == nil) ? 0 : [self.geometries hash]);
    return result;
}

@end
