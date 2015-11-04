//
//  Player.m
//  qube-r
//
//  Created by Benjamin Humphries on 10/22/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import "Player.h"

@implementation Player
@synthesize name;
@synthesize cubes;

-(id)initWithName:(NSString *)_name cubes:(NSMutableArray *)_cubes{
    
    self = [super init];
    
    self.name = _name;
    self.cubes = [[NSMutableArray alloc]initWithArray:_cubes];
    
    return self;
}
-(NSString *)getName{
    return self.name;
}
-(NSMutableArray *)getCubes{
    return self.cubes;
}
-(void)setCubes:(NSMutableArray *)_cubes{
    self.cubes = _cubes;
}
-(int)countOfLivingCubes{
    int count = 0;
    
    for (int i = 0; i < [self.cubes count]; i++)
    {
        BattleCube *cube = (BattleCube *)[cubes objectAtIndex:i];
        if (cube.isAlive)
            count++;
    }
    return count;
}
-(BattleCube *)getCubeAtIndex:(int)_index{
    return (BattleCube *)[self.cubes objectAtIndex:_index];
}
@end
