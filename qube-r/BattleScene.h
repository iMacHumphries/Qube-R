//
//  BattleScene.h
//  qube-r
//
//  Created by Benjamin Humphries on 10/21/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "BattleCube.h"
#import "Player.h"

@interface BattleScene : SKScene{
    CGFloat screenWidth;
    CGFloat screenHeight;
    
    SKSpriteNode *battleMenuNode;
    
    Player *player1;
    Player *player2;
    Player *currentPlayer;
    
    
}
@property (retain, nonatomic) SKSpriteNode *battleMenuNode;
@property (retain, nonatomic) Player *player1;
@property (retain, nonatomic) Player *player2;
@property (retain, nonatomic) Player *currentPlayer;

-(void)setPlayer1:(Player *)_player;
-(void)setPlayer2:(Player *)_player;


-(id)initWithSize:(CGSize)size;
@end
