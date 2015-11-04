//
//  IndexViewController.m
//  qube-r
//
//  Created by Benjamin Humphries on 9/16/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import "IndexViewController.h"
#import "ReceiveViewController.h"


@interface IndexViewController ()

@end

@implementation IndexViewController
@synthesize scroller;
@synthesize countLabel;
@synthesize buttonCube;
@synthesize cubeDexItem;
@synthesize cubesInView;
@synthesize timer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    
    [self.transitionController setNavigationBarHidden:NO];
    [self.transitionController setToolbarHidden:NO];
    
    
}
- (void)viewDidLoad
{
    [self setupScreenSize];
    //cubeDexItem = [[UIBarButtonItem alloc]initWithTitle:@"QubeDex" style:UIBarButtonItemStyleBordered target:self action:@selector(switchView)];
   // self.navigationItem.rightBarButtonItem = cubeDexItem;

    
    cubesInView = [[NSMutableArray alloc]init];
    
    [self setupIndex];

    [super viewDidLoad];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(chooseButtonToBounce) userInfo:nil repeats:YES];
    
    // Do any additional setup after loading the view.
}
-(void)setupScreenSize{
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    screenWidth = screenSize.width;
    screenHeight =screenSize.height;

}
-(void)switchView{
    if (isCubeDex)
    {
        isCubeDex = false;
        cubeDexItem.title = @"QubeDex";
        self.title = @"My Qubes";
    }
    else
    {
        isCubeDex = true;
        cubeDexItem.title = @"My Qubes";
        self.title = @"QubeDex";

    }
    [scroller removeFromSuperview];
    cubesInView = [[NSMutableArray alloc]init];
    [self setupIndex];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)setupIndex{
    CubeGenerator *cubeGenerator = [[CubeGenerator alloc]init];
    self.scroller = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, screenWidth,screenHeight)];
    self.scroller.userInteractionEnabled = YES;
    
    if (!isCubeDex) self.scroller.contentSize = CGSizeMake(320, (([cubeGenerator getTotalCubesUnlocked] * 120) ) /3);
    else self.scroller.contentSize = CGSizeMake(320, (([cubeGenerator getTotalCubes] * 120) ) /3);
    self.scroller.delegate = self;
    [self addParallax];
    
    int xPosition = 32;
    int yPosition = 49;
    [self.view addSubview:self.scroller];
    
   // NSArray *unlockedArray = [[NSUserDefaults standardUserDefaults]objectForKey:@"gameData"];
   // NSLog(@"UNlockedARR:: %@",unlockedArray);
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"gameData"];
    NSArray *gameData = [[NSArray alloc]initWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:data]];

    for (int index = 0; index < [gameData count]; index ++)
    {
        
       // BattleCube *cube = [gameData objectForKey:[NSString stringWithFormat:@"%i",index]];
        BattleCube *cube = [gameData objectAtIndex:index];
        NSString *imageName = [cube getImageName];
        NSString *cubeID = [cube getID];
        int cubeCount = 0;
        for (int i = 0; i < [gameData count]; i++)
        {
            if ([[[gameData objectAtIndex:i] getName] isEqualToString:[[gameData objectAtIndex:index] getName]])
                    cubeCount++;
            
        }

        NSLog(@"cube count: %i",cubeCount);
    //    BOOL unlock = [cube getIsUnlocked];
        
        
        UIImage *image = [UIImage imageNamed:imageName];
        UIImageView *labelBack = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"back.png"]];
        [labelBack setFrame:CGRectMake(0, 0, 20, 20)];
        NSLog(@"scroller : %f",scroller.frame.size.height);
        
        countLabel = [[UILabel alloc]initWithFrame:CGRectMake(5,-5, 80, 30)];
        countLabel.textColor = [UIColor whiteColor];
        [countLabel setFont:[UIFont fontWithName:@"Impact" size:20]];
        
            buttonCube = [[UIButton alloc]initWithFrame:CGRectMake(xPosition, yPosition, 80, 80)];
            [buttonCube setBackgroundImage:image forState:UIControlStateNormal];
            [buttonCube setTag:[cubeID integerValue]];
            [buttonCube addTarget:self action:@selector(cubeTouched:) forControlEvents:UIControlEventTouchUpInside];
                if (cubeCount > 0)
                {
                    countLabel.text = [NSString stringWithFormat:@"%i",cubeCount];
                    [labelBack addSubview:countLabel];
                    [buttonCube addSubview:labelBack];
                }
        
        if(![buttonCube isDescendantOfView:scroller]) {
            [self.scroller addSubview:buttonCube];

        }
        
                xPosition += 88;
                if (xPosition > 208)
                {
                    xPosition = 32;
                    yPosition += 95;
                }
    }
    
}
-(void)addParallax{
    
    // Set vertical effect
    UIInterpolatingMotionEffect *verticalMotionEffect =
    [[UIInterpolatingMotionEffect alloc]
     initWithKeyPath:@"center.y"
     type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    verticalMotionEffect.minimumRelativeValue = @(-10);
    verticalMotionEffect.maximumRelativeValue = @(10);
    
    // Set horizontal effect
    UIInterpolatingMotionEffect *horizontalMotionEffect =
    [[UIInterpolatingMotionEffect alloc]
     initWithKeyPath:@"center.x"
     type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    horizontalMotionEffect.minimumRelativeValue = @(-30);
    horizontalMotionEffect.maximumRelativeValue = @(30);
    
    // Create group to combine both
    UIMotionEffectGroup *group = [UIMotionEffectGroup new];
    group.motionEffects = @[horizontalMotionEffect, verticalMotionEffect];
    
    // Add both effects to your view
    [scroller addMotionEffect:group];
}

-(IBAction)cubeTouched:(UIButton *)sender{

    NSLog(@"touched: %i",[sender tag]);
    //NSMutableDictionary *dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"gameData"];
     //BattleCube *cube = [dic objectForKey:[NSString stringWithFormat:@"%i",sender.tag]];
    //[self transitionToRecieveViewControllerWithCube:cube];
    
}
-(void)transitionToRecieveViewControllerWithCube:(BattleCube *)_cube{
    
    [timer invalidate];
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main_iPhone"
                                                  bundle:nil];
    ReceiveViewController *receiveViewController = [sb instantiateViewControllerWithIdentifier:@"ReceiveViewController"];
    [receiveViewController setImageViewToImageNamed:[_cube getImageName]];
    [receiveViewController setCubeRarityNamed:[_cube getRarity]];
    [receiveViewController setCubeName:[_cube getName]];
    //[receiveViewController setPopToViewController:self];
    
    ADTransition * transition = [[ADCubeTransition alloc] initWithDuration:0.45f orientation:ADTransitionTopToBottom sourceRect:self.view.frame];
    transition = [[ADFadeTransition alloc]initWithDuration:0.5f];
    [self.transitionController pushViewController:receiveViewController withTransition:transition];
    
    
}

-(void)chooseButtonToBounce{
    if ([cubesInView count] != 0){
    int random = arc4random() % [cubesInView count];
        [self bounceButton:[cubesInView objectAtIndex:random]];
    }
}
- (void)bounceButton:(UIButton *)button{
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.translation.y"];///use transform
    double rand = (arc4random() % 2 ) +1;
    theAnimation.duration=rand/10.0;
    theAnimation.repeatCount=rand;
    theAnimation.autoreverses=YES;
    theAnimation.fromValue=[NSNumber numberWithFloat:1.0];
    theAnimation.toValue=[NSNumber numberWithFloat:-20];
    [button.layer addAnimation:theAnimation forKey:@"animateTranslation"];//animationkey
}

-(BOOL)isInView:(UIButton *)_cube{
    BOOL result = false;
    
    for (int i =0; i < [self.view.subviews count]; i++)
    {
        UIButton *b = (UIButton *)[self.view.subviews objectAtIndex:i];
            if ([b tag] == [_cube tag])
                    result = true;
        if(![_cube isDescendantOfView:[self view]]) {
            result = true;
        }
        
    }
    
    return result;;
}
- (IBAction)back:(UIButton *)sender {
    NSLog(@"Called");
    [self.transitionController popViewController];
}
@end
