//
//  AsteroidController.h
//  Meteor Miner
//
//  Created by Natalie Capito on 9/3/18.
//  Copyright © 2018 Natalie Capito. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Asteroid.h"

@interface AsteroidController : SKNode

@property (nonatomic, assign) int timeToNextAsteroid;

-(void)update:(NSTimeInterval)currentTime;
-(void)placeAsteroid:(Asteroid*) asteroid;
-(void)randomizeTimeToNextAsteroid;


@end
