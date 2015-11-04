//
//  ShuffleCube.h
//  qube-r
//
//  Created by Benjamin Humphries on 9/27/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "MiniGameViewController.h"
#import "CubeGenerator.h"
#import "BattleCube.h"

@class MiniGameViewController;
@interface ShuffleCube : SKScene{
    SKSpriteNode *cube0;
    SKSpriteNode *cube1;
    SKSpriteNode *cube2;
    
    NSMutableArray *cubesArray;
    
    CGFloat screenWidth;
    CGFloat screenHeight;
    
    BattleCube *battleCube1;
    BattleCube *battleCube2;
    
    BOOL isGameOver;
    BOOL isReady;
    BOOL isEnd;
    
    SKSpriteNode *readyButton;
    SKSpriteNode *button;
    SKLabelNode *label;
    SKLabelNode *tapToContinueLabel;
    
    BattleCube *resultingCube;
    
    MiniGameViewController *miniGameViewController;
    
    
}
@property (retain, nonatomic) SKSpriteNode *cube0;
@property (retain, nonatomic) SKSpriteNode *cube1;
@property (retain, nonatomic) SKSpriteNode *cube2;

@property (retain, nonatomic) NSMutableArray *cubesArray;

@property (retain, nonatomic) BattleCube *battleCube1;
@property (retain, nonatomic) BattleCube *battleCube2;

@property (retain, nonatomic) SKSpriteNode *readyButton;
@property (retain, nonatomic) SKSpriteNode *button;
@property (retain, nonatomic) SKLabelNode *label;
@property (retain, nonatomic) SKLabelNode *tapToContinueLabel;

@property (retain, nonatomic) BattleCube *resultingCube;

@property (retain, nonatomic) MiniGameViewController *miniGameViewController;



-(void)setViewController:(MiniGameViewController *)controller;
@end
