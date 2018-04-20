//
//  SFPoint.m
//  sf-ios
//
//  Created by Brian Osborn on 6/2/15.
//  Copyright (c) 2015 NGA. All rights reserved.
//

#import "SFPoint.h"

@implementation SFPoint

-(instancetype) init{
    return [self initWithXValue:0.0 andYValue:0.0];
}

-(instancetype) initWithXValue: (double) x andYValue: (double) y{
    return [self initWithX:[[NSDecimalNumber alloc] initWithDouble:x] andY:[[NSDecimalNumber alloc] initWithDouble:y]];
}

-(instancetype) initWithX: (NSDecimalNumber *) x andY: (NSDecimalNumber *) y{
    return [self initWithHasZ:false andHasM:false andX:x andY:y];
}

-(instancetype) initWithHasZ: (BOOL) hasZ andHasM: (BOOL) hasM andX: (NSDecimalNumber *) x andY: (NSDecimalNumber *) y{
    self = [super initWithType:SF_POINT andHasZ:hasZ andHasM:hasM];
    if(self != nil){
        self.x = x;
        self.y = y;
    }
    return self;
}

-(void) setXValue: (double) x{
    self.x = [[NSDecimalNumber alloc] initWithDouble:x];
}

-(void) setYValue: (double) y{
    self.y = [[NSDecimalNumber alloc] initWithDouble:y];
}

-(void) setZValue: (double) z{
    self.z = [[NSDecimalNumber alloc] initWithDouble:z];
}

-(void) setMValue: (double) m{
    self.m = [[NSDecimalNumber alloc] initWithDouble:m];
}

-(BOOL) isEmpty{
    return NO;
}

-(BOOL) isSimple{
    return YES;
}

-(id) mutableCopyWithZone: (NSZone *) zone{
    SFPoint *point = [[SFPoint alloc] initWithHasZ:self.hasZ andHasM:self.hasM andX:self.x andY:self.y];
    [point setZ:self.z];
    [point setM:self.m];
    return point;
}

- (void) encodeWithCoder:(NSCoder *)encoder {
    [super encodeWithCoder:encoder];
    
    [encoder encodeObject:self.x forKey:@"x"];
    [encoder encodeObject:self.y forKey:@"y"];
    [encoder encodeObject:self.z forKey:@"z"];
    [encoder encodeObject:self.m forKey:@"m"];
}

- (id) initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if (self) {
        _x = [decoder decodeObjectForKey:@"x"];
        _y = [decoder decodeObjectForKey:@"y"];
        _z = [decoder decodeObjectForKey:@"z"];
        _m = [decoder decodeObjectForKey:@"m"];
    }
    return self;
}

- (BOOL)isEqualToPoint:(SFPoint *)point {
    if (self == point)
        return YES;
    if (point == nil)
        return NO;
    if (![super isEqual:point])
        return NO;
    if(self.m == nil){
        if(point.m != nil)
            return NO;
    }else if(![self.m isEqual:point.m]){
        return NO;
    }
    if(self.x == nil){
        if(point.x != nil)
            return NO;
    }else if(![self.x isEqual:point.x]){
        return NO;
    }
    if(self.y == nil){
        if(point.y != nil)
            return NO;
    }else if(![self.y isEqual:point.y]){
        return NO;
    }
    if(self.z == nil){
        if(point.z != nil)
            return NO;
    }else if(![self.z isEqual:point.z]){
        return NO;
    }
    return YES;
}

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[SFPoint class]]) {
        return NO;
    }
    
    return [self isEqualToPoint:(SFPoint *)object];
}

- (NSUInteger)hash {
    NSUInteger prime = 31;
    NSUInteger result = [super hash];
    result = prime * result + ((self.m == nil) ? 0 : [self.m hash]);
    result = prime * result + ((self.x == nil) ? 0 : [self.x hash]);
    result = prime * result + ((self.y == nil) ? 0 : [self.y hash]);
    result = prime * result + ((self.z == nil) ? 0 : [self.z hash]);
    return result;
}

@end
