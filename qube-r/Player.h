//
//  Player.h
//  qube-r
//
//  Created by Benjamin Humphries on 10/22/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BattleCube.h"

@interface Player : NSObject{
    NSString *name;
    NSMutableArray *cubes;
}
@property (retain, nonatomic) NSString *name;
@property (retain, nonatomic) NSMutableArray *cubes;

-(NSString *)getName;
-(NSMutableArray *)getCubes;
-(void)setCubes:(NSMutableArray *)_cubes;
-(int)countOfLivingCubes;
-(BattleCube *)getCubeAtIndex:(int)_index;

-(id)initWithName:(NSString *)_name cubes:(NSMutableArray *)_cubes;
@end
