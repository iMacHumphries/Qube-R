//
//  BattleSceneViewController.m
//  qube-r
//
//  Created by Benjamin Humphries on 10/21/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import "BattleSceneViewController.h"

@interface BattleSceneViewController ()

@end

@implementation BattleSceneViewController

- (void)viewDidLoad {
       [super viewDidLoad];
    
    // Configure the view.
    SKView *skView = [[SKView alloc]init];
    skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    /* Sprite Kit applies additional optimizations to improve rendering performance */
    skView.ignoresSiblingOrder = YES;
    
    // Create and configure the scene.
    BattleScene *scene = [[BattleScene alloc] initWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
   
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

@end
