//
//  ViewController.m
//  qube-r
//
//  Created by Benjamin Humphries on 9/13/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ReceiveViewController.h"
#import "ADNavigationControllerDelegate.h"



@interface ViewController (){
    ReceiveViewController *receiveViewController;
}

@end

@implementation ViewController
@synthesize previousBarcodes;
@synthesize audioPlayer;
@synthesize session;
@synthesize nextImageName;
@synthesize scanDex,timer;
@synthesize attkProgresView,defProgressView;


-(void)transitionController:(ADTransitionController *)transitionController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
}
-(void)transitionController:(ADTransitionController *)transitionController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
}
-(void)viewWillAppear:(BOOL)animated{
    [self setupScreenSize];
    [self.transitionController setNavigationBarHidden:YES];
    [self.transitionController setToolbarHidden:YES];
    
    
    [self addScanDex];
   // [self addDisplayBox];
    
    [self setupCustomProgressViews];
   
}
-(void)setupScreenSize{
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    screenWidth = screenSize.width;
    screenHeight =screenSize.height;
}
-(void)addScanDex{
    
    scanDex = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scannerBlack0.png"]];
    isLightOn = false;
    scanDex.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    scanDex.alpha = 0.9;
  //  [self.view insertSubview:scanDex atIndex:];
    [self.view addSubview:scanDex];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(blinkScanner) userInfo:nil repeats:YES];
    
    UIButton *back = [[UIButton alloc]init];
    [back setBackgroundImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
    [back setFrame:CGRectMake(16, 12, 60, 50)];
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
    
    }
-(void)back{
    [self.transitionController popViewController];
}
-(void)setupCustomProgressViews{
    NSLog(@"called");
    //[attkProgresView removeFromSuperview];
    //[defProgressView removeFromSuperview];
    UIImage *track = [UIImage imageNamed:@"track.png"];
   // attkProgresView = [[JEProgressView alloc]init];
    [attkProgresView setTrackImage:track];
    [attkProgresView setProgressImage:[UIImage imageNamed:@"attkProgress.png"]];
   // [attkProgresView setFrame:CGRectMake(screenWidth/2, screenHeight/2, attkProgresView.frame.size.width, attkProgresView.frame.size.height)];
    
    [attkProgresView setProgress:0.2 animated:YES];
    
   // defProgressView = [[JEProgressView alloc]init];
    [defProgressView setTrackImage:track];
    [defProgressView setProgressImage:[UIImage imageNamed:@"defProgress.png"]];
   // [defProgressView setFrame:CGRectMake(screenWidth/2, screenHeight/2 - 20, defProgressView.frame.size.width, defProgressView.frame.size.height)];
    
    
    [defProgressView setProgress:0.2 animated:YES];
    
   
    [self.view addSubview:attkProgresView];
    [self.view addSubview:defProgressView];
    
    
    UIImageView *attack = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"attack.png"]];
    attack.frame = CGRectMake(attkProgresView.frame.origin.x - attack.frame.size.width/1.4,
                              attkProgresView.frame.origin.y - attack.frame.size.height/2,
                              attack.frame.size.width,
                              attack.frame.size.height);
    
    UIImageView *shield = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shield.png"]];
    shield.frame = CGRectMake(defProgressView.frame.origin.x - shield.frame.size.width/1.4,
                              defProgressView.frame.origin.y - shield.frame.size.height/2,
                              shield.frame.size.width,
                              shield.frame.size.height);
    
    [self.view addSubview:attack];
    [self.view addSubview:shield];
}
-(void)changeValue{
    
    if (attkProgresView.progress >= 1.0)
    {
        [attkProgresView setProgress:0.1 animated:YES];
        [defProgressView setProgress:1.0 animated:YES];
    }
    else
    {
        [attkProgresView setProgress:1.0 animated:YES];
        [defProgressView setProgress:0.1 animated:YES];
    }
    
}
-(void)blinkScanner{
    if (isLightOn){
        [scanDex setImage:[UIImage imageNamed:@"scannerBlack0"]];
        isLightOn = false;
    }
    else{
        [scanDex setImage:[UIImage imageNamed:@"scannerBlack2"]];
        isLightOn = true;
        [self changeValue];

    }
    }
- (void)viewDidLoad
{
    cubeGenerator = [[CubeGenerator alloc]init];
    
    [self addCamera];
   // [self addCamera];
 //   [self addDisplayLabel];
   
    self.title = @"Scanner";
    
    previousBarcodes = [[NSMutableArray alloc]initWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"previousBarcodes"]];
  //  NSLog(@"%@",previousBarcodes);
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)TEST:(UIButton *)sender {
    [self transitionToMiniGameViewController];
}
-(void)addCamera{
    
    session = [[AVCaptureSession alloc] init];
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    
    if(input) {
        // Add the input to the session
        [session addInput:input];
    } else {
        NSLog(@"error: %@", error);
        return;
        
    }
   // AVCaptureVideoPreviewLayer * _previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
    
    _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _previewLayer.bounds = self.view.bounds;
    _previewLayer.position = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    [self.view.layer addSublayer:_previewLayer];
    
    // Start the AVSession running
    [session startRunning];
    
    
   AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    // Have to add the output before setting metadata types
    [session addOutput:output];
    // What different things can we register to recognise?
   // NSLog(@"%@", [output availableMetadataObjectTypes]);
    // We're only interested in QR Codes
    [output setMetadataObjectTypes:@[AVMetadataObjectTypeUPCECode, AVMetadataObjectTypeCode39Code, AVMetadataObjectTypeCode39Mod43Code,
                                     AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode93Code, AVMetadataObjectTypeCode128Code,
                                     AVMetadataObjectTypePDF417Code, AVMetadataObjectTypeQRCode, AVMetadataObjectTypeAztecCode]];
    // This VC is the delegate. Please call us on the main queue
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    //  if ([metadata.type isEqualToString:AVMetadataObjectTypeCode128Code])
  {
        AVMetadataMachineReadableCodeObject *transform = (AVMetadataMachineReadableCodeObject *)[_previewLayer transformedMetadataObjectForMetadataObject:[metadataObjects firstObject]];
            _boundingBox.frame = transform.bounds;
        _boundingBox.hidden = NO;
        NSArray *translatedCorners = [self translatePoints:transform.corners
                                                  fromView:self.view
                                                    toView:_boundingBox];
           _boundingBox.corners = translatedCorners;
    }//bounding box

    AVMetadataMachineReadableCodeObject *transformed = (AVMetadataMachineReadableCodeObject *)[metadataObjects lastObject];
            _decodedMessage.text = [transformed stringValue];
    
     previousBarcodes = [[NSMutableArray alloc]initWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"previousBarcodes"]];
        for (int i = 0; i < [previousBarcodes count]; i++) {
           
            if ([[transformed stringValue] isEqualToString:[previousBarcodes objectAtIndex:i]])
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Oops!" message:@"You have already scanned this item!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                alert.delegate = self;
                
                if (!isShowing){
                    [alert show];
                    isShowing = true;
                }
                return;
            }
            
        }
    if ([transformed stringValue])
    {
        [timer invalidate];
        [scanDex setImage:[UIImage imageNamed:@"cubeDexGreen.png"]];
        [previousBarcodes addObject:[transformed stringValue]];
        [[NSUserDefaults standardUserDefaults]setObject:previousBarcodes forKey:@"previousBarcodes"];
        [session stopRunning];
        [self playBeep];
        
        int rand = arc4random() % 101;
        if (rand >= 25){
           // nextImageName = [cube getRandomCubeForRarity:@"random"];
           // [cube unlockCubeWithId:nextImageName];
            BattleCube * newCube = [cubeGenerator unlockRandomCube];
            [self transitionToRecieveViewControllerWithCube:newCube];

        }
        else
        {
            // RANDOM MINI game
            [self transitionToMiniGameViewController];
        }
        
    }
    
    // Start the timer which will hide the overlay
    [self startOverlayHideTimer];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    isShowing = false;
}

-(void)addDisplayLabel
{
    // Add a label to display the resultant message
    _decodedMessage = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds) - 75, CGRectGetWidth(self.view.bounds), 75)];
    _decodedMessage.numberOfLines = 0;
    _decodedMessage.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.9];
    _decodedMessage.textColor = [UIColor darkGrayColor];
    _decodedMessage.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_decodedMessage];
}

-(void)addDisplayBox
{
    _boundingBox = [[SCShapeView alloc] initWithFrame:self.view.bounds];
    _boundingBox.backgroundColor = [UIColor clearColor];
    _boundingBox.hidden = YES;
    [self.view addSubview:_boundingBox];
}

- (NSArray *)translatePoints:(NSArray *)points fromView:(UIView *)fromView toView:(UIView *)toView
{
    NSMutableArray *translatedPoints = [NSMutableArray new];
    
    // The points are provided in a dictionary with keys X and Y
    for (NSDictionary *point in points) {
        // Let's turn them into CGPoints
        CGPoint pointValue = CGPointMake([point[@"X"] floatValue], [point[@"Y"] floatValue]);
        // Now translate from one view to the other
        CGPoint translatedPoint = [fromView convertPoint:pointValue toView:toView];
        // Box them up and add to the array
        [translatedPoints addObject:[NSValue valueWithCGPoint:translatedPoint]];
    }
    
    return [translatedPoints copy];
}

- (void)startOverlayHideTimer
{
    // Cancel it if we're already running
    if(_boxHideTimer) {
        [_boxHideTimer invalidate];
    }
    
    // Restart it to hide the overlay when it fires
    _boxHideTimer = [NSTimer scheduledTimerWithTimeInterval:0.2
                                                     target:self
                                                   selector:@selector(removeBoundingBox:)
                                                   userInfo:nil
                                                    repeats:NO];
}

-(void)playBeep
{
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"scan"] ofType:@"wav"]] error:nil];
    [audioPlayer setDelegate:self];
    [audioPlayer prepareToPlay];
    [audioPlayer play];
}

- (void)removeBoundingBox:(id)sender
{
    // Hide the box and remove the decoded text
    _boundingBox.hidden = YES;
    _decodedMessage.text = @"";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)transitionToRecieveViewControllerWithCube:(BattleCube *)_cube{
    
    [timer invalidate];
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main_iPhone"
                                                  bundle:nil];
    receiveViewController = [sb instantiateViewControllerWithIdentifier:@"ReceiveViewController"];
    [receiveViewController setImageViewToImageNamed:[_cube getImageName]];
    [receiveViewController setCubeRarityNamed:[_cube getRarity]];
    [receiveViewController setCubeName:[_cube getName]];
    [receiveViewController setPopToViewController:self];
    
    ADTransition * transition = [[ADCubeTransition alloc] initWithDuration:0.45f orientation:ADTransitionTopToBottom sourceRect:self.view.frame];
    transition = [[ADFadeTransition alloc]initWithDuration:0.5f];
    [self.transitionController pushViewController:receiveViewController withTransition:transition];
    
    
}
-(void)transitionToMiniGameViewController{
    [timer invalidate];
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main_iPhone"
                                                  bundle:nil];
    MiniGameViewController *miniGameViewController = [sb instantiateViewControllerWithIdentifier:@"MiniGameViewController"];
    [miniGameViewController setPopToViewController:self];
    
    ADTransition * transition = [[ADCubeTransition alloc] initWithDuration:0.45f orientation:ADTransitionTopToBottom sourceRect:self.view.frame];
    [self.transitionController pushViewController:miniGameViewController withTransition:transition];
}

@end
