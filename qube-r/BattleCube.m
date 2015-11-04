//
//  BattleCube.m
//  qube-r
//
//  Created by Benjamin Humphries on 10/21/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import "BattleCube.h"

@implementation BattleCube
@synthesize speed,health,isAlive;
@synthesize attack1,attack2,attack3,attack4;

-(id)initWithName:(NSString *)_name rarity:(NSString *)_rarity imageNamed:(NSString *)_imageName health:(float)_health speed:(float)_speed isUnlocked:(BOOL)_isUnlocked{
    
    self = [super initWithName:_name rarity:_rarity imageNamed:_imageName isUnlocked:_isUnlocked];
    self.speed = _speed;
    self.health = _health;
    
    isAlive = true;
    
    return self;
}

-(void)attackCube:(BattleCube *)_cube withAttack:(Attack *)_attack{
    if (_attack.isSuccessful)
    {
        
        float damage = _attack.damage;
        if (_attack.isCriticalHit)
        {
            NSLog(@"Critical Attack");
            damage *= 2;
        }
        NSLog(@"Dealing Damage: %f",damage);
        [_cube dealDamage:damage];
       
    
    }
    else {
        NSLog(@"Attack Failed");
    }
}
-(void)dealDamage:(float)_damage{
    self.health -= _damage;
    if (!self.isAlive)
    {
        NSLog(@"cube is dead");
    }
}
//getters
-(BOOL)getIsAlive{
    BOOL result = true;
    if (self.health <= 0)
        isAlive = false;
    return result;
}
-(float)getHealth{
    return self.health;
}
-(float)getSpeed{
    return self.speed;
}
-(Attack *)getAttack1{
    return self.attack1;
}
-(Attack *)getAttack2{
    return self.attack2;
}
-(Attack *)getAttack3{
    return self.attack3;
}
-(Attack *)getAttack4{
    return self.attack4;
}


-(void)setAttack1:(Attack *)_attack{
    self.attack1 = _attack;
}
-(void)setAttack2:(Attack *)_attack{
    self.attack2 = _attack;
}
-(void)setAttack3:(Attack *)_attack{
    self.attack3 = _attack;
}
-(void)setAttack4:(Attack *)_attack{
    self.attack4 = _attack;
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.name = [decoder decodeObjectForKey:@"name"];
        self.imageName = [decoder decodeObjectForKey:@"imageName"];
        self.rarity = [decoder decodeObjectForKey:@"rarity"];
        self.isUnlocked = [decoder decodeBoolForKey:@"isUnlocked"];
        self.health = [decoder decodeFloatForKey:@"health"];
        self.speed = [decoder decodeFloatForKey:@"speed"];
        //self.attack1 = [decoder decodeObjectForKey:@"attack1"];
        //self.attack2 = [decoder decodeObjectForKey:@"attack2"];
        //self.attack3 = [decoder decodeObjectForKey:@"attack3"];
        //self.attack4 = [decoder decodeObjectForKey:@"attack4"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:name forKey:@"name"];
    [encoder encodeObject:imageName forKey:@"imageName"];
     [encoder encodeObject:rarity forKey:@"rarity"];
    [encoder encodeBool:isUnlocked forKey:@"isUnlocked"];
    [encoder encodeFloat:health forKey:@"health"];
    [encoder encodeFloat:speed forKey:@"speed"];
    //[encoder encodeObject:attack1 forKey:@"attack1"];
    //[encoder encodeObject:attack2 forKey:@"attack2"];
    //[encoder encodeObject:attack3 forKey:@"attack3"];
    //[encoder encodeObject:attack4 forKey:@"attack4"];
}

@end
