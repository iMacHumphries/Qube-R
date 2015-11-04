//
//  SKCube.h
//  qube-r
//
//  Created by Benjamin Humphries on 10/21/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SKCube : SKSpriteNode<NSCoding>{
    NSString *name;
    NSString *rarity;
    NSString *imageName;
    int ID;
    NSMutableArray *IDArray;
    BOOL isUnlocked;
}
@property (retain, nonatomic) NSString *name;
@property (retain, nonatomic) NSString *rarity;
@property (retain, nonatomic) NSString *imageName;
@property (assign) int ID;
@property (retain, nonatomic) NSMutableArray *IDArray;
@property (assign) BOOL isUnlocked;


-(NSString *)getID;
-(NSString *)getName;
-(NSString *)getRarity;
-(NSString *)getImageName;
-(BOOL)getIsUnlocked;

-(id)initWithName:(NSString *)_name rarity:(NSString *)_rarity imageNamed:(NSString *)_imageName isUnlocked:(BOOL)_isUnlocked;
@end
