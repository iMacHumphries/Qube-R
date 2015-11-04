//
//  SKMenuScene.m
//  qube-r
//
//  Created by Benjamin Humphries on 10/29/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import "SKMenuScene.h"

@implementation SKMenuScene
@synthesize motionManager;
@synthesize mainMenuViewController;
@synthesize isGravity;


-(id)initWithSize:(CGSize)size{
    if (self)
    {
        self = [super initWithSize:size];
    }
    isGravity = false;
    self.physicsWorld.contactDelegate=self;
    self.physicsWorld.gravity = CGVectorMake(0, 0);
    self.physicsBody=[SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    [self setupScreenSize];
    [self setupMenu];
    [self setupMotion];
    
    return self;
}
-(void)setupScreenSize{
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    screenWidth = screenSize.width;
    screenHeight =screenSize.height;
}
-(void)setupMenu{
    
    const CGFloat CENTER_X = screenWidth/2;
    
    SKSpriteNode *back = [[SKSpriteNode alloc]initWithImageNamed:@"menu.png"];
    back.position = CGPointMake(CENTER_X, screenHeight/2);
    [self addChild:back];
    
    titleButton = [[SKSpriteNode alloc]initWithImageNamed:@"title.png"];
    [titleButton setPosition:CGPointMake(CENTER_X, screenHeight/1.2)];
    [titleButton setName:@"title"];
    [self addChild:titleButton];
    
    scanButton = [[SKSpriteNode alloc]initWithImageNamed:@"scanButton.png"];
    [scanButton setPosition:CGPointMake(CENTER_X, titleButton.position.y - scanButton.frame.size.height *2)];
    [scanButton setName:@"scan"];
    [self addChild:scanButton];
    
    battleButton = [[SKSpriteNode alloc]initWithImageNamed:@"battleButton.png"];
    [battleButton setPosition:CGPointMake(CENTER_X, scanButton.position.y - battleButton.frame.size.height - 20)];
    [battleButton setName:@"battle"];
    [self addChild:battleButton];
    
    cubesButton = [[SKSpriteNode alloc]initWithImageNamed:@"cubesButton.png"];
    [cubesButton setPosition:CGPointMake(CENTER_X, battleButton.position.y - cubesButton.frame.size.height - 20)];
    [cubesButton setName:@"cubes"];
    [self addChild:cubesButton];

    [self buttonPhysics];
    
}
-(void)buttonPhysics{
    const float RESTITUTION = 0.7;
    [scanButton setPhysicsBody:[SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(scanButton.size.width, scanButton.size.height)]];
    [scanButton.physicsBody setRestitution:RESTITUTION];
    
    [battleButton setPhysicsBody:[SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(battleButton.size.width, battleButton.size.height)]];
    [battleButton.physicsBody setRestitution:RESTITUTION];
    
    [cubesButton setPhysicsBody:[SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(cubesButton.size.width, cubesButton.size.height)]];
    [cubesButton.physicsBody setRestitution:RESTITUTION];

    
}
-(void)setupMotion{
    self.motionManager = [[CMMotionManager alloc] init];
    [self.motionManager startAccelerometerUpdates];
}
-(void)processUserMotionForUpdate:(NSTimeInterval)currentTime {
    
    if (isGravity)
    {
        CMAccelerometerData* data = self.motionManager.accelerometerData;
        CGVector v = CGVectorMake(20.0 * data.acceleration.x, data.acceleration.y *20);
        [self.physicsWorld setGravity:v];
    }
    
}
-(void)update:(NSTimeInterval)currentTime{
    [self processUserMotionForUpdate:currentTime];
}

-(void)toggleGravity{
    isGravity = !isGravity;
    if (!isGravity)
    {
        [[scanButton physicsBody] setDynamic:NO];
        [[battleButton physicsBody] setDynamic:NO];
        [[cubesButton physicsBody] setDynamic:NO];
    }
    else {
        [[scanButton physicsBody] setDynamic:YES];
        [[battleButton physicsBody] setDynamic:YES];
        [[cubesButton physicsBody] setDynamic:YES];

    }
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches)
    {
        CGPoint location = [touch locationInNode:self];
        SKSpriteNode *node= (SKSpriteNode *)[self nodeAtPoint:location];
        
        if ([node.name isEqualToString:@"scan"] || [node.name isEqualToString:@"battle"]|| [node.name isEqualToString:@"cubes"]) {
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
        
        if ([node.name isEqualToString:@"scan"])
        {
            [mainMenuViewController scanButton:nil];
        }
        else if ([node.name isEqualToString:@"battle"])
        {
            
        }
        else if ([node.name isEqualToString:@"cubes"])
        {
            [mainMenuViewController viewButton:nil];
        }
        else if ([node.name isEqualToString:@"title"])
        {
            [self toggleGravity];
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
-(void)setMainMenuViewController:(MainMenuViewController *)_mainMenuViewController{
    mainMenuViewController = (MainMenuViewController *)_mainMenuViewController;
}
@end
