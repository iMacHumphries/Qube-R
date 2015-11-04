//
//  SKCube.m
//  qube-r
//
//  Created by Benjamin Humphries on 10/21/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import "SKCube.h"

@implementation SKCube
@synthesize name;
@synthesize rarity;
@synthesize imageName;
@synthesize ID;
@synthesize IDArray;
@synthesize isUnlocked;

-(id)initWithName:(NSString *)_name rarity:(NSString *)_rarity imageNamed:(NSString *)_imageName isUnlocked:(BOOL)_isUnlocked{
    
    self.name = _name;
    self.rarity = _rarity;
    self.imageName = _imageName;
    self = [super initWithImageNamed:_imageName];
    self.isUnlocked = _isUnlocked;
    if (isUnlocked)
        self.ID = [self getNewID];
    isUnlocked = true;
    NSLog(@"creating new Cube with ID %i",ID);
    return self;
}

-(int)getNewID{
    IDArray = [[NSMutableArray alloc]initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"IDArray"]];
    
    int _ID = 1;
    if (![self.IDArray isEqual:nil])
        _ID = IDArray.count;
    
    [IDArray addObject:[NSNumber numberWithInt:_ID]];
    [[NSUserDefaults standardUserDefaults] setObject:IDArray forKey:@"IDArray"];
    return _ID;
}
-(BOOL)getIsUnlocked{
    return self.isUnlocked;
}
-(NSString *)getID{
    return [NSString stringWithFormat:@"%i",self.ID];
}
//getters
-(NSString *)getName{
    return self.name;
}
-(NSString *)getRarity{
    return self.rarity;
}
-(NSString *)getImageName{
    return self.imageName;
}

@end
