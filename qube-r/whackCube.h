//
//  whackCube.h
//  qube-r
//
//  Created by Benjamin Humphries on 9/30/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "MiniGameViewController.h"

@class MiniGameViewController;
@interface whackCube : SKScene{
    CGFloat screenWidth;
    CGFloat screenHeight;
    
    MiniGameViewController *miniGameViewController;
    SKSpriteNode *hole1;
    SKSpriteNode *hole2;
    SKSpriteNode *hole3;
    SKSpriteNode *hole4;
    SKSpriteNode *hole5;
    
    SKSpriteNode *mole;
    
    BOOL isReady;
    int whackCount;
    
    NSMutableArray *positions;
    BattleCube *resultingCube;
    
    BOOL isEnd;
}

@property (retain, nonatomic) MiniGameViewController *miniGameViewController;
@property (retain, nonatomic) SKSpriteNode *mole;

-(void)setViewController:(MiniGameViewController *)controller;
@end
