//
//  Asteroid.h
//  Meteor Miner
//
//  Created by Natalie Capito on 9/3/18.
//  Copyright © 2018 Natalie Capito. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Asteroid : SKSpriteNode

@property (nonatomic, assign) CGFloat xSpeed, ySpeed;
@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, assign) int type;

-(void)update:(NSTimeInterval)currentTime;
-(void)recycle;

@end
