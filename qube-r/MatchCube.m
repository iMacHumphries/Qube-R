//
//  MatchCube.m
//  qube-r
//
//  Created by Benjamin Humphries on 9/28/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import "MatchCube.h"

@implementation MatchCube{
    //CubeGenerator *cubeGenerator;
    
}
@synthesize gridArray,gridImagesArray;
@synthesize cubeImageArray;
@synthesize miniGameViewController;
@synthesize lastTappedCube;
@synthesize set1,set2,set3,set4;
@synthesize matchedCubes;
@synthesize resultingCube;
@synthesize timerLabel,instruct;

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size])
    {
        [self setCubeGenerator];
        isReadyToStart = false;
        lastTappedCube = [[SKSpriteNode alloc] init];
        matchedCubes  = [[NSMutableArray alloc] init];
        [self setupScreenSize];
        [self getRandomCubes];
        NSLog(@"testing this was called!");
        [self setupGrid];
        gridArray = [self getAssignedCubesImages];
        [self addCubes];
        [self addInstructions];
        
    }
    return self;
}
-(void)setCubeGenerator{
    
    cubeGenerator = [[CubeGenerator alloc]init];
    
}
-(void)setupScreenSize{
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    screenWidth = screenSize.width;
    screenHeight =screenSize.height;
}
-(void)getRandomCubes{
 
    cubeImageArray = [[NSMutableArray alloc]init];
    
    const int MAX_SETS = 4;
    for (int i = 0; i < MAX_SETS; i++)
    {
        BattleCube *cube = [cubeGenerator getRandomCubeForRarity:@"random"];
        NSLog(@"cubeNAME:%@",[cube getName]);
        NSLog(@"%@",cubeGenerator);
        for (int x = 0; x < [cubeImageArray count]; x++)
        {
            if ([[cube getName] isEqualToString:[[cubeImageArray objectAtIndex:x] getName]])
                cube = [cubeGenerator getRandomCubeForRarity:@"random"];
            
            
        }
       [cubeImageArray addObject:cube];
    }
   
}
-(void)setupGrid{
    
    //(1,1)  (1,2)  (1,3)//
    //(2,1)  (2,2)  (2,3)//
    //(3,1)  (3,2)  (3,3)//
    gridArray = [[NSMutableArray alloc]init];
   
    const int MAX_ROW = 3;
    const int MAX_COL = 3;
    
    for (int row  = 1; row <= MAX_ROW; row++)
    {
        for(int col = 1; col <= MAX_COL; col++)
        {
            SKSpriteNode *node = [[SKSpriteNode alloc]init];
            node.name = [NSString stringWithFormat:@"%i%i",row,col];
            [gridArray addObject:node];
        }
        
    }

}
-(void)addCubes{
    const int CUBE_SIZE = 80;
    const int TOTAL_CUBES = 9;
    const int GRID_CENTER = 2;
    //add all cubes center
    for (int i = 0; i < TOTAL_CUBES; i++)
    {
        SKSpriteNode *node = [[SKSpriteNode alloc]init];
        SKSpriteNode *gridNode = [gridArray objectAtIndex:i];
        [node setName:gridNode.name];
        [node setSize:CGSizeMake(CUBE_SIZE, CUBE_SIZE)];
        [node setPosition:[self getPositionForNodeAtX:GRID_CENTER Y:GRID_CENTER]];
        [self addChild:node];
        [self revealCube:node];
          }
}
//creates sets
-(NSMutableArray *)getAssignedCubesImages{
    
    gridImagesArray = [[NSMutableArray alloc]init];

    const int SETS_OF_IMAGES = 5;
    
    NSMutableArray *newArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < SETS_OF_IMAGES; i++)
    {
        if ([gridArray count] > 1)
        {
        int rand1 = arc4random() % [gridArray count];
        SKSpriteNode *node = [gridArray objectAtIndex:rand1];
        NSString *image = [[cubeImageArray objectAtIndex:i] getImageName];
        [node setTexture:[SKTexture textureWithImage:[UIImage imageNamed:image]]];
                  [newArray addObject:node];
        [gridArray removeObjectAtIndex:rand1];
        
        int rand2 = arc4random() % [gridArray count];
        SKSpriteNode *node2 = [gridArray objectAtIndex:rand2];
        NSString *image2 = [[cubeImageArray objectAtIndex:i]getImageName];
        [node2 setTexture:[SKTexture textureWithImage:[UIImage imageNamed:image2]]];
                    [newArray addObject:node2];
        [gridArray removeObjectAtIndex:rand2];

            [gridImagesArray addObject:image];
            [gridImagesArray addObject:image2];
        }
        
    }
    SKSpriteNode *node2 = [gridArray objectAtIndex:0];
    [node2 setTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"xcube.png"]]];
    [newArray addObject:node2];
    [gridImagesArray addObject:@"xcube.png"];
    [gridArray removeObjectAtIndex:0];

    return newArray;
}
-(void)moveCubesIntoPositions{
    
    const double DURATION = 0.3;
    SKAction *up = [SKAction moveTo:[self getPositionForNodeAtX:1 Y:2] duration:DURATION]; //up moveTo12
    SKAction *right = [SKAction moveTo:[self getPositionForNodeAtX:2 Y:3] duration:DURATION]; //right moveTo23
    SKAction *down = [SKAction moveTo:[self getPositionForNodeAtX:3 Y:2] duration:DURATION]; //down moveTo32
    SKAction *left = [SKAction moveTo:[self getPositionForNodeAtX:2 Y:1] duration:DURATION]; //left moveTo21
    SKAction *wait = [SKAction waitForDuration:DURATION ];
    
    SKAction *topRightCorner = [SKAction moveTo:[self getPositionForNodeAtX:1 Y:3] duration:DURATION];
    SKAction *bottomRightCorner = [SKAction moveTo:[self getPositionForNodeAtX:3 Y:3] duration:DURATION];
    SKAction *bottomLeftCorner = [SKAction moveTo:[self getPositionForNodeAtX:3 Y:1] duration:DURATION];
    SKAction *topLeftCorner = [SKAction moveTo:[self getPositionForNodeAtX:1 Y:1] duration:DURATION];

    SKAction *block1 = [SKAction runBlock:^{
        for (int i = 0; i <[self.children count]; i++)
        {
            SKSpriteNode *node = [self.children objectAtIndex:i];
            
            if ([node.name isEqualToString:@"13"])
            {
                [node runAction:up]; //up
            }
            else if ([node.name isEqualToString:@"33"])
            {
                [node runAction:right]; //right
            }
            else if ([node.name isEqualToString:@"31"])
            {
                [node runAction:down]; //down
            }
            else if ([node.name isEqualToString:@"11"])
            {
                [node runAction:left]; //left
            }
        }
    }];
    
    SKAction *block2 = [SKAction runBlock:^{
        for (int i = 0; i <[self.children count]; i++)
        {
            SKSpriteNode *node = [self.children objectAtIndex:i];
            
            if ([node.name isEqualToString:@"13"])
            {
                [node runAction:topRightCorner];
            }
            else if ([node.name isEqualToString:@"33"])
            {
                [node runAction:bottomRightCorner];
            }
            else if ([node.name isEqualToString:@"31"])
            {
                [node runAction:bottomLeftCorner];
            }
            else if ([node.name isEqualToString:@"11"])
            {
                [node runAction:topLeftCorner];
            }
        }
    }];

    SKAction *block3 = [SKAction runBlock:^{
        for (int i = 0; i <[self.children count]; i++)
        {
            SKSpriteNode *node = [self.children objectAtIndex:i];
            
            if ([node.name isEqualToString:@"12"])
            {
                [node runAction:up]; //up
            }
            else if ([node.name isEqualToString:@"23"])
            {
                [node runAction:right]; //right
            }
            else if ([node.name isEqualToString:@"32"])
            {
                [node runAction:down]; //down
            }
            else if ([node.name isEqualToString:@"21"])
            {
                [node runAction:left]; //left
            }
        }
    }];
    
    SKAction *sequence = [SKAction sequence:@[block1,wait,block2,wait,block3,wait]];
    
    [self runAction:sequence completion:^{
        [self hideAllCubes];
        isReadyToStart = true;
        NSLog(@"grid : %@",gridArray);
        set1 = [[gridArray objectAtIndex:0] name];
        set2 = [[gridArray objectAtIndex:2] name];
        set3 = [[gridArray objectAtIndex:4] name];
        set4 = [[gridArray objectAtIndex:6] name];
        
       
        
        
        for (int i = 0; i < [self.children count]; i++)
        {
            SKSpriteNode *node = (SKSpriteNode *)[self.children objectAtIndex:i];
            int nam = (int) [node.name integerValue];
            if (nam >0){
            if (i >= 8)
            {
                node.name = @"gameover";
            }
            else if (i >= 6)
            {
                node.name = set4;
            }
            else if (i >= 4)
            {
                node.name = set3;
            }
            else if (i >= 2)
            {
                node.name = set2;
            }
            else {
                node.name = set1;
            }
                if (i % 2 != 0){
                    node.name = [node.name stringByAppendingString:@"b"];
                }
            NSLog(@"%@\n",node.name);
            [gridArray replaceObjectAtIndex:i withObject:node];
            }
        }
       
        }];
    
}
-(CGPoint)getPositionForNodeAtX:(int)row Y:(int)col{
    
    CGPoint position = CGPointMake(0, 0);
    
    //row check
    if (row == 1)
    {
        position.y = screenHeight/1.4;
    }
    else if (row == 2)
    {
        position.y = screenHeight/2;

    }
    else if (row == 3)
    {
        position.y = screenHeight/3.5;
    }
    
    //col check
    if (col == 1)
    {
        position.x = screenWidth/5;
    }
    else if (col == 2)
    {
        position.x = screenWidth/2;
        
    }
    else if (col == 3)
    {
        position.x = screenWidth/1.25;
    }
    //NSLog(@"pos (%f,%f)",position.x,position.y);
    return position;
}
-(void)setViewController:(MiniGameViewController *)controller{
    
    miniGameViewController = controller;
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    for (UITouch *touch in touches)
    {
        CGPoint location = [touch locationInNode:self];
        SKSpriteNode *node= (SKSpriteNode *)[self nodeAtPoint:location];
        
        if (!isReadyToStart)
        {
            [self moveCubesIntoPositions];
            isReadyToStart = true;
            [instruct removeFromParent];
            [self startTimer];
            return;
        }
        else //ready to start Game
        {
            if (!isEnd)
            {
                if (![self isNodeInArray:node]) //if node isnt already matched
                {
           
                    [self revealCube:node];
                     if ([[node name] isEqualToString:@"gameover"])
                    {
                       NSLog(@"Gameover");
                        [self displayLoser];
                        resultingCube = nil;
                        isEnd = true;
                        didLose = true;
                    }
                    else if ([[node name] isEqualToString:[lastTappedCube.name stringByAppendingString:@"b"]] ||
                            [[[node name] stringByAppendingString:@"b"] isEqualToString:lastTappedCube.name] )
                    {
                        NSLog(@"match");
                        [matchedCubes addObject:node.name];
                        lastTappedCube = [[SKSpriteNode alloc]init];
                        if ([matchedCubes count] >= 4)
                        {
                            [self displayWinner];
                            resultingCube = [cubeGenerator getRandomCubeForRarity:@"random"];
                            isEnd = true;
                        }
                    }
                    else
                    {
                        NSLog(@"no match!");
                        [self hideCube:node];
                        [self hideCube:lastTappedCube];
                        lastTappedCube = node;
                        lastTappedCube.name = node.name;
                    }
           
                }

            }
            else if (isEnd)
            {
                if (didLose)resultingCube = nil;
                [miniGameViewController transitionToRecieveViewControllerForCube:resultingCube];
        
            }
            
            
        }
    }
}
-(BOOL)isNodeInArray:(SKSpriteNode *)node{

    for (int i = 0; i < [matchedCubes count]; i++)
    {
        
        if ([node.name isEqualToString:[matchedCubes objectAtIndex:i]])
        {
            return true;
        }
    }
    return false;
}
-(void)hideAllCubes{
     SKSpriteNode *imageNode =[[SKSpriteNode alloc] initWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"unkown.png"]]];
    for (int i = 0; i < [self.children count]; i++) {
        
        SKSpriteNode *node = (SKSpriteNode *)[self.children objectAtIndex:i];
        int nam = (int)[node.name integerValue];
        if (nam > 0)
        {
             [node setTexture:imageNode.texture];
        }
           }
}
-(SKSpriteNode *)revealCube:(SKSpriteNode *)node{
   
    for (int i = 0; i < [gridArray count]; i++)
    {
        SKSpriteNode *imageNode =[gridArray objectAtIndex:i];
        NSString *image = [gridImagesArray objectAtIndex:i];
        if ([imageNode.name isEqualToString:node.name])
        {
            SKAction *change = [SKAction setTexture:[SKTexture textureWithImage:[UIImage imageNamed:image]]];
            [node runAction:change];
            return node;
        }
        
    }
     return node;
}
-(void)hideCube:(SKNode *)node{
    SKSpriteNode *imageNode =[[SKSpriteNode alloc] initWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"unkown.png"]]];

    for (int i = 0; i < [self.children count]; i++)
    {
        SKSpriteNode *n = (SKSpriteNode *)[self.children objectAtIndex:i];
        
        if ([node.name isEqualToString: n.name])
        {
            int nam = (int)[node.name integerValue];
            if (nam > 0)
            {
                [n setTexture:imageNode.texture];
            }
        }
    }
}
-(void)displayLoser{
    SKSpriteNode *lose = [SKSpriteNode spriteNodeWithImageNamed:@"lose.png"];
    lose.position = CGPointMake(screenWidth/2, screenHeight/1.15);
    if (timerLabel)[timerLabel removeFromParent];
     [self addChild:lose];
}

-(void)displayWinner{
    [timerLabel removeAllActions];
    [timerLabel removeFromParent];
    SKSpriteNode *win = [SKSpriteNode spriteNodeWithImageNamed:@"win0.png"];
    win.position = CGPointMake(screenWidth/2, screenHeight/1.15);
    [self addChild:win];
    
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

-(void)startTimer{
    timerLabel = [[SKLabelNode alloc] initWithFontNamed:@"Impact"];
    timerLabel.text = @"30";
    timerLabel.fontSize = 50;
    timerLabel.fontColor = [UIColor orangeColor];
    timerLabel.position = CGPointMake(screenWidth/2, screenHeight/1.2);
    [self addChild:timerLabel];
    
    __block int count = 30;
    SKAction *wait = [SKAction waitForDuration:0.9];
    SKAction *countDown = [SKAction runBlock:^{
        count--;
        timerLabel.text = [NSString stringWithFormat:@"%i",count];
    }];
    
    SKAction *sequence = [SKAction sequence:@[wait,countDown]];
    
    [timerLabel runAction:[SKAction repeatAction:sequence count:30] completion:^{
        [self displayLoser];
        resultingCube = nil;
        isEnd = true;
        didLose = true;
        [timerLabel removeFromParent];
    }];
}
-(void)addInstructions{
    instruct = [[SKLabelNode alloc] initWithFontNamed:@"Impact"];
    instruct.text = [NSString stringWithFormat:@"Tap to start!"];
    instruct.fontSize = 20;
    instruct.fontColor = [UIColor orangeColor];
    instruct.position = CGPointMake(screenWidth/2, screenHeight/1.2);
    
    SKLabelNode *instruct2 = [[SKLabelNode alloc] initWithFontNamed:@"Impact"];
    instruct2.text = [NSString stringWithFormat:@"(Don't touch the 'x' cube!)"];
    instruct2.fontSize = 20;
    instruct2.fontColor = [UIColor orangeColor];
    instruct2.position = CGPointMake(0, -20);
    
    [instruct addChild:instruct2];
    [self addChild:instruct];
}
@end
