//
//  ViewController.h
//  qube-r
//
//  Created by Benjamin Humphries on 9/13/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "SCShapeView.h"
#import <AudioToolbox/AudioToolbox.h>
#import "CubeGenerator.h"
#import "ADNavigationControllerDelegate.h"
#import "ADTransitionController.h"

#import "ReceiveViewController.h"
#import "MiniGameViewController.h"

#import "JEProgressView.h"
CubeGenerator *cubeGenerator;

@class ReceiveViewController;
@class MainMenuViewController;
@interface ViewController : ADTransitioningViewController<AVCaptureMetadataOutputObjectsDelegate,AVAudioPlayerDelegate,ADTransitionControllerDelegate,UIAlertViewDelegate>
{
    AVCaptureVideoPreviewLayer *_previewLayer;
    UILabel *_decodedMessage;
    SCShapeView *_boundingBox;
    NSTimer *_boxHideTimer;
    AVCaptureSession *session;
    AVAudioPlayer* audioPlayer;
    NSString *nextImageName;
    CGFloat screenWidth;
    CGFloat screenHeight;
    UIImageView *scanDex;
    BOOL isLightOn;
    BOOL isShowing;
    NSTimer *timer;
    JEProgressView *attkProgresView;
    JEProgressView *defProgressView;
    NSTimer *progTimer;
    }

@property (retain, nonatomic)NSString *nextImageName;
@property (retain, nonatomic)NSMutableArray *previousBarcodes;
@property (retain,nonatomic) AVAudioPlayer* audioPlayer;
@property (retain, nonatomic)AVCaptureSession *session;
@property (retain, nonatomic) UIImageView *scanDex;
@property (retain, nonatomic) NSTimer *timer;

@property (strong, nonatomic) IBOutlet JEProgressView *attkProgresView;
@property (strong, nonatomic) IBOutlet JEProgressView *defProgressView;
- (void)viewDidLoad;
- (IBAction)TEST:(UIButton *)sender;
//stores the referrence to the main cubeGenerator

@end
