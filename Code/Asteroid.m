//
//  Asteroid.m
//  Meteor Miner
//
//  Created by Natalie Capito on 9/3/18.
//  Copyright © 2018 Natalie Capito. All rights reserved.
//

#import "Asteroid.h"

@implementation Asteroid

-(id) initWithImageNamed:(NSString *)name {
    if (self = [super initWithImageNamed:name])
    {
        self.xSpeed = 0;
        self.ySpeed = 0;
        self.enabled = false;
        self.hidden = true;
        self.type = 0;
    }
    return self;
}

-(void)update:(NSTimeInterval)currentTime {

    self.position = CGPointMake(self.position.x + self.xSpeed, self.position.y + self.ySpeed);
    /* Determains whether or not the asteroid is in a clickable/viewable region. If it's off screen, recycle is called and the asteroids are deactivated */
    if (self.position.x < 0 || self.position.x > 320 || self.position.y < 0 || self.position.y > 480){
        [self recycle];
    }
}


-(void)recycle {
    self.enabled = false;
    self.hidden = true;
}


@end
