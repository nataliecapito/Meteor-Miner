//
//  AsteroidController.m
//  Meteor Miner
//
//  Created by Natalie Capito on 9/3/18.
//  Copyright © 2018 Natalie Capito. All rights reserved.
//

#import "AsteroidController.h"

@implementation AsteroidController

-(id)init{
    if (self = [super init]){
        self.timeToNextAsteroid = 60;
    }
    return self;
}

-(void)update:(NSTimeInterval)currentTime{
    if(self.timeToNextAsteroid)
    {
        self.timeToNextAsteroid--;
    }

}

/* Randomly spawns asteroid on one of the four screen edges—uses random variable chance to select a random horizontal and vertical speed. */
-(void)placeAsteroid:(Asteroid*) asteroid{
    int chance = arc4random_uniform(100);
    //int chance2 = arc4random_uniform(160);

    if (chance < 25) { //Left edge
        asteroid.position = CGPointMake(0, arc4random_uniform(480));
        asteroid.xSpeed = 0.195 * (chance % 80) + ((chance % 80 == 0)? 0.195: 0);
        asteroid.ySpeed = (asteroid.position.y < 240)? 0.1 * (chance % 40): -0.1 * (chance % 40);
    }
    else if (chance < 50)  //right edge
    {
        asteroid.position = CGPointMake(320, arc4random_uniform(480));
        asteroid.xSpeed = -0.195 * (chance % 80)  + ((chance % 80 == 0)? -0.195: 0);
        asteroid.ySpeed = (asteroid.position.y < 240)? 0.1 * (chance % 40): -0.1 * (chance % 40);
    }
    else if (chance < 75)  //Bottom edge
    {
        asteroid.position = CGPointMake(arc4random_uniform(320), 0);
        asteroid.xSpeed = (asteroid.position.x < 160)? 0.1 * (chance % 40): -0.1 * (chance % 40);
        asteroid.ySpeed = 0.190 * (chance % 80)  + ((chance % 80 == 0)? 0.195: 0);
    }
    else if (chance < 100) //Top edge
    {
        asteroid.position = CGPointMake(arc4random_uniform(320), 480);
        asteroid.xSpeed = (asteroid.position.x < 160)? 0.1 * (chance % 40): -0.1 * (chance % 40);
        asteroid.ySpeed = -0.190 * (chance % 80)  + ((chance % 80 == 0)? -0.195: 0);
    }

    chance = arc4random_uniform(100);
    if(chance < 70) //make asteroid yellow
    {
        [asteroid setColor:[UIColor colorWithRed:255 green:255 blue:0 alpha:1]];
        [asteroid setColorBlendFactor:1.0];
        asteroid.type = 0;
    }
    else if(chance < 85) //make asteroid blue
    {
        [asteroid setColor:[UIColor colorWithRed:97/255.0f green:200/255.0f blue:255/255.0f alpha:1.0f]];
        [asteroid setColorBlendFactor:8.0];
        asteroid.type = 1;
    }
    else //make asteroid red
    {
        [asteroid setColor:[UIColor colorWithRed:255 green:0 blue:0 alpha:1]];
        [asteroid setColorBlendFactor:3.0];
        asteroid.type = 2;
    }

    //Randomize Asteroid Size
    chance = arc4random_uniform(20);
    if((chance > 10) && (chance < 20))
    {
        [asteroid setXScale: 0.1 * (chance / 2)];
        [asteroid setYScale: 0.1 * (chance / 2)];
    }

    asteroid.enabled = true;
    asteroid.hidden = false;

}

-(void)randomizeTimeToNextAsteroid
{
    self.timeToNextAsteroid = 60;
}

@end
