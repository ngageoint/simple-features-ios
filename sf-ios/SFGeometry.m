//
//  SFGeometry.m
//  sf-ios
//
//  Created by Brian Osborn on 6/1/15.
//  Copyright (c) 2015 NGA. All rights reserved.
//

#import "SFGeometry.h"

@implementation SFGeometry

-(instancetype) initWithType: (enum SFGeometryType) geometryType andHasZ: (BOOL) hasZ andHasM: (BOOL) hasM{
    self = [super init];
    if(self != nil){
        self.geometryType = geometryType;
        self.hasZ = hasZ;
        self.hasM = hasM;
    }
    return self;
}

-(id) mutableCopyWithZone: (NSZone *) zone{
    [NSException raise:@"Abstract" format:@"Can not copy abstract geometry"];
    return nil;
}

- (void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeInt:(int)self.geometryType forKey:@"geometryType"];
    [encoder encodeBool:self.hasZ forKey:@"hasZ"];
    [encoder encodeBool:self.hasM forKey:@"hasM"];
}

- (id) initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        _geometryType = (enum SFGeometryType)[decoder decodeIntForKey:@"geometryType"];
        _hasZ = [decoder decodeBoolForKey:@"hasZ"];
        _hasM = [decoder decodeBoolForKey:@"hasM"];
    }
    return self;
}

- (BOOL)isEqualToGeometry:(SFGeometry *)geometry {
    if (self == geometry)
        return YES;
    if (geometry == nil)
        return NO;
    if (self.geometryType != geometry.geometryType)
        return NO;
    if (self.hasM != geometry.hasM)
        return NO;
    if (self.hasZ != geometry.hasZ)
        return NO;
    return YES;
}

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[SFGeometry class]]) {
        return NO;
    }
    
    return [self isEqualToGeometry:(SFGeometry *)object];
}

- (NSUInteger)hash {
    int prime = 31;
    int result = 1;
    result = prime * result + (int)self.geometryType;
    result = prime * result + (self.hasM ? 1231 : 1237);
    result = prime * result + (self.hasZ ? 1231 : 1237);
    return result;
}

@end
