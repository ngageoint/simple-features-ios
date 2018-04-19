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

-(id) mutableCopyWithZone: (NSZone *) zone{
    SFPoint *point = [[SFPoint alloc] initWithHasZ:self.hasZ andHasM:self.hasM andX:self.x andY:self.y];
    [point setZ:self.z];
    [point setM:self.m];
    return point;
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

@end
