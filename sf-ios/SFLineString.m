//
//  SFLineString.m
//  sf-ios
//
//  Created by Brian Osborn on 6/2/15.
//  Copyright (c) 2015 NGA. All rights reserved.
//

#import "SFLineString.h"
#import "SFShamosHoey.h"

@implementation SFLineString

-(instancetype) init{
    self = [self initWithHasZ:false andHasM:false];
    return self;
}

-(instancetype) initWithHasZ: (BOOL) hasZ andHasM: (BOOL) hasM{
    return [self initWithType:SF_LINESTRING andHasZ:hasZ andHasM:hasM];
}

-(instancetype) initWithType: (enum SFGeometryType) geometryType andHasZ: (BOOL) hasZ andHasM: (BOOL) hasM{
    self = [super initWithType:geometryType andHasZ:hasZ andHasM:hasM];
    if(self != nil){
        self.points = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void) addPoint: (SFPoint *) point{
    [self.points addObject:point];
}

-(void) addPoints: (NSArray<SFPoint *> *) points{
    [self.points addObjectsFromArray:points];
}

-(int) numPoints{
    return (int)self.points.count;
}

-(SFPoint *) pointAtIndex: (int) n{
    return [self.points objectAtIndex:n];
}

-(SFPoint *) startPoint{
    SFPoint *startPoint = nil;
    if (![self isEmpty]) {
        startPoint = [self.points objectAtIndex:0];
    }
    return startPoint;
}

-(SFPoint *) endPoint{
    SFPoint *endPoint = nil;
    if (![self isEmpty]) {
        endPoint = [self.points objectAtIndex:self.points.count - 1];
    }
    return endPoint;
}

-(BOOL) isEmpty{
    return self.points.count == 0;
}

-(BOOL) isSimple{
    return [SFShamosHoey simplePolygonPoints:self.points];
}

-(id) mutableCopyWithZone: (NSZone *) zone{
    SFLineString *lineString = [[SFLineString alloc] initWithHasZ:self.hasZ andHasM:self.hasM];
    for(SFPoint *point in self.points){
        [lineString addPoint:[point mutableCopy]];
    }
    return lineString;
}

- (void) encodeWithCoder:(NSCoder *)encoder {
    [super encodeWithCoder:encoder];
    
    [encoder encodeObject:self.points forKey:@"points"];
}

- (id) initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if (self) {
        _points = [decoder decodeObjectForKey:@"points"];
    }
    return self;
}

- (BOOL)isEqualToLineString:(SFLineString *)lineString {
    if (self == lineString)
        return YES;
    if (lineString == nil)
        return NO;
    if (![super isEqual:lineString])
        return NO;
    if (self.points == nil) {
        if (lineString.points != nil)
            return NO;
    } else if (![self.points isEqual:lineString.points])
        return NO;
    return YES;
}

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[SFLineString class]]) {
        return NO;
    }
    
    return [self isEqualToLineString:(SFLineString *)object];
}

- (NSUInteger)hash {
    NSUInteger prime = 31;
    NSUInteger result = [super hash];
    result = prime * result
        + ((self.points == nil) ? 0 : [self.points hash]);
    return result;
}

@end
