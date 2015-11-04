//
//  IndexViewController.h
//  qube-r
//
//  Created by Benjamin Humphries on 9/16/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADTransitionController.h"
#import "ReceiveViewController.h"
#import "CubeGenerator.h"
#import "JEProgressView.h"

@class ReceiveViewController;
@interface IndexViewController : ADTransitioningViewController<UIScrollViewDelegate>{
    CGFloat screenWidth;
    CGFloat screenHeight;
    UILabel *countLabel;
    UIButton *buttonCube;
    BOOL isCubeDex;
    NSMutableArray *cubesInView;
    NSTimer *timer;
    IBOutlet JEProgressView *progress;
    
}
@property (retain, nonatomic)IBOutlet UILabel *progLabel;
@property (retain, nonatomic) IBOutlet JEProgressView *progress;
@property (strong, nonatomic) IBOutlet UIScrollView *scroller;
@property (retain, nonatomic) UILabel *countLabel;
@property (retain, nonatomic) UIButton *buttonCube;
@property (retain, nonatomic) UIBarButtonItem *cubeDexItem;
@property (retain, nonatomic) NSMutableArray *cubesInView;
@property (retain, nonatomic) NSTimer *timer;
-(IBAction)cubeTouched:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *back;
@property (strong, nonatomic) IBOutlet UIButton *info;
- (IBAction)info:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIImageView *indexRibbon;
- (IBAction)back:(UIButton *)sender;


@end
