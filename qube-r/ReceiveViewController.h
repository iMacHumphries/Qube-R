//
//  ReceiveViewController.h
//  qube-r
//
//  Created by Benjamin Humphries on 9/14/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "MiniGameViewController.h"
#import "ADNavigationControllerDelegate.h"
#import "ADTransitionController.h"
#import "JEProgressView.h"

@class ViewController;
@interface ReceiveViewController : UIViewController{
    NSString *cubeName;
    NSString *rarity;
    NSString *imageName;
    float attk;
    float def;
    UIImageView *scanDex;
    BOOL isLightOn;

    CGFloat screenWidth;
    CGFloat screenHeight;
    NSTimer *timer;
    ViewController *viewController;
    
    JEProgressView *attackProgresView;
    JEProgressView *defProgressView;
    
}
- (IBAction)dismissButton:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIImageView *cubeView;
@property (strong, nonatomic) IBOutlet UILabel *rarityLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@property (retain, nonatomic) NSString *cubeName;
@property (retain, nonatomic) NSString *imageName;
@property (retain, nonatomic) NSString *rarity;
@property (assign) float attk;
@property (assign) float def;

@property (retain, nonatomic) UIImageView *light;
@property (retain, nonatomic) UIImageView *scanDex;
@property (retain,nonatomic) NSTimer *timer;
@property (retain, nonatomic) ViewController *viewController;


@property (strong, nonatomic) IBOutlet JEProgressView *attackProgresView;
@property (strong, nonatomic) IBOutlet JEProgressView *defProgressView;



-(void)setImageViewToImageNamed:(NSString *)name;
-(void)setCubeRarityNamed:(NSString *)rare;
-(void)setCubeName:(NSString *)cube;
-(void)setPopToViewController:(ViewController *)v;
@end
