//
//  MatchCube.h
//  qube-r
//
//  Created by Benjamin Humphries on 9/28/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "MiniGameViewController.h"
#import "CubeGenerator.h"
#import "BattleCube.h"
#import "ViewController.h"

@class MiniGameViewController;
@interface MatchCube : SKScene{
    NSMutableArray *gridArray;
    NSMutableArray *gridImagesArray;
    NSMutableArray *cubeImageArray;
    
    CGFloat screenWidth;
    CGFloat screenHeight;
    
    MiniGameViewController *miniGameViewController;
    
    BOOL isReadyToStart;
    BOOL isCubeRevealed;
    
    SKSpriteNode *lastTappedCube;
    
    NSString *set1;
    NSString *set2;
    NSString *set3;
    NSString *set4;
    
    NSMutableArray *matchedCubes;
    BattleCube *resultingCube;
    BOOL isEnd;
    BOOL didLose;
    SKLabelNode *timerLabel;
    SKLabelNode *instruct;
}
@property (retain, nonatomic) NSMutableArray *gridArray;
@property (retain, nonatomic) NSMutableArray *gridImagesArray;
@property (retain, nonatomic) NSMutableArray *cubeImageArray;
@property (retain, nonatomic) SKSpriteNode *lastTappedCube;
@property (retain, nonatomic) MiniGameViewController *miniGameViewController;
@property (retain, nonatomic) NSString *gameover;

@property (retain, nonatomic) NSString *set1;
@property (retain, nonatomic) NSString *set2;
@property (retain, nonatomic) NSString *set3;
@property (retain, nonatomic) NSString *set4;

@property (retain, nonatomic) NSMutableArray *matchedCubes;
@property (retain, nonatomic) BattleCube *resultingCube;
@property (retain, nonatomic) SKLabelNode *timerLabel;
@property (retain, nonatomic) SKLabelNode *instruct;

-(void)setViewController:(MiniGameViewController *)controller;
@end
