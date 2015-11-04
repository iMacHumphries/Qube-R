//
//  BattleCube.h
//  qube-r
//
//  Created by Benjamin Humphries on 10/21/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import "SKCube.h"
#import "Attack.h"

@interface BattleCube : SKCube<NSCoding>{
    
    float speed;   //who goes first
    float health;
    
    Attack *attack1;
    Attack *attack2;
    Attack *attack3;
    Attack *attack4;
    
    BOOL isAlive;
    
}
@property (assign) float speed;
@property (assign) float health;
@property (assign) BOOL isAlive;

@property (retain,nonatomic) Attack *attack1;
@property (retain,nonatomic) Attack *attack2;
@property (retain,nonatomic) Attack *attack3;
@property (retain,nonatomic) Attack *attack4;

-(float)getHealth;
-(float)getSpeed;
-(BOOL)getIsAlive;
-(Attack *)getAttack1;
-(Attack *)getAttack2;
-(Attack *)getAttack3;
-(Attack *)getAttack4;

-(void)setAttack1:(Attack *)_attack;
-(void)setAttack2:(Attack *)_attack;
-(void)setAttack3:(Attack *)_attack;
-(void)setAttack4:(Attack *)_attack;

-(void)attackCube:(BattleCube *)_cube withAttack:(Attack *)_attack;
-(void)dealDamage:(float)_damage;

-(id)initWithName:(NSString *)_name rarity:(NSString *)_rarity imageNamed:(NSString *)_imageName health:(float)_health speed:(float)_speed isUnlocked:(BOOL)_isUnlocked;
@end
