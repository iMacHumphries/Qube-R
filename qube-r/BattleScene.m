//
//  BattleScene.m
//  qube-r
//
//  Created by Benjamin Humphries on 10/21/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import "BattleScene.h"

@implementation BattleScene
@synthesize battleMenuNode;
@synthesize player1,player2,currentPlayer;


-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size])
    {
        [self setupScreenSize];
        [self setupBattleMenu];
        [self determineFirstPlayer];
    }
    return self;
}
-(void)setupScreenSize{
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    screenWidth = screenSize.width;
    screenHeight =screenSize.height;
}
-(void)setupBattleMenu{
    battleMenuNode = [[SKSpriteNode alloc]init];
    SKSpriteNode *leftAttButton = [[SKSpriteNode alloc] initWithImageNamed:@"attButton.png"];
    SKSpriteNode *rightRunButton = [[SKSpriteNode alloc]initWithImageNamed:@"runButton.png"];
    leftAttButton.name = @"attack";
    rightRunButton.name = @"run";
    
    leftAttButton.position = CGPointMake(-1 * leftAttButton.frame.size.width/2, 0);
    rightRunButton.position = CGPointMake(rightRunButton.frame.size.width/2, 0);
    
    
    [battleMenuNode addChild:leftAttButton];
    [battleMenuNode addChild:rightRunButton];
    
    battleMenuNode.position = CGPointMake(screenWidth/2, leftAttButton.frame.size.height/2);
    
    [self addChild:battleMenuNode];
    [battleMenuNode setScale:screenWidth/320];
}
-(void)determineFirstPlayer{
    /*
    if ([player1Cube getSpeed] > [player2Cube getSpeed])
        currentPlayer = player1Cube;
    else if ([player1Cube getSpeed] < [player2Cube getSpeed])
        currentPlayer = player2Cube;
    else //random
    {
        int rand = (arc4random() % 2) +1;
        if (rand == 1)
            currentPlayer = player1Cube;
        else
            currentPlayer = player2Cube;
    }
     */
}
-(void)setupBattleMenuForAttack{
    [battleMenuNode removeFromParent];
    battleMenuNode = [[SKSpriteNode alloc]initWithImageNamed:@"battlemenu.png"];
    battleMenuNode.position = CGPointMake(screenWidth/2, battleMenuNode.frame.size.height/2);
    
    const int SMALL_TEXT_SIZE = 20;
    float x = battleMenuNode.frame.size.width/2;
    float y = battleMenuNode.frame.size.height/2;
    
    for (int i = 0; i < 4; i++)
    {
        SKLabelNode *attackLabel = [[SKLabelNode alloc]init];
        [attackLabel setColor:[UIColor whiteColor]];
        [attackLabel setFontSize:SMALL_TEXT_SIZE];
        
        
        if (i == 0)
        {
            [attackLabel setPosition:CGPointMake(-x, y)];
           // [attackLabel setText:[[currentPlayer getAttack1] getName]];
        }
        else if (i == 1)
        {
            [attackLabel setPosition:CGPointMake(x, y)];
          // [attackLabel setText:[[currentPlayer getAttack2] getName]];
        }
        else if (i == 2)
        {
            [attackLabel setPosition:CGPointMake(-x, -y)];
           // [attackLabel setText:[[currentPlayer getAttack3] getName]];
        }
        else if (i==3)
        {
            [attackLabel setPosition:CGPointMake(x, -y)];
           // [attackLabel setText:[[currentPlayer getAttack4] getName]];
        }
        
        attackLabel.name = [NSString stringWithFormat:@"aLabel%i",i];
    }

    
    [self addChild:battleMenuNode];
    [battleMenuNode setScale:screenWidth/320];
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches)
    {
        CGPoint location = [touch locationInNode:self];
        SKSpriteNode *node= (SKSpriteNode *)[self nodeAtPoint:location];
        if ([node.name isEqualToString:@"attack"] || [node.name isEqualToString:@"run"]) {
            [node setAlpha:0.8];
        }
        
    }
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches)
    {
        CGPoint location = [touch locationInNode:self];
        SKSpriteNode *node= (SKSpriteNode *)[self nodeAtPoint:location];
        [node setAlpha:1.0];
        
        if ([node.name isEqualToString:@"attack"])
        {
            [self setupBattleMenuForAttack];
        }
        else if ([node.name isEqualToString:@"run"])
        {
            
        }
    }
}
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches)
    {
        CGPoint location = [touch locationInNode:self];
        SKSpriteNode *node= (SKSpriteNode *)[self nodeAtPoint:location];
        [node setAlpha:1.0];
    }
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches)
    {
        CGPoint location = [touch locationInNode:self];
        SKSpriteNode *node= (SKSpriteNode *)[self nodeAtPoint:location];
        [node setAlpha:1.0];
    }
}

-(void)setPlayer1:(Player *)_player{
    self.player1 = _player;
}
-(void)setPlayer2:(Player *)_player{
    self.player2 = _player;
}
@end
