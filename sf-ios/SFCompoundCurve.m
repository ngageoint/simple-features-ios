//
//  SFCompoundCurve.m
//  sf-ios
//
//  Created by Brian Osborn on 6/2/15.
//  Copyright (c) 2015 NGA. All rights reserved.
//

#import "SFCompoundCurve.h"

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

-(void) addLineString: (SFLineString *) lineString{
    [self.lineStrings addObject:lineString];
}

-(NSNumber *) numLineStrings{
    return [NSNumber numberWithInteger:[self.lineStrings count]];
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

@end
