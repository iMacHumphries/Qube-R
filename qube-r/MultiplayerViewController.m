//
//  MultiplayerViewController.m
//  qube-r
//
//  Created by Benjamin Humphries on 10/22/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import "MultiplayerViewController.h"

@interface MultiplayerViewController ()

@end

@implementation MultiplayerViewController
@synthesize scroller;
@synthesize countLabel;
@synthesize cubesInView;
@synthesize battleCubesArray;

- (void)viewDidLoad {
    self.title = @"Choose 3 Cubes:";
    const int MAX_CUBES = 3;
    battleCubesArray = [[NSMutableArray alloc]initWithCapacity:MAX_CUBES];
    
    [self setupScreenSize];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)setupScreenSize{
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    screenWidth = screenSize.width;
    screenHeight =screenSize.height;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setupIndex{
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    screenWidth = screenSize.width;
    screenHeight =screenSize.height;
    
   // CubeGenerator *cubeGenerator = [[CubeGenerator alloc]init];
    
   
    self.scroller = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, screenWidth,screenHeight)];
    self.scroller.userInteractionEnabled = YES;
    self.scroller.contentSize = CGSizeMake(320, (([cubeGenerator getTotalCubesUnlocked] * 120) ) /3);
   
    
    self.scroller.delegate = self;
    
    
    [self addParallax];
    
    int xPosition = 32;
    int yPosition = 49;
    [self.view addSubview:scroller];
    
    NSMutableDictionary *dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"gameData"];
    
    
    
    for (int index = 0; index < [cubeGenerator getTotalCubes]; index ++)
    {
        
        BattleCube *cube = [dic objectForKey:[NSString stringWithFormat:@"%i",index]];
        NSString *imageName = [cube getImageName];
        int cubeCount = [cubeGenerator getTotalCubesNamed:[cube getName]];
        BOOL unlock = [cube getIsUnlocked];
        
        
        UIImage *image = [UIImage imageNamed:imageName];
        UIImageView *labelBack = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"back.png"]];
        [labelBack setFrame:CGRectMake(0, 0, 20, 20)];
        
        
        countLabel = [[UILabel alloc]initWithFrame:CGRectMake(5,-5, 80, 30)];
        countLabel.textColor = [UIColor whiteColor];
        [countLabel setFont:[UIFont fontWithName:@"Impact" size:20]];
        
        

            if (unlock)
            {
               UIButton *buttonCube = [[UIButton alloc]initWithFrame:CGRectMake(xPosition, yPosition, 80, 80)];
                [buttonCube setBackgroundImage:image forState:UIControlStateNormal];
                [buttonCube setTag:index];
                [buttonCube addTarget:self action:@selector(cubeTouched:) forControlEvents:UIControlEventTouchUpInside];
                
                
                if (cubeCount > 0)
                {
                    countLabel.text = [NSString stringWithFormat:@"%i",cubeCount];
                    [labelBack addSubview:countLabel];
                    [buttonCube addSubview:labelBack];
                }
                [self.scroller addSubview:buttonCube];
                [cubesInView addObject:buttonCube];
                xPosition += 88;
                if (xPosition > 208)
                {
                    xPosition = 32;
                    yPosition += 95;
                }
                
                
            }
        
        
    }
    
}
-(IBAction)cubeTouched:(UIButton *)sender{
    NSLog(@"%ld",(long)sender.tag);
    /*
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main_iPhone"
                                                 bundle:nil];
    ReceiveViewController *receiveViewController = [sb instantiateViewControllerWithIdentifier:@"ReceiveViewController"];
    
    NSString *cubeID = [NSString stringWithFormat:@"cube%i",sender.tag];
    UICube *cube = [[UICube alloc]init];
    [receiveViewController setCubeName:[cube getNameForCubeID:cubeID]];
    [receiveViewController setCubeRarityNamed:[cube getRarityForCubeID:cubeID]];
    [receiveViewController setImageName:[cube getImageForCubeID:cubeID]];
    
    ADTransition * transition = [[ADCubeTransition alloc] initWithDuration:0.45f orientation:ADTransitionTopToBottom sourceRect:self.view.frame];
    [self.transitionController pushViewController:receiveViewController withTransition:transition];
     */
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

@end
