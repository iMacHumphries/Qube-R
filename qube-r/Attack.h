//
//  Attack.h
//  qube-r
//
//  Created by Benjamin Humphries on 10/21/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Attack : NSObject <NSCoding>{
    NSString *name;
    NSString *info;
    
    float damage;
    float accuracy;
    float critChance;
    
    int PP;
    int PPUsed;
}
@property (retain, nonatomic) NSString *name;
@property (retain, nonatomic) NSString *info;

@property (assign) float damage;
@property (assign) float accuracy;
@property (assign) float critChance;



@property (assign)int PP;
@property (assign)int PPUsed;

-(float)getDamage;
-(float)getAccuracy;
-(float)getCritChance;
-(NSString *)getName;
-(NSString *)getInfo;
-(int)getPP;
-(int)getPPUsed;

-(BOOL)isSuccessful;
-(BOOL)isCriticalHit;

-(id)initWithName:(NSString *)_name info:(NSString *)_info  PP:(int)_PP Damage:(float)_damage accuracy:(float)_accuracy critChance:(float)_critChance;
@end
