//
//  MiniGameViewController.h
//  qube-r
//
//  Created by Benjamin Humphries on 9/27/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "ReceiveViewController.h"
#import "MainMenuViewController.h"
#import "ADNavigationControllerDelegate.h"
#import "ADTransitionController.h"

#import "ShuffleCube.h"
#import "MatchCube.h"
#import "whackCube.h"

@class ReceiveViewController;
@class ViewController;
@interface MiniGameViewController : ADTransitioningViewController {
    BOOL isFirstTime;
    UIStoryboard*  sb;
    ReceiveViewController *receiveViewController;
    ADTransition * transition;
    ViewController *viewController;
   
}
@property (retain, nonatomic) UIStoryboard*  sb;
@property (retain, nonatomic) ReceiveViewController *receiveViewController;
@property (retain, nonatomic) ADTransition * transition;
@property (retain, nonatomic) ViewController *viewController;
-(void)transitionToRecieveViewControllerForCube:(BattleCube *)_cube;
-(void)setPopToViewController:(ViewController *)v;
@end
