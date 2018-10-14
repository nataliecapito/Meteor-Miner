//
//  AsteroidController.h
//  Meteor Miner
//
//  Created by SVC Mobile App Project Group - 3 on 3/12/14.
//  Copyright (c) 2018 Natalie Capito. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Asteroid.h"

@interface AsteroidController : SKNode

@property (nonatomic, assign) int timeToNextAsteroid;

-(void)update:(NSTimeInterval)currentTime;
-(void)placeAsteroid:(Asteroid*) asteroid;
-(void)randomizeTimeToNextAsteroid;

@end
