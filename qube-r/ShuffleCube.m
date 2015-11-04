//
//  ShuffleCube.m - 1 is always (x) wrong cube.
//  qube-r
//
//  Created by Benjamin Humphries on 9/27/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import "ShuffleCube.h"


@implementation ShuffleCube{
    CubeGenerator *cubeGenerator;
}
@synthesize cube0,cube1,cube2;
@synthesize cubesArray;
@synthesize battleCube1,battleCube2;
@synthesize readyButton,button,label,tapToContinueLabel;
@synthesize resultingCube;
@synthesize miniGameViewController;

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size])
    {
        [self setupScreenSize];
        [self setupCubesAndPositions];
    }
    return self;
}

-(void)setupScreenSize{
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    screenWidth = screenSize.width;
    screenHeight =screenSize.height;
}
-(void)setupCubesAndPositions{
    
    tapToContinueLabel = [[SKLabelNode alloc] initWithFontNamed:@"(Tap to Continue)"];
    tapToContinueLabel.position = CGPointMake(screenWidth/2, screenHeight/1.5);
    tapToContinueLabel.fontSize = 40;
    tapToContinueLabel.fontName = @"Impact";
    tapToContinueLabel.fontColor = [UIColor blackColor];
    
    
    cubesArray = [[NSMutableArray alloc]initWithCapacity:3];
    const int CUBE_SIZE = 80;
  
    SKSpriteNode *background = [[SKSpriteNode alloc]initWithImageNamed:@"shuffleBack"];
    background.position = CGPointMake(screenWidth/2, screenHeight/2);
    [self addChild:background];
    
    
  
    
    cubeGenerator = [[CubeGenerator alloc] init];

    self.battleCube1 = [cubeGenerator getRandomCubeForRarity:@"random"];
    NSLog(@"test: name:%@",[battleCube1 getName]);
    
    self.battleCube2 = [cubeGenerator getRandomCubeForRarity:@"random"];
    
    
    
    while ([[battleCube1 getName] isEqualToString:[battleCube2 getName]]){
        
        self.battleCube2 = [cubeGenerator getRandomCubeForRarity:@"random"];
    }
    
    cube0 = [[SKSpriteNode alloc] initWithImageNamed:[battleCube1 getImageName]];
    cube1 = [[SKSpriteNode alloc] initWithImageNamed:@"xcube"];
    cube2 = [[SKSpriteNode alloc] initWithImageNamed:[battleCube2 getImageName]];

    
    [cube0 setSize:CGSizeMake(CUBE_SIZE, CUBE_SIZE)];
    [cube1 setSize:CGSizeMake(CUBE_SIZE, CUBE_SIZE)];
    [cube2 setSize:CGSizeMake(CUBE_SIZE, CUBE_SIZE)];
    
    cube0.name = @"0";
    cube1.name = @"1";
    cube2.name = @"2";
    
    cube0.position = CGPointMake(screenWidth/5, screenHeight/2);
    cube1.position = CGPointMake(screenWidth/2, screenHeight/2);
    cube2.position = CGPointMake(screenWidth/1.25, screenHeight/2);
    
    [self addChild:cube0];
    [self addChild:cube1];
    [self addChild:cube2];
    
    [cubesArray addObject:cube0];
    [cubesArray addObject:cube1];
    [cubesArray addObject:cube2];
    
    readyButton = [[SKSpriteNode alloc] initWithImageNamed:@"readyButton"];
    readyButton.position = CGPointMake(screenWidth/2, screenHeight/1.25);
    [self addChild:readyButton];
    isReady = false;
    isEnd = false;
    
    button = [SKSpriteNode spriteNodeWithImageNamed:@"blankButton"];
    button.position = readyButton.position;
    label = [[SKLabelNode alloc]init];
    label.text = [NSString stringWithFormat:@"3"];
    label.position = CGPointMake(0, -10);
    label.fontSize = 50;
    label.fontName = @"Impact";
    label.fontColor = [UIColor blackColor];
}
-(void)readyCheck{
    isReady = true;
    [self hideCubes];
    [self startCountDown];
}
-(void)startCountDown{
    [readyButton removeFromParent];

    [button addChild:label];
    [self addChild:button];
    
    __block NSInteger count = 4;
    SKAction *wait = [SKAction waitForDuration:1.3];
    SKAction *countDown = [SKAction runBlock:^{
        
        count--;
        if (count >= 0){
            label.text = [NSString stringWithFormat:@"%i",count];
        }
    }];
    
    SKAction *countSequence = [SKAction sequence:@[countDown,wait]];
    [self runAction:[SKAction repeatAction:countSequence count:3]completion:^{
        
        [button removeFromParent];
        [self startGame];
    }];
}
-(void)startGame{
    
    isGameOver = false;
    SKAction *playTime = [SKAction runBlock:^{
        [self switchRandomCubePositions];
        [self updatePositionForCubeArray:cubesArray];
    }];
    SKAction *smallDelay = [SKAction waitForDuration:1.0];
    SKAction *sequence = [SKAction sequence:@[smallDelay,playTime]];
    SKAction *repeatSequence = [SKAction repeatAction:sequence count:10];
    [self runAction:repeatSequence completion:^{
        isGameOver = true;
        [self updatePositionForCubeArray:cubesArray];
    }];
    
}
-(void)switchRandomCubePositions{
    int randFrom = arc4random() % [cubesArray count];
    int randTo = arc4random() % [cubesArray count];
    while (randTo == randFrom) {
         randTo = arc4random() % [cubesArray count];
    }
  
    
    [self moveSprite:[cubesArray objectAtIndex:randFrom] FromPosNode:[cubesArray objectAtIndex:randFrom] ToPosNode:[cubesArray objectAtIndex:randTo]  withDuration:0.5];
    
    [self moveSprite:[cubesArray objectAtIndex:randTo] FromPosNode:[cubesArray objectAtIndex:randTo] ToPosNode:[cubesArray objectAtIndex:randFrom] withDuration:0.5];
    
    [self switchNumbersIn:cubesArray firstNum:randTo secondNum:randFrom];
    
}
-(NSMutableArray *)switchNumbersIn:(NSMutableArray *)array firstNum:(NSInteger)num1 secondNum:(NSInteger)num2{
    
    SKSpriteNode *switch1 = [array objectAtIndex:num1];
    SKSpriteNode *switch2 = [array objectAtIndex:num2];
    
    [array replaceObjectAtIndex:num1 withObject:switch2];
    [array replaceObjectAtIndex:num2 withObject:switch1];
    
    [self updatePositionForCubeArray:array];
    return array;
}
-(void)updatePositionForCubeArray:(NSMutableArray *)array{
    SKSpriteNode *s0 = [array objectAtIndex:0];
    SKSpriteNode *s1 = [array objectAtIndex:1];
    SKSpriteNode *s2 = [array objectAtIndex:2];
    
    s0.position = CGPointMake(screenWidth/5, screenHeight/2);
    s1.position = CGPointMake(screenWidth/2, screenHeight/2);
    s2.position = CGPointMake(screenWidth/1.25, screenHeight/2);
}
-(void)moveSprite:(SKSpriteNode *)sprite FromPosNode:(SKNode *)fromNode ToPosNode:(SKNode *)toNode withDuration:(float)duration{
    SKAction *followCurve;
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, fromNode.position.x, fromNode.position.y);
    const int X_RATE = 10;
    const int LARGE_X_RATE = 50;
    const int Y_RATE = 100;
    const int LARGE_Y_RATE = 150;

    if ([fromNode.name isEqualToString:@"0"] && [toNode.name isEqualToString:@"1"])
    {
        CGPathAddCurveToPoint(path, NULL,
                              fromNode.position.x + X_RATE, fromNode.position.y + Y_RATE,
                              fromNode.position.x + 2 * X_RATE, fromNode.position.y + Y_RATE *2,
                              toNode.position.x, toNode.position.y);
    }
  else if ([fromNode.name isEqualToString:@"0"] && [toNode.name isEqualToString:@"2"])
    {
        CGPathAddCurveToPoint(path, NULL,
                              fromNode.position.x + LARGE_X_RATE, fromNode.position.y - LARGE_Y_RATE,
                              fromNode.position.x + 2 * LARGE_X_RATE, fromNode.position.y - LARGE_Y_RATE * 2,
                              toNode.position.x, toNode.position.y);
    }
  else if ([fromNode.name isEqualToString:@"1"] && [toNode.name isEqualToString:@"2"])
  {
      CGPathAddCurveToPoint(path, NULL,
                            fromNode.position.x + X_RATE, fromNode.position.y + Y_RATE,
                            fromNode.position.x + 2 * X_RATE, fromNode.position.y + Y_RATE *2,
                            toNode.position.x, toNode.position.y);
  }
  else if ([fromNode.name isEqualToString:@"1"] && [toNode.name isEqualToString:@"0"])
  {
      CGPathAddCurveToPoint(path, NULL,
                            fromNode.position.x - X_RATE, fromNode.position.y - Y_RATE,
                            fromNode.position.x - 2 * X_RATE, fromNode.position.y - Y_RATE * 2,
                            toNode.position.x, toNode.position.y);
      
  }
  else if ([fromNode.name isEqualToString:@"2"] && [toNode.name isEqualToString:@"0"])
  {
      CGPathAddCurveToPoint(path, NULL,
                            fromNode.position.x - LARGE_X_RATE, fromNode.position.y + LARGE_Y_RATE,
                            fromNode.position.x - 2 * LARGE_X_RATE, fromNode.position.y + LARGE_Y_RATE *2,
                            toNode.position.x, toNode.position.y);
  }
  else if ([fromNode.name isEqualToString:@"2"] && [toNode.name isEqualToString:@"1"])
  {
      CGPathAddCurveToPoint(path, NULL,
                            fromNode.position.x - X_RATE, fromNode.position.y - Y_RATE,
                            fromNode.position.x - 2 * X_RATE, fromNode.position.y - Y_RATE *2,
                            toNode.position.x, toNode.position.y);
  }

followCurve = [SKAction followPath:path asOffset:NO orientToPath:NO duration:duration];
    if (followCurve){
        [sprite runAction:followCurve completion:^{
            
            [self updatePositionForCubeArray:cubesArray];
        }];
    }
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
        for (UITouch *touch in touches){
            CGPoint location = [touch locationInNode:self];
            SKNode *node=[self nodeAtPoint:location];
            if (isEnd){
              
                [miniGameViewController transitionToRecieveViewControllerForCube:resultingCube];
               
            }
            else if (isGameOver)
            {
                
                
                if ([node.name isEqualToString:@"0"]){
                    [self reveilCubes];
                    [self handleGameOverWithCubeNumber:[node.name integerValue]];
                }
                else if ([node.name isEqualToString:@"1"]){
                    [self reveilCubes];
                    [self handleGameOverWithCubeNumber:[node.name integerValue]];
                }
                else if ([node.name isEqualToString:@"2"]){
                    [self reveilCubes];
                    [self handleGameOverWithCubeNumber:[node.name integerValue]];
                }
               
            }
            else
            {
                if (!isReady){
                    [self readyCheck];
                }
            }
           
        }
    
}


-(void)handleGameOverWithCubeNumber:(NSInteger)index{
    
    isEnd = true;
    
    if (index == 0){
        [self displayWinner];
        resultingCube = battleCube1;
       // [miniGameViewController transitionToRecieveViewControllerForCubeID:cubeID1];
    }
    else if (index == 1){
        [self displayLoser];
        resultingCube = nil;
    }
    else if (index == 2){
        [self displayWinner];
        resultingCube = battleCube2;
       // [miniGameViewController transitionToRecieveViewControllerForCubeID:cubeID2];

    }

}
-(void)displayWinner{
    SKSpriteNode *win = [SKSpriteNode spriteNodeWithImageNamed:@"win0.png"];
    win.position = CGPointMake(screenWidth/2, screenHeight/1.15);
    [self addChild:win];
    [self addChild:tapToContinueLabel];
    
    NSMutableArray *turn = [NSMutableArray array];
    SKTextureAtlas *coinAtlas = [SKTextureAtlas atlasNamed:@"win"];
    
    NSInteger numImages = coinAtlas.textureNames.count;
    for (int i=0; i < numImages; i++) {
        NSString *textureName = [NSString stringWithFormat:@"win%i", i];
        SKTexture *temp = [coinAtlas textureNamed:textureName];
        [turn addObject:temp];
        
    }
    NSArray *array = turn;
    
    [win runAction:[SKAction repeatActionForever:
                     [SKAction animateWithTextures:array
                                      timePerFrame:0.06f
                                            resize:NO
                                           restore:YES]]];

}
-(void)displayLoser{
    SKSpriteNode *lose = [SKSpriteNode spriteNodeWithImageNamed:@"lose.png"];
    lose.position = CGPointMake(screenWidth/2, screenHeight/1.15);
    [self addChild:lose];
    [self addChild:tapToContinueLabel];
}
-(void)reveilCubes{
    SKTexture *t0 =[SKTexture textureWithImage:[UIImage imageNamed:[battleCube1 getImageName]]];
    SKTexture *t1 =[SKTexture textureWithImage:[UIImage imageNamed:@"xcube"]];
    SKTexture *t2 =[SKTexture textureWithImage:[UIImage imageNamed:[battleCube2 getImageName]]];
    
    [self.cube0 setTexture:t0];
    [self.cube1 setTexture:t1];
    [self.cube2 setTexture:t2];
   
}
-(void)hideCubes{
    [self.cube0 setTexture:[SKTexture textureWithImageNamed:@"unkown.png"]];
    [self.cube1 setTexture:[SKTexture textureWithImageNamed:@"unkown.png"]];
    [self.cube2 setTexture:[SKTexture textureWithImageNamed:@"unkown.png"]];
}

-(void)setViewController:(MiniGameViewController *)controller{
    
    miniGameViewController = controller;
}
@end
