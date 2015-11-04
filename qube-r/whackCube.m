//
//  whackCube.m
//  qube-r
//
//  Created by Benjamin Humphries on 9/30/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import "whackCube.h"

@implementation whackCube{
    CubeGenerator *cubeGenerator;
}
@synthesize miniGameViewController;
@synthesize mole;

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size])
    {
        cubeGenerator = [[CubeGenerator alloc]init];
        [self setupScreenSize];
        [self addBackground];
        [self setupHoles];
        positions = [[NSMutableArray alloc]initWithObjects:
                     0,
                     1,
                     2,
                     3,
                     4,
                     nil];
    }
    return self;
}
-(void)setupScreenSize{
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    screenWidth = screenSize.width;
    screenHeight =screenSize.height;
}
-(void)addBackground{
    
    SKSpriteNode *back = [[SKSpriteNode alloc] initWithImageNamed:@"whackBack"];
    [back setSize:CGSizeMake(screenWidth, screenHeight)];
    [back setPosition:CGPointMake(screenWidth/2, screenHeight/2)];
    [self addChild:back];
    
}
-(void)setupHoles{
    
    hole1 = [[SKSpriteNode alloc] init];
    hole2 = [[SKSpriteNode alloc] init];
    hole3 = [[SKSpriteNode alloc] init];
    hole4 = [[SKSpriteNode alloc] init];
    hole5 = [[SKSpriteNode alloc] init];
    
    const double CENTER = 1.54;
    const double LEFT_X = 4.5;
    const double RIGHT_X = 1.26;
    const double TOP_Y = 1.28;
    const double BOT_Y = 2.1;
    
    hole1.position = CGPointMake(screenWidth/LEFT_X, screenHeight/BOT_Y);
    hole2.position = CGPointMake(screenWidth/RIGHT_X, screenHeight/BOT_Y);
    hole3.position = CGPointMake(screenWidth/2, screenHeight/CENTER); // center
    hole4.position = CGPointMake(screenWidth/LEFT_X + 10.0, screenHeight/TOP_Y);
    hole5.position = CGPointMake(screenWidth/RIGHT_X-10.0, screenHeight/TOP_Y);
    
    [self addChild:hole1];
    [self addChild:hole2];
    [self addChild:hole3];
    [self addChild:hole4];
    [self addChild:hole5];
    
}
-(void)popRandomCube{
    mole = [[SKSpriteNode alloc]initWithImageNamed:@"c004.png"];
    int randPos = arc4random() % 5;
    mole.position = [self getHolePosForIndex:randPos];
    mole.position = CGPointMake(mole.position.x, mole.position.y - 20);
    mole.size = CGSizeMake(20, 20);
    mole.name = @"mole";
    [self addChild:mole];
    
    SKAction *scale = [SKAction scaleBy:4 duration:0.2];
    SKAction *moveUp = [SKAction moveTo:[self getHolePosForIndex:randPos] duration:0.4];
    SKAction *wait = [SKAction waitForDuration:1.0 withRange:1.5];
    SKAction *remove = [SKAction removeFromParent];
    
    [mole runAction:scale];
    [mole runAction:moveUp];
    [mole runAction:[SKAction sequence:@[wait,remove]]];
}
-(CGPoint)getHolePosForIndex:(int)index{
    CGPoint pos;
    switch (index) {
        case 0:
            pos = hole1.position;
            break;
        case 1:
            pos = hole2.position;
            break;
        case 2:
            pos = hole3.position;
            break;
        case 3:
            pos = hole4.position;
            break;
        case 4:
            pos = hole5.position;
            break;
            
        default:
            break;
    }
    return pos;
}
-(void)readyCheck{
    isReady = true;
    [self startGame];
    
}
-(void)startGame{
    
    SKAction *addMole = [SKAction runBlock:^{
        [self popRandomCube];
    }];
    
    SKAction *wait = [SKAction waitForDuration:0.5 withRange:1.0];
    
    SKAction *sequence = [SKAction sequence:@[addMole, wait]];
    [self runAction:[SKAction repeatAction:sequence count:15]completion:^{
        //game done
        NSLog(@"whacked %i moles!",whackCount);
        [self gameEndedWithNumMoles:whackCount];
        [mole removeAllActions];
        [mole removeFromParent];
    }];
    
}
-(void)gameEndedWithNumMoles:(int)molesHit{
    
    
    if (molesHit >=10)
        resultingCube = [cubeGenerator getRandomCubeForRarity:@"ultra-rare"];
   else if (molesHit >=8)
        resultingCube = [cubeGenerator getRandomCubeForRarity:@"rare"];
   else if (molesHit >=6)
        resultingCube = [cubeGenerator getRandomCubeForRarity:@"uncommon"];
    else
        resultingCube = [cubeGenerator getRandomCubeForRarity:@"common"];

    isEnd = true;
}
-(void)setViewController:(MiniGameViewController *)controller{
    
    miniGameViewController = controller;
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches)
    {
        CGPoint location = [touch locationInNode:self];
        SKSpriteNode *node= (SKSpriteNode *)[self nodeAtPoint:location];
       
        if ([node.name isEqualToString:@"mole"])
        {
            [node removeAllActions];
            [node removeFromParent];
            whackCount++;
            
        }
        
        if (!isReady){
            [self readyCheck];
        }
        else if (isEnd){
            [miniGameViewController transitionToRecieveViewControllerForCube:resultingCube];
        }
    }
    
   

}
@end
