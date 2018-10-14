//
//  Asteroid.h
//  Meteor Miner
//
//  Created by SVC Mobile App Project Group - 3 on 3/12/14.
//  Copyright (c) 2018 Natalie Capito. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Asteroid : SKSpriteNode

@property (nonatomic, assign) CGFloat xSpeed, ySpeed;
@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, assign) int type;

-(void)update:(NSTimeInterval)currentTime;
-(void)recycle;

@end
