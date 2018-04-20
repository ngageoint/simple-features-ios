//
//  SFCompoundCurve.m
//  sf-ios
//
//  Created by Brian Osborn on 6/2/15.
//  Copyright (c) 2015 NGA. All rights reserved.
//

#import "SFCompoundCurve.h"
#import "SFShamosHoey.h"
#import "SFGeometryUtils.h"

@implementation SFCompoundCurve

-(instancetype) init{
    self = [self initWithHasZ:false andHasM:false];
    return self;
}

-(instancetype) initWithHasZ: (BOOL) hasZ andHasM: (BOOL) hasM{
    self = [super initWithType:SF_COMPOUNDCURVE andHasZ:hasZ andHasM:hasM];
    if(self != nil){
        self.lineStrings = [[NSMutableArray alloc] init];
    }
    return self;
}

-(instancetype) initWithLineStrings: (NSMutableArray<SFLineString *> *) lineStrings{
    self = [self initWithHasZ:[SFGeometryUtils hasZ:lineStrings] andHasM:[SFGeometryUtils hasM:lineStrings]];
    if(self != nil){
        [self setLineStrings:lineStrings];
    }
    return self;
}

-(instancetype) initWithLineString: (SFLineString *) lineString{
    self = [self initWithHasZ:lineString.hasZ andHasM:lineString.hasM];
    if(self != nil){
        [self addLineString:lineString];
    }
    return self;
}

-(void) addLineString: (SFLineString *) lineString{
    [self.lineStrings addObject:lineString];
}

-(void) addLineStrings: (NSArray<SFLineString *> *) lineStrings{
    [self.lineStrings addObjectsFromArray:lineStrings];
}

-(int) numLineStrings{
    return (int)self.lineStrings.count;
}

-(SFLineString *) lineStringAtIndex: (int) n{
    return [self.lineStrings objectAtIndex:n];
}

-(SFPoint *) startPoint{
    SFPoint *startPoint = nil;
    if (![self isEmpty]) {
        for (SFLineString *lineString in self.lineStrings) {
            if (![lineString isEmpty]) {
                startPoint = [lineString startPoint];
                break;
            }
        }
    }
    return startPoint;
}

-(SFPoint *) endPoint{
    SFPoint *endPoint = nil;
    if (![self isEmpty]) {
        for (int i = (int)self.lineStrings.count - 1; i >= 0; i--) {
            SFLineString *lineString = [self.lineStrings objectAtIndex:i];
            if (![lineString isEmpty]) {
                endPoint = [lineString endPoint];
                break;
            }
        }
    }
    return endPoint;
}

-(BOOL) isEmpty{
    return self.lineStrings.count == 0;
}

-(BOOL) isSimple{
    return [SFShamosHoey simplePolygonRings:self.lineStrings];
}

-(id) mutableCopyWithZone: (NSZone *) zone{
    SFCompoundCurve *compoundCurve = [[SFCompoundCurve alloc] initWithHasZ:self.hasZ andHasM:self.hasM];
    for(SFLineString *lineString in self.lineStrings){
        [compoundCurve addLineString:[lineString mutableCopy]];
    }
    return compoundCurve;
}

- (void) encodeWithCoder:(NSCoder *)encoder {
    [super encodeWithCoder:encoder];
    
    [encoder encodeObject:self.lineStrings forKey:@"lineStrings"];
}

- (id) initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if (self) {
        _lineStrings = [decoder decodeObjectForKey:@"lineStrings"];
    }
    return self;
}

- (BOOL)isEqualToCompoundCurve:(SFCompoundCurve *)compoundCurve {
    if (self == compoundCurve)
        return YES;
    if (compoundCurve == nil)
        return NO;
    if (![super isEqual:compoundCurve])
        return NO;
    if (self.lineStrings == nil) {
        if (compoundCurve.lineStrings != nil)
            return NO;
    } else if (![self.lineStrings isEqual:compoundCurve.lineStrings])
        return NO;
    return YES;
}

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[SFCompoundCurve class]]) {
        return NO;
    }
    
    return [self isEqualToCompoundCurve:(SFCompoundCurve *)object];
}

- (NSUInteger)hash {
    NSUInteger prime = 31;
    NSUInteger result = [super hash];
    result = prime * result
        + ((self.lineStrings == nil) ? 0 : [self.lineStrings hash]);
    return result;
}

@end
