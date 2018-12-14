//
//  SFGeometryEnvelope.m
//  sf-ios
//
//  Created by Brian Osborn on 6/1/15.
//  Copyright (c) 2015 NGA. All rights reserved.
//

#import "SFGeometryEnvelope.h"

@implementation SFGeometryEnvelope

-(instancetype) init{
    return [self initWithHasZ:false andHasM:false];
}

-(instancetype) initWithHasZ: (BOOL) hasZ andHasM: (BOOL) hasM{
    self = [super init];
    if(self != nil){
        self.hasZ = hasZ;
        self.hasM = hasM;
    }
    return self;
}

-(instancetype) initWithMinX: (NSDecimalNumber *) minX
                     andMinY: (NSDecimalNumber *) minY
                     andMaxX: (NSDecimalNumber *) maxX
                     andMaxY: (NSDecimalNumber *) maxY{
    return [self initWithMinX:minX andMinY:minY andMinZ:nil andMinM:nil andMaxX:maxX andMaxY:maxY andMaxZ:nil andMaxM:nil];
}

-(instancetype) initWithMinXDouble: (double) minX
                     andMinYDouble: (double) minY
                     andMaxXDouble: (double) maxX
                     andMaxYDouble: (double) maxY{
    return [self initWithMinX:[[NSDecimalNumber alloc] initWithDouble:minX]
                       andMinY:[[NSDecimalNumber alloc] initWithDouble:minY]
                      andMaxX:[[NSDecimalNumber alloc] initWithDouble:maxX]
                       andMaxY:[[NSDecimalNumber alloc] initWithDouble:maxY]];
}

-(instancetype) initWithMinX: (NSDecimalNumber *) minX
                     andMinY: (NSDecimalNumber *) minY
                     andMinZ: (NSDecimalNumber *) minZ
                     andMaxX: (NSDecimalNumber *) maxX
                     andMaxY: (NSDecimalNumber *) maxY
                     andMaxZ: (NSDecimalNumber *) maxZ{
    return [self initWithMinX:minX andMinY:minY andMinZ:minZ andMinM:nil andMaxX:maxX andMaxY:maxY andMaxZ:maxZ andMaxM:nil];
}

-(instancetype) initWithMinX: (NSDecimalNumber *) minX
                     andMinY: (NSDecimalNumber *) minY
                     andMinZ: (NSDecimalNumber *) minZ
                     andMinM: (NSDecimalNumber *) minM
                     andMaxX: (NSDecimalNumber *) maxX
                     andMaxY: (NSDecimalNumber *) maxY
                     andMaxZ: (NSDecimalNumber *) maxZ
                     andMaxM: (NSDecimalNumber *) maxM{
    self = [super init];
    if(self != nil){
        self.minX = minX;
        self.minY = minY;
        self.minZ = minZ;
        self.minM = minM;
        self.maxX = maxX;
        self.maxY = maxY;
        self.maxZ = maxZ;
        self.maxM = maxM;
        self.hasZ = minZ != nil || maxZ != nil;
        self.hasM = minM != nil || maxM != nil;
    }
    return self;
}

-(BOOL) is3D{
    return _hasZ;
}

-(BOOL) isMeasured{
    return _hasM;
}

-(BOOL) intersectsWithEnvelope: (SFGeometryEnvelope *) envelope{
    return [self overlapWithEnvelope:envelope] != nil;
}

-(BOOL) intersectsWithEnvelope: (SFGeometryEnvelope *) envelope withAllowEmpty: (BOOL) allowEmpty{
    return [self overlapWithEnvelope:envelope withAllowEmpty:allowEmpty] != nil;
}

-(SFGeometryEnvelope *) overlapWithEnvelope: (SFGeometryEnvelope *) envelope{
    return [self overlapWithEnvelope:envelope withAllowEmpty:NO];
}

-(SFGeometryEnvelope *) overlapWithEnvelope: (SFGeometryEnvelope *) envelope withAllowEmpty: (BOOL) allowEmpty{
    
    double minX = MAX([self.minX doubleValue], [envelope.minX doubleValue]);
    double maxX = MIN([self.maxX doubleValue], [envelope.maxX doubleValue]);
    double minY = MAX([self.minY doubleValue], [envelope.minY doubleValue]);
    double maxY = MIN([self.maxY doubleValue], [envelope.maxY doubleValue]);
    
    SFGeometryEnvelope *overlap = nil;
    
    if((minX < maxX && minY < maxY) || (allowEmpty && minX <= maxX && minY <= maxY)){
        overlap = [[SFGeometryEnvelope alloc] initWithMinXDouble:minX andMinYDouble:minY andMaxXDouble:maxX andMaxYDouble:maxY];
    }
    
    return overlap;
}

-(SFGeometryEnvelope *) unionWithEnvelope: (SFGeometryEnvelope *) envelope{
    
    double minX = MIN([self.minX doubleValue], [envelope.minX doubleValue]);
    double maxX = MAX([self.maxX doubleValue], [envelope.maxX doubleValue]);
    double minY = MIN([self.minY doubleValue], [envelope.minY doubleValue]);
    double maxY = MAX([self.maxY doubleValue], [envelope.maxY doubleValue]);
    
    SFGeometryEnvelope *unionEnvelope = nil;
    
    if(minX < maxX && minY < maxY){
        unionEnvelope = [[SFGeometryEnvelope alloc] initWithMinXDouble:minX andMinYDouble:minY andMaxXDouble:maxX andMaxYDouble:maxY];
    }
    
    return unionEnvelope;
}

-(BOOL) containsEnvelope: (SFGeometryEnvelope *) envelope{
    return [self.minX doubleValue] <= [envelope.minX doubleValue]
        && [self.maxX doubleValue] >= [envelope.maxX doubleValue]
        && [self.minY doubleValue] <= [envelope.minY doubleValue]
        && [self.maxY doubleValue] >= [envelope.maxY doubleValue];
}

-(id) mutableCopyWithZone: (NSZone *) zone{
    SFGeometryEnvelope *envelope = [[SFGeometryEnvelope alloc] initWithMinX:self.minX andMinY:self.minY andMinZ:self.minZ andMinM:self.minM andMaxX:self.maxX andMaxY:self.maxY andMaxZ:self.maxZ andMaxM:self.maxM];
    return envelope;
}

- (void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.minX forKey:@"minX"];
    [encoder encodeObject:self.maxX forKey:@"maxX"];
    [encoder encodeObject:self.minY forKey:@"minY"];
    [encoder encodeObject:self.maxY forKey:@"maxY"];
    [encoder encodeObject:self.minZ forKey:@"minZ"];
    [encoder encodeObject:self.maxZ forKey:@"maxZ"];
    [encoder encodeObject:self.minM forKey:@"minM"];
    [encoder encodeObject:self.maxM forKey:@"maxM"];
}

- (id) initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        _minX = [decoder decodeObjectForKey:@"minX"];
        _maxX = [decoder decodeObjectForKey:@"maxX"];
        _minY = [decoder decodeObjectForKey:@"minY"];
        _maxY = [decoder decodeObjectForKey:@"maxY"];
        _minZ = [decoder decodeObjectForKey:@"minZ"];
        _maxZ = [decoder decodeObjectForKey:@"maxZ"];
        _minM = [decoder decodeObjectForKey:@"minM"];
        _maxM = [decoder decodeObjectForKey:@"maxM"];
    }
    return self;
}

- (BOOL)isEqualToGeometryEnvelope:(SFGeometryEnvelope *)geometryEnvelope {
    if (self == geometryEnvelope)
        return YES;
    if (geometryEnvelope == nil)
        return NO;
    if(self.maxM == nil){
        if(geometryEnvelope.maxM != nil)
            return NO;
    }else if(![self.maxM isEqual:geometryEnvelope.maxM]){
        return NO;
    }
    if(self.maxX == nil){
        if(geometryEnvelope.maxX != nil)
            return NO;
    }else if(![self.maxX isEqual:geometryEnvelope.maxX]){
        return NO;
    }
    if(self.maxY == nil){
        if(geometryEnvelope.maxY != nil)
            return NO;
    }else if(![self.maxY isEqual:geometryEnvelope.maxY]){
        return NO;
    }
    if(self.maxZ == nil){
        if(geometryEnvelope.maxZ != nil)
            return NO;
    }else if(![self.maxZ isEqual:geometryEnvelope.maxZ]){
        return NO;
    }
    if(self.minM == nil){
        if(geometryEnvelope.minM != nil)
            return NO;
    }else if(![self.minM isEqual:geometryEnvelope.minM]){
        return NO;
    }
    if(self.minX == nil){
        if(geometryEnvelope.minX != nil)
            return NO;
    }else if(![self.minX isEqual:geometryEnvelope.minX]){
        return NO;
    }
    if(self.minY == nil){
        if(geometryEnvelope.minY != nil)
            return NO;
    }else if(![self.minY isEqual:geometryEnvelope.minY]){
        return NO;
    }
    if(self.minZ == nil){
        if(geometryEnvelope.minZ != nil)
            return NO;
    }else if(![self.minZ isEqual:geometryEnvelope.minZ]){
        return NO;
    }
    return YES;
}

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[SFGeometryEnvelope class]]) {
        return NO;
    }
    
    return [self isEqualToGeometryEnvelope:(SFGeometryEnvelope *)object];
}

- (NSUInteger)hash {
    NSUInteger prime = 31;
    NSUInteger result = 1;
    result = prime * result + (self.hasM ? 1231 : 1237);
    result = prime * result + (self.hasZ ? 1231 : 1237);
    result = prime * result + ((self.maxM == nil) ? 0 : [self.maxM hash]);
    result = prime * result + ((self.maxX == nil) ? 0 : [self.maxX hash]);
    result = prime * result + ((self.maxY == nil) ? 0 : [self.maxY hash]);
    result = prime * result + ((self.maxZ == nil) ? 0 : [self.maxZ hash]);
    result = prime * result + ((self.minM == nil) ? 0 : [self.minM hash]);
    result = prime * result + ((self.minX == nil) ? 0 : [self.minX hash]);
    result = prime * result + ((self.minY == nil) ? 0 : [self.minY hash]);
    result = prime * result + ((self.minZ == nil) ? 0 : [self.minZ hash]);
    return result;
}

@end
