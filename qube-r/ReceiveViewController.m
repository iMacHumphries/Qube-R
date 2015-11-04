//
//  ReceiveViewController.m
//  qube-r
//
//  Created by Benjamin Humphries on 9/14/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import "ReceiveViewController.h"

@interface ReceiveViewController ()

@end

@implementation ReceiveViewController
@synthesize cubeView,rarityLabel;
@synthesize cubeName;
@synthesize rarity;
@synthesize imageName;
@synthesize attk,def;
@synthesize nameLabel;
@synthesize light;
@synthesize scanDex;
@synthesize timer;
@synthesize viewController;
@synthesize attackProgresView,defProgressView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    
    [self.transitionController setNavigationBarHidden:YES];
    [self.transitionController setToolbarHidden:YES];
    
    
}
- (void)viewDidLoad
{
    cubeView.image = [UIImage imageNamed:imageName];
    rarityLabel.text = rarity;
    nameLabel.text = cubeName;
    [self setupScreenSize];
    [self addScanDex];
    [self setupCustomProgressViews];
   
    [super viewDidLoad];
    
    NSLog(@"texts:%@",nameLabel.text);
    // Do any additional setup after loading the view.
}
-(void)setupScreenSize{
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    screenWidth = screenSize.width;
    screenHeight =screenSize.height;
}
-(void)addScanDex{
    
    scanDex = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scannerBlack0.png"]];
    scanDex.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    isLightOn = false;
    scanDex.alpha = 0.9;
    //[self.view addSubview:scanDex];
    [self.view insertSubview:scanDex atIndex:1];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(blinkScanner) userInfo:nil repeats:YES];
}
-(void)setupCustomProgressViews{
    UIImage *track = [UIImage imageNamed:@"track.png"];
    [attackProgresView setTrackImage:track];
    [attackProgresView setProgressImage:[UIImage imageNamed:@"attkProgress.png"]];
    
    [attackProgresView setProgress:self.attk];
    
    [defProgressView setTrackImage:track];
    [defProgressView setProgressImage:[UIImage imageNamed:@"defProgress.png"]];
    
    [defProgressView setProgress:self.def];
    
}
-(void)blinkScanner{
    if (isLightOn){
        [scanDex setImage:[UIImage imageNamed:@"scannerBlack0.png"]];
        isLightOn = false;
    }
    else{
        [scanDex setImage:[UIImage imageNamed:@"scannerBlack1.png"]];
        isLightOn = true;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
       // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
   
}


- (IBAction)dismissButton:(UIButton *)sender {
   [self.transitionController dismissViewControllerAnimated:YES completion:^{
       
   }]; 
}


- (void)moveImage:(UIImageView *)image duration:(NSTimeInterval)duration
            curve:(int)curve x:(CGFloat)x y:(CGFloat)y
{
    // Setup the animation
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:curve];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    // The transform matrix
    CGAffineTransform transform = CGAffineTransformMakeTranslation(x, y);
    light.transform = transform;
    
    // Commit the changes
    [UIView commitAnimations];
    
}
-(void)setImageViewToImageNamed:(NSString *)name{
    imageName = name;
}
-(void)setCubeRarityNamed:(NSString *)rare{
    rarity = rare;
}
-(void)setCubeName:(NSString *)cube{
    cubeName = cube;
}
-(void)setattack:(float)_attk{
    self.attk = _attk;
}
-(void)setDeffence:(float)_def{
    self.def = _def;
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.transitionController popToViewController:viewController];
    
    if (!viewController) {
        [self.transitionController popViewController];
    }
    
   
}

-(void)setPopToViewController:(ViewController *)v {
    viewController = v;
}
@end
