//
//  CubeGenerator.m
//  qube-r
//
//  Created by Benjamin Humphries on 10/30/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import "CubeGenerator.h"

@implementation CubeGenerator
@synthesize commons,uncommons,rares,ultraRares;
@synthesize dic;

-(id)init{
    if (self)
    {
        self = [super init];
        [self initializeArrays];
        [self fillArrays];
        NSLog(@"cube generator initialized!");
    }
    return self;
}
-(void)initializeArrays{
    self.commons = [[NSMutableArray alloc]init];
    self.uncommons = [[NSMutableArray alloc]init];
    self.rares = [[NSMutableArray alloc]init];
    self.ultraRares = [[NSMutableArray alloc]init];
}
-(void)fillArrays{
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
    NSString *documentsDirectory = [paths objectAtIndex:0]; //2
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"BaseCubeInfo.plist"]; //3
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: path]) //4
    {
       NSString *bundle = [[NSBundle mainBundle] pathForResource:@"BaseCubeInfo" ofType:@"plist"]; //5
        
        [fileManager copyItemAtPath:bundle toPath: path error:&error]; //6
    }
    
   dic = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    for (int x = 0; x < [self getTotalCubes]; x++)
    {
        NSArray *array = [dic objectForKey:[NSString stringWithFormat:@"cube%i",x]];
        NSString *rar = [array objectAtIndex:2];
        BattleCube *cube;
        cube = [[BattleCube alloc]initWithName:
                [array objectAtIndex:0]
                rarity:[array objectAtIndex:2]
                imageNamed:[array objectAtIndex:1]
                health:[[array objectAtIndex:3]floatValue]
                speed:[[array objectAtIndex:4] floatValue]
                isUnlocked:false];
       // NSLog(@"cube name: %@",[cube getName]);
        
        if ([rar isEqualToString:@"common"])
            [commons addObject:cube];
        else if ([rar isEqualToString:@"uncommon"])
            [uncommons addObject:cube];
        else if ([rar isEqualToString:@"rare"])
            [rares addObject:cube];
        else if ([rar isEqualToString:@"ultra-rare"])
            [ultraRares addObject:cube];
        else
        {
            NSLog(@"ERROR unknown rarity!");
        }
    }

}
-(NSInteger)getTotalCubes{
    return [dic count];
}
-(NSInteger)getTotalCubesUnlocked{
    //it works okay...
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"IDArray"] count];
}
/*Uses self getRandomRarity and self getRandomCubeFor that rarity*/
-(BattleCube *)generateRandomCube{
    BattleCube *cube;
    NSString *rarity = [self getRandomRarity];
    cube = [self getRandomCubeForRarity:rarity];
    
    return cube;
}
/*chooses random rarity based on a weighted system.*/
-(NSString *)getRandomRarity{
    
    //common 0-75
    //uncommon 76-90
    //rare 91 -98
    //Ultra-Rare 99-100
    
    int rand = arc4random()%101;
    NSString *r = @"";
    if(rand <= 75){
        r = @"common";
    }
    else if (rand > 75 && rand <= 90){
        r = @"uncommon";
    }
    else if (rand > 90 && rand <= 98){
        r = @"rare";
    }
    else if (rand == 99 || rand >= 100){
        r = @"ultra-rare";
    }
    return r;
}
/*return random battlecube for a specific rarity.*/
-(BattleCube *)getRandomCubeForRarity:(NSString *)r{
    
    if ([r isEqualToString:@"random"])
    {
        r = [self getRandomRarity];
        NSLog(@"this was called!");
    }
   
    BattleCube *cube;
    int rand = 0;
    
    if ([r isEqualToString:@"common"]){
        rand = arc4random() % ([commons count] );
        cube = [commons objectAtIndex:rand];
    }
    else if ([r isEqualToString:@"uncommon"]){
        rand = arc4random() % ([uncommons count] );
        cube = [uncommons objectAtIndex:rand];
    }
    else if ([r isEqualToString:@"rare"]){
        rand = arc4random() % ([rares count] );
        cube = [rares objectAtIndex:rand];
    }
    else if ([r isEqualToString:@"ultra-rare"]){
        rand = arc4random() % ([ultraRares count]);
        cube = [ultraRares objectAtIndex:rand];
    }
    else {
        NSLog(@"CUBE GEN ERROR: UNKOWN RARITY");
    }
    
    return cube;
}

-(BattleCube *)unlockRandomCube{
    BattleCube *c = [self generateRandomCube];
    BattleCube *newCube = [self unlockCube:c];
    return newCube;
}
-(BattleCube *)unlockCube:(BattleCube *)_cube{
    
    BattleCube *newCube = [[BattleCube alloc]initWithName:[_cube getName] rarity:[_cube getRarity] imageNamed:[_cube getImageName] health:[_cube getHealth] speed:[_cube getSpeed] isUnlocked:true];

    
    NSLog(@"unloking : %@ with ID: %@ image:%@",[newCube getName],[newCube getID],[newCube getImageName]);
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"gameData"];
     NSArray *gameData = [[NSMutableArray alloc]initWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
    
    
    NSMutableArray *g = [[NSMutableArray alloc]initWithArray:gameData];
   // [gameData setObject:newCube forKey:[newCube getID]];
    [g addObject:newCube];
    NSLog(@"gameData: %@",g);
    NSArray *gData = [[NSMutableArray alloc]initWithArray:g];
    [[NSUserDefaults standardUserDefaults]setObject:[NSKeyedArchiver archivedDataWithRootObject:gData] forKey:@"gameData"];
    
    return newCube;

}
-(int)getTotalCubesNamed:(NSString *)_name{
    int total = 0;
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"gameData"];
    NSArray *gameData = [[NSMutableArray alloc]initWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
   
    for (int i = 0; i < [gameData count]; i++)
    {
        if ([[[gameData objectAtIndex:i] getName] isEqualToString:_name])
            total++;
        NSLog(@"icalled");
    }
    return total;
}
@end
