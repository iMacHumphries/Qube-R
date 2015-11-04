//
//  CubeGenerator.h
//  qube-r
//
//  Created by Benjamin Humphries on 10/30/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKCube.h"
#import "BattleCube.h"

@interface CubeGenerator : NSObject{
    NSMutableArray *commons;
    NSMutableArray *uncommons;
    NSMutableArray *rares;
    NSMutableArray *ultraRares;
    NSMutableDictionary *dic;
}
@property (retain, nonatomic)NSMutableArray *commons;
@property (retain, nonatomic)NSMutableArray *uncommons;
@property (retain, nonatomic)NSMutableArray *rares;
@property (retain, nonatomic)NSMutableArray *ultraRares;
@property (retain, nonatomic)NSMutableDictionary *dic;

-(BattleCube *)unlockRandomCube;
-(NSInteger)getTotalCubes;
-(NSInteger)getTotalCubesUnlocked;
-(int)getTotalCubesNamed:(NSString *)_name;
-(BattleCube *)getRandomCubeForRarity:(NSString *)r;
-(BattleCube *)unlockCube:(BattleCube *)_cube;
@end
