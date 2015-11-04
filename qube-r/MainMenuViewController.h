//
//  MainMenuViewController.h
//  qube-r
//
//  Created by Benjamin Humphries on 9/14/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "IndexViewController.h"
#import "MultiplayerViewController.h"
#import "ADTransitionController.h"
#import "CubeGenerator.h"

#import "SKMenuScene.h"


#define AD_SYSTEM_VERSION_GREATER_THAN_7 ([[[UIDevice currentDevice] systemVersion] compare:@"7" options:NSNumericSearch] == NSOrderedDescending)
@class ViewController;
@class IndexViewController;
@class MultiplayerViewController;
@interface MainMenuViewController : ADTransitioningViewController
{
@private
    CALayer* _rotateLayer;
    NSTimer *timer;
    
}


- (IBAction)testButton:(id)sender;
@property (retain, nonatomic)NSTimer *timer;

@property(nonatomic, strong) ViewController* viewController;
@property (nonatomic, strong)IndexViewController *indexViewController;

@property (strong, nonatomic) IBOutlet UIButton *scanButton;
@property (strong, nonatomic) IBOutlet UIButton *battleButton;
@property (strong, nonatomic) IBOutlet UIButton *viewButton;


- (IBAction)scanButton:(UIButton *)sender;
- (IBAction)battleButton:(UIButton *)sender;
- (IBAction)viewButton:(UIButton *)sender;


@end
