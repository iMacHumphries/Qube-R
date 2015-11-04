//
//  Attack.m
//  qube-r
//
//  Created by Benjamin Humphries on 10/21/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import "Attack.h"

@implementation Attack
@synthesize damage,accuracy,critChance;
@synthesize name,info,PP,PPUsed;

-(id)initWithName:(NSString *)_name info:(NSString *)_info  PP:(int)_PP Damage:(float)_damage accuracy:(float)_accuracy critChance:(float)_critChance{
    
    self = [super init];
    
    self.name = _name;
    self.info = _info;
    self.PP = _PP;
    self.PPUsed = 0;
    
    self.damage = _damage;
    self.accuracy = _accuracy;
    self.critChance = _critChance;
    
    return self;
}
-(BOOL)isSuccessful{
    int rand = (arc4random() % 100) +1;
    int chance = self.accuracy *100;
    BOOL result = false;
    if (rand <= chance)
        result = true;
    return result;
}
-(BOOL)isCriticalHit{
    int rand = (arc4random() % 100) +1;
    int chance = self.critChance * 100;
    BOOL result = false;
    if (rand <= chance)
        result = true;
    return result;
}
//getters
-(float)getDamage{
    return self.damage;
}
-(float)getAccuracy{
    return self.accuracy;
}
-(float)getCritChance{
    return self.critChance;
}
-(NSString *)getName{
    return self.name;
}
-(NSString *)getInfo{
    return self.info;
}
-(int)getPP{
    return self.PP;
}
-(int)getPPUsed{
    return self.PPUsed;
}
- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.name = [decoder decodeObjectForKey:@"name"];
        self.info  = [decoder decodeObjectForKey:@"info"];
        self.PP = [decoder decodeIntForKey:@"PP"];
        self.damage = [decoder decodeFloatForKey:@"damage"];
        self.accuracy = [decoder decodeFloatForKey:@"accuracy"];
        self.critChance = [decoder decodeFloatForKey:@"critChance"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:name forKey:@"name"];
    [encoder encodeObject:info forKey:@"info"];
    [encoder encodeInt:PP forKey:@"PP"];
    [encoder encodeFloat:damage forKey:@"damage"];
    [encoder encodeFloat:accuracy forKey:@"accuracy"];
    [encoder encodeFloat:critChance forKey:@"critChance"];
}
@end
