//
//  SKMenuScene.h
//  qube-r
//
//  Created by Benjamin Humphries on 10/29/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <CoreMotion/CoreMotion.h>
#import "MainMenuViewController.h"

@class MainMenuViewController;
@interface SKMenuScene : SKScene<SKPhysicsContactDelegate>{
    CGFloat screenWidth;
    CGFloat screenHeight;
    CMMotionManager* motionManager;
    
    SKSpriteNode *titleButton;
    SKSpriteNode *scanButton;
    SKSpriteNode *battleButton;
    SKSpriteNode *cubesButton;
    SKSpriteNode *faceBookButton;
    SKSpriteNode *twitterButton;
    
    MainMenuViewController *mainMenuViewController;
    BOOL isGravity;
    
}
@property (strong) CMMotionManager *motionManager;
@property (retain, nonatomic) MainMenuViewController *mainMenuViewController;
@property (assign) BOOL isGravity;

-(void)setMainMenuViewController:(MainMenuViewController *)_mainMenuViewController;

@end
