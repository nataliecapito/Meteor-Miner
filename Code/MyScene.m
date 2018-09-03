//
//  MyScene.m
//  Meteor Miner
//
//  Created by Natalie Capito on 9/3/18.
//  Copyright © 2018 Natalie Capito. All rights reserved.
//

#import "MyScene.h"
#import "FMMParallaxNode.h"
#import "Asteroid.h"
#import "AsteroidController.h"
#define kNumAsteroids   15

@implementation MyScene

{
    SKSpriteNode *_ship;    //Sprite defined for the ship layer
    NSMutableArray *asteroidArray; //Array defined for asteroids
    AsteroidController *asteroidController; //Reference to asteroidController (where randomization occurs)
    SKNode *_hudNode; //Scoring and menu
    SKSpriteNode *_tapToStartNode; //Node for play button
    SKSpriteNode *_tapToHelpNode; //Node for help button

    int gameState;
    SKLabelNode* _scoreLabelNode;
    NSInteger _score;
    SKSpriteNode *_healthBar;
    CGFloat _health;

}

FMMParallaxNode *_parallaxSpace; //Background node defined

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {

        NSLog(@"SKScene:initWithSize %f x %f",size.width,size.height);

        self.backgroundColor = [SKColor blackColor];

#pragma mark - TBD - Game Backgrounds

        NSArray *parallaxBackgroundNames = @[@"Space.png"]; //Space background node implemented

        CGSize planetSizes = CGSizeMake(450.0, 650.0);

        //Scaling the space background
        _parallaxSpace = [[FMMParallaxNode alloc] initWithBackgrounds:parallaxBackgroundNames
                                                                           size:planetSizes
                                                           pointsPerSecondSpeed:10.0];
        [_parallaxSpace setXScale:1.0];
        [_parallaxSpace setYScale:1.0];
        _parallaxSpace.position = CGPointMake(self.frame.size.width / 250.0, self.frame.size.height/20.0);


        //Displays background
        [self addChild:_parallaxSpace];


#pragma mark - Setup Sprite for the ship

        //Create space sprite, setup position on left edge centered on the screen, and add to scene
        _ship = [SKSpriteNode spriteNodeWithImageNamed:@"Ship3.png"];
        [_ship setXScale:0.5];
        [_ship setYScale:0.5];
        _ship.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
        _ship.zPosition = 100;
        [self addChild:_ship];

#pragma mark - TBD - Setup the asteroids

        //Fills the array with asteroids and assigns an image as well as initial scaling.
        asteroidArray = [[NSMutableArray alloc] initWithCapacity:kNumAsteroids];
        for (int i = 0; i < kNumAsteroids; ++i) {
            Asteroid *asteroid = [[Asteroid alloc] initWithImageNamed:@"Asteroid 2a.png"];
            [asteroid setXScale:0.8];
            [asteroid setYScale:0.8];
            [asteroidArray addObject:asteroid];
            [self addChild:asteroid];
            asteroid.position = CGPointMake(arc4random_uniform(256), arc4random_uniform(256));
        }

        asteroidController = [[AsteroidController alloc] init];

#pragma mark - TBD - Setup the lasers

#pragma mark - TBD - Setup the Accelerometer to move the ship

#pragma mark - TBD - Setup the stars to appear as particles

#pragma mark - TBD - Start the actual game

        //begin menu
        // HUD
        _hudNode = [SKNode node];
        [self addChild:_hudNode];

        // Tap to Start
        _tapToStartNode = [SKSpriteNode spriteNodeWithImageNamed:@"menuname"];
        _tapToStartNode.position = CGPointMake(160, 300.0f);
        [_hudNode addChild:_tapToStartNode];
        _tapToStartNode = [SKSpriteNode spriteNodeWithImageNamed:@"menuplay"];
        _tapToStartNode.position = CGPointMake(160, 225.0f);
        [_hudNode addChild:_tapToStartNode];
        _tapToHelpNode = [SKSpriteNode spriteNodeWithImageNamed:@"menuhelp"];
        _tapToHelpNode.position = CGPointMake(160, 180.0f);
        [_hudNode addChild:_tapToHelpNode];


        gameState = 0;

        // Initialize label and create a label which holds the score
        _score = [self getHighScore];
        _scoreLabelNode = [SKLabelNode labelNodeWithFontNamed:@"KannadaSangamMN"];
        _scoreLabelNode.position = CGPointMake(280, 41.0f);        _scoreLabelNode.zPosition = 100;
        _scoreLabelNode.text = [NSString stringWithFormat:@"%03d", _score];
        [self addChild:_scoreLabelNode];

        //Creates healthbar and positions it on the screen
        _health = 100.0;
        _healthBar = [SKSpriteNode spriteNodeWithColor:[UIColor colorWithRed:0.0f green:255.0f blue:0.0f alpha:1.0f] size:CGSizeMake(100.0f, 16.0f)];
        _healthBar.anchorPoint = CGPointMake(0, 0.5);
        _healthBar.position = CGPointMake(118.0f, 54.0f);
        [self addChild:_healthBar];
    }
    return self;
}

- (float)randomValueBetween:(float)low andValue:(float)high {
    return (((float) arc4random() / 0xFFFFFFFFu) * (high - low)) + low;
}

-(void)updateScoreLabel:(NSInteger)value {
    _scoreLabelNode.text = [NSString stringWithFormat:@"%03d", value];
}

-(void)updateHealth:(CGFloat)width
{
    _healthBar.size = CGSizeMake(width, 16.0f);

    if(width < 25)
    {
     _healthBar.color = [UIColor colorWithRed:255.0 green:0.0 blue:0.0f alpha:1.0f];
    }
    else if(width < 50)
    {
        _healthBar.color = [UIColor colorWithRed:255.0 green:255.0 blue:0.0f alpha:1.0f];
    }
    else
    {
        _healthBar.color = [UIColor colorWithRed:0.0 green:255.0 blue:0.0f alpha:1.0f];
    }

}

-(void)showTitleScreen
{
    //begin menu
    // HUD
    _hudNode = [SKNode node];
    [self addChild:_hudNode];

    // Tap to Start
    _tapToStartNode = [SKSpriteNode spriteNodeWithImageNamed:@"menuname"];
    _tapToStartNode.position = CGPointMake(160, 300.0f);
    [_hudNode addChild:_tapToStartNode];
    _tapToStartNode = [SKSpriteNode spriteNodeWithImageNamed:@"menuplay"];
    _tapToStartNode.position = CGPointMake(160, 225.0f);
    [_hudNode addChild:_tapToStartNode];
    _tapToHelpNode = [SKSpriteNode spriteNodeWithImageNamed:@"menuhelp"];
    _tapToHelpNode.position = CGPointMake(160, 180.0f);
    [_hudNode addChild:_tapToHelpNode];

    [self updateScoreLabel:[self getHighScore]];
}


-(void)clearAllAsteroids
{
    for(Asteroid* asteroid in asteroidArray)
    {
        [asteroid recycle];
    }
}

-(void)updateHighScore
{
    //Get access to standardUserDefaults singleton
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //Get the current high score
    int currentHigh = [defaults integerForKey:@"hiscore"];

    //Stop if the current score is less than the current high score
    if(_score < currentHigh)
    {
        return;
    }

    //Save high score
    [defaults setInteger:_score forKey:@"hiscore"];

    [defaults synchronize];
}

-(int)getHighScore
{
    //Get access to standardUserDefaults singleton
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //Get the current high score
    int currentHigh = [defaults integerForKey:@"hiscore"];

    return currentHigh;
}

-(void)update:(NSTimeInterval)currentTime {
    [asteroidController update:currentTime];
    /* Called before each frame is rendered */
    for (Asteroid *asteroid in asteroidArray)
    {
        if(asteroid.enabled)
        {
            [asteroid update:currentTime];
        }
        else if(!asteroidController.timeToNextAsteroid)
        {
            [asteroidController placeAsteroid:asteroid];
            [asteroidController randomizeTimeToNextAsteroid];

        }
    }

    if(gameState == 1) //Game is running
    {
        if(_health>0)
        {
            _health-=0.033;
        }
        else //No health left
        {
            [self updateHighScore];
            _tapToHelpNode = [SKSpriteNode spriteNodeWithImageNamed:@"gameover"];
            _tapToHelpNode.position = CGPointMake(165, 290);
            _tapToHelpNode.zPosition = 100;
            [self addChild:_tapToHelpNode];

            //Use asteroid controller's timer
            asteroidController.timeToNextAsteroid = 240;

            gameState = 3;
        }
        [self updateHealth:_health];
    }
    else if(gameState == 3) //Game Over is displayed
    {
        if(asteroidController.timeToNextAsteroid <= 1) //Time to return to title screen
        {
            //remove child: game over sprite
            [_tapToHelpNode removeFromParent];
            [self showTitleScreen];
            gameState = 0;
        }
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];

    if(gameState == 0) //Title screen
    {
        if([_tapToStartNode containsPoint:location])
        {
            [_hudNode removeFromParent];
            _health = 100; [self updateHealth:_health];
            _score = 0; [self updateScoreLabel:_score];
            [self clearAllAsteroids];
            gameState =1;
        }
        else if([_tapToHelpNode containsPoint:location])
        {
            [_hudNode removeFromParent];
            //Display help sprite
            _tapToHelpNode = [SKSpriteNode spriteNodeWithImageNamed:@"helpscreen"];
            _tapToHelpNode.position = CGPointMake(160, 225);
            [self addChild:_tapToHelpNode];
            gameState =2; //Help screen is displayed
        }
    }
    /* Determains which color asteroid you contact and what the consequences are. Yellow updates score by one, blue increases oxygen by 1/5, and red decreases the oxygen by 50%  */
    else if (gameState == 1) //Game is running
    {
        for(Asteroid *asteroid in asteroidArray)
        {
            if( asteroid.enabled && [asteroid containsPoint:location] )
            {
                switch (asteroid.type) {
                    case 0: //yellow
                        _score ++;
                        [self updateScoreLabel:_score];
                        break;

                    case 1: //blue
                        _health += 19.8;
                        if(_health > 100) {_health = 100;}
                        [self updateHealth:_health];
                        break;

                    case 2: //red
                        _health *=0.5;
                        [self updateHealth:_health];
                        break;

                    default:
                        break;
                }
                [asteroid recycle];
            }
        }
    }
    else if(gameState == 2) //Help is displayed
    {
        //removes help sprite node upon clicking it
        [_tapToHelpNode removeFromParent];
        [self showTitleScreen];
        gameState = 0;
    }

}




@end
