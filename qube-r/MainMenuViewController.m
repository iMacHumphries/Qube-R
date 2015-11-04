//
//  MainMenuViewController.m
//  qube-r
//
//  Created by Benjamin Humphries on 9/14/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import "MainMenuViewController.h"
#import "ViewController.h"
#import "AppDelegate.h"
#import "ADNavigationControllerDelegate.h"


@interface MainMenuViewController (){

}

@end

@implementation MainMenuViewController
@synthesize viewController,indexViewController;
@synthesize viewButton;
@synthesize timer;
@synthesize scanButton;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [self.transitionController setNavigationBarHidden:YES];
    [self.transitionController setToolbarHidden:YES];
    self.title = @"Cubes";
    [super viewDidLoad];
    // Configure the view.
    SKView *skView = [[SKView alloc]init];
    skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    skView.ignoresSiblingOrder = YES;
    
    SKScene *scene = [[SKScene alloc] init];
    
    scene = [SKMenuScene sceneWithSize:skView.bounds.size];
    
    SKMenuScene *menu = (SKMenuScene *)scene;
    [menu setMainMenuViewController:self];
    
    scene.scaleMode = SKSceneScaleModeAspectFill;
    [skView presentScene:scene];
    

}
-(void)viewWillAppear:(BOOL)animated{
    
    [self.transitionController setNavigationBarHidden:YES];
    [self.transitionController setToolbarHidden:YES];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)scanButton:(UIButton *)sender {
    
      // [self performSegueWithIdentifier:@"scan" sender:sender];
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main_iPhone"
                                                  bundle:nil];
    viewController = [sb instantiateViewControllerWithIdentifier:@"ViewController"];
    
  
    ADTransition * transition = [[ADCubeTransition alloc] initWithDuration:0.45f orientation:ADTransitionLeftToRight sourceRect:self.view.frame];
    [self.transitionController pushViewController:viewController withTransition:transition];
}
- (IBAction)viewButton:(UIButton *)sender {
         UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main_iPhone"
                                                  bundle:nil];
    indexViewController = [sb instantiateViewControllerWithIdentifier:@"IndexViewController"];
    
    
    ADTransition * transition = [[ADCubeTransition alloc] initWithDuration:0.45f orientation:ADTransitionRightToLeft sourceRect:self.view.frame];
    [self.transitionController pushViewController:indexViewController withTransition:transition];
}

- (IBAction)battleButton:(UIButton *)sender {
    
    
}



- (IBAction)testBattle:(UIButton *)sender {
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main_iPhone"
                                                  bundle:nil];
    MultiplayerViewController *mController = (MultiplayerViewController *)[sb instantiateViewControllerWithIdentifier:@"MultiplayerViewController"];
    
    
    ADTransition * transition = [[ADCubeTransition alloc] initWithDuration:0.45f orientation:ADTransitionRightToLeft sourceRect:self.view.frame];
    [self.transitionController pushViewController:mController withTransition:transition];
}

- (IBAction)testButton:(id)sender {
    CubeGenerator *cubeGenerator = [[CubeGenerator alloc]init];
    BattleCube *cube = [cubeGenerator unlockRandomCube];
    NSLog(@"cubeNAME: %@ cube Rarity: %@",[cube getName],[cube getRarity]);
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
@end
