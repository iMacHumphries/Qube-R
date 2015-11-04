//
//  MiniGameViewController.m
//  qube-r
//
//  Created by Benjamin Humphries on 9/27/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import "MiniGameViewController.h"
#import "CubeGenerator.h"
#import "ViewController.h"


@interface MiniGameViewController (){

}

@end

@implementation MiniGameViewController
@synthesize receiveViewController;
@synthesize sb;
@synthesize transition;
@synthesize viewController;


- (void)viewDidLoad {
    [super viewDidLoad];
    isFirstTime = true;
    sb = [UIStoryboard storyboardWithName:@"Main_iPhone"
                                                  bundle:nil];
    receiveViewController = [sb instantiateViewControllerWithIdentifier:@"ReceiveViewController"];
    
    transition = [[ADCubeTransition alloc] initWithDuration:0.45f orientation:ADTransitionTopToBottom sourceRect:self.view.frame];
    
    [self randomMiniGame];
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    
    [self.transitionController setNavigationBarHidden:YES];
    [self.transitionController setToolbarHidden:YES];
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)randomMiniGame{
    const int SHUFFLE_CUBE_GAME = 0;
    const int MATCH_CUBE_GAME = 1;
    const int WHACK_CUBE = 2;
    
    const int NUMBER_OF_GAMES = 2;
    SKScene *scene = [[SKScene alloc] init];
    int rand = arc4random() % NUMBER_OF_GAMES; //number of games
    //int rand = 1; //testing
    
    SKView *skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    if (rand == SHUFFLE_CUBE_GAME)
    {
        scene = [ShuffleCube sceneWithSize:skView.bounds.size];
        ShuffleCube * shuffle = (ShuffleCube *)scene;
        [shuffle setViewController:self];
    }
    else if (rand == MATCH_CUBE_GAME)
    {
        scene = [MatchCube sceneWithSize:skView.bounds.size];
        MatchCube *match = (MatchCube *)scene;
        [match setViewController:self];
    }
    else if (rand == WHACK_CUBE)
    {
        scene = [whackCube sceneWithSize:skView.bounds.size];
        whackCube *whack = (whackCube *)scene;
        [whack setViewController:self];
    }
    

    scene.scaleMode = SKSceneScaleModeAspectFill;
    [skView presentScene:scene];
}
-(void)transitionToRecieveViewControllerForCube:(BattleCube *)_cube{
   
    if (![_cube isEqual:nil])
    {
        [receiveViewController setImageViewToImageNamed:[_cube getImageName]];
        [receiveViewController setCubeRarityNamed:[_cube getRarity]];
        [receiveViewController setCubeName:[_cube getName]];
        [receiveViewController setPopToViewController:viewController];

        if (isFirstTime)
        {
            NSLog(@"called");
            [self.transitionController pushViewController:receiveViewController withTransition:transition];
            isFirstTime = false;
            CubeGenerator *cubeGenerator = [[CubeGenerator alloc] init];
            [cubeGenerator unlockCube:_cube];
        }else{
            [self.transitionController popViewController];
        }
    }
    else
    {
        //gamelost with nil return
        [self.transitionController popToRootViewController];
        return;
    }
   
    
}
-(void)setPopToViewController:(ViewController *)v{
    viewController = v;
}
@end
