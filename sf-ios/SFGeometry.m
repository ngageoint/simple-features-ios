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

@end
