//
//  MultiplayerViewController.h
//  qube-r
//
//  Created by Benjamin Humphries on 10/22/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CubeGenerator.h"
#import "BattleCube.h"
#import "ViewController.h"


@class MainMenuViewController;
@interface MultiplayerViewController : UIViewController<UIScrollViewDelegate>{
    UIScrollView *scroller;
    CGFloat screenWidth;
    CGFloat screenHeight;
    UILabel *countLabel;
    NSMutableArray *cubesInView;
    NSMutableArray *battleCubesArray;
   
}

@property (retain, nonatomic) IBOutlet UIScrollView* scroller;
@property (retain, nonatomic) UILabel *countLabel;
@property (retain, nonatomic) NSMutableArray *cubesInView;
@property (retain, nonatomic) NSMutableArray *battleCubesArray;
-(IBAction)cubeTouched:(UIButton *)sender;
@end
