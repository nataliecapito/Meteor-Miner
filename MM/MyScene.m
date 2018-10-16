//
//  MyScene.m
//  Meteor Miner
//
//  Created by SVC Mobile App Project Group - 3 on 3/12/14.
//  Copyright (c) 2018 Natalie Capito. All rights reserved.
//

#import "MyScene.h"
#import "FMMParallaxNode.h"
#import "Asteroid.h"
#import "AsteroidController.h"

#define kNumAsteroids   15

@implementation MyScene

{
    SKSpriteNode *_ship; // 1
    NSMutableArray *asteroidArray;
    
    AsteroidController *asteroidController;
    
    SKNode *_hudNode; // scoring and menu
    SKSpriteNode *_tapToStartNode; // tap to start node
    SKSpriteNode *_tapToHelpNode;
    
    int gameState;
    
    SKLabelNode* _scoreLabelNode;
    NSInteger _score;
    SKSpriteNode *_healthBar;
    CGFloat _health;
    
}

FMMParallaxNode *_parallaxSpace;

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
#pragma mark - Start
        NSLog(@"SKScene:initWithSize %f x %f",size.width,size.height);
        self.backgroundColor = [SKColor blackColor];
        
#pragma mark - Game Backgrounds
        NSArray *parallaxBackgroundNames = @[@"Space.png"];
        CGSize planetSizes = CGSizeMake(450.0, 650.0);
        
        _parallaxSpace = [
                          [FMMParallaxNode alloc]
                          initWithBackgrounds:parallaxBackgroundNames
                          size:planetSizes
                          pointsPerSecondSpeed:10.0
                        ];
        [_parallaxSpace setXScale:1.5];
        [_parallaxSpace setYScale:1.5];
        _parallaxSpace.position = CGPointMake(0, 0);
        [self addChild:_parallaxSpace];

#pragma mark - Setup Sprite for the ship
        _ship = [SKSpriteNode spriteNodeWithImageNamed:@"Ship3.png"];
        [_ship setXScale:0.7];
        [_ship setYScale:0.7];
        _ship.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:_ship];
        
#pragma mark - Setup the asteroids
        asteroidArray = [[NSMutableArray alloc] initWithCapacity:kNumAsteroids];
        
        for (int i = 0; i < kNumAsteroids; ++i) {
            Asteroid *asteroid = [[Asteroid alloc] initWithImageNamed:@"Asteroid 2a.png"];
            [asteroid setXScale:1.0];
            [asteroid setYScale:1.0];
            [asteroidArray addObject:asteroid];
            [self addChild:asteroid];
            asteroid.position = CGPointMake(arc4random_uniform(256), arc4random_uniform(256));
        }
        
        asteroidController = [[AsteroidController alloc] init];
        
#pragma mark - Start the actual game
        // Begin menu
        _hudNode = [SKNode node];
        [self addChild:_hudNode];
        
        // Tap to Start
        _tapToStartNode = [SKSpriteNode spriteNodeWithImageNamed:@"menuname"];
        _tapToStartNode.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height * 0.60);
        [_hudNode addChild:_tapToStartNode];
        // Tap to Play
        _tapToStartNode = [SKSpriteNode spriteNodeWithImageNamed:@"menuplay"];
        _tapToStartNode.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height * 0.40);
        [_hudNode addChild:_tapToStartNode];
        // Tap to Help
        _tapToHelpNode = [SKSpriteNode spriteNodeWithImageNamed:@"menuhelp"];
        _tapToHelpNode.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height * 0.30);
        [_hudNode addChild:_tapToHelpNode];
        
        gameState = 0;
        
        // Score
        _score = [self getHighScore];
        _scoreLabelNode = [SKLabelNode labelNodeWithFontNamed:@"KannadaSangamMN"];
        _scoreLabelNode.position = CGPointMake(self.frame.size.width * 0.9, self.frame.size.height * 0.94);
        _scoreLabelNode.text = [NSString stringWithFormat:@"%03d", _score];
        [self addChild:_scoreLabelNode];
        
        // Health bar
        _health = 100.0;
        _healthBar = [SKSpriteNode spriteNodeWithColor:[UIColor
                                                        colorWithRed:0.0f
                                                        green:255.0f
                                                        blue:0.0f
                                                        alpha:1.0f
                                                        ]
                                                  size:CGSizeMake(100.0f, 16.0f)];
        _healthBar.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height * 0.95);
        [self addChild:_healthBar];
    }
    
    return self;
}

// asteroid random generator
- (float)randomValueBetween:(float)low andValue:(float)high {
    return (((float) arc4random() / 0xFFFFFFFFu) * (high - low)) + low;
}

// score update
-(void)updateScoreLabel:(NSInteger)value {
    _scoreLabelNode.text = [NSString stringWithFormat:@"%03d", value];
}

// health bar update
-(void)updateHealth:(CGFloat)width
{
    _healthBar.size = CGSizeMake(width, 16.0f);

    if (width < 25)
    {
     _healthBar.color = [UIColor
                         colorWithRed:255.0
                         green:0.0
                         blue:0.0f
                         alpha:1.0f
                         ];
    }
    else if (width < 50)
    {
        _healthBar.color = [UIColor
                            colorWithRed:255.0
                            green:255.0
                            blue:0.0f
                            alpha:1.0f
                            ];
    }
    else
    {
        _healthBar.color = [UIColor
                            colorWithRed:0.0
                            green:255.0
                            blue:0.0f
                            alpha:1.0f
                            ];
    }

}

-(void)showTitleScreen
{
    // Begin menu
    _hudNode = [SKNode node];
    [self addChild:_hudNode];
    
    // Tap to Start
    _tapToStartNode = [SKSpriteNode spriteNodeWithImageNamed:@"menuname"];
    _tapToStartNode.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height * 0.60);
    [_hudNode addChild:_tapToStartNode];
    // Tap to Play
    _tapToStartNode = [SKSpriteNode spriteNodeWithImageNamed:@"menuplay"];
    _tapToStartNode.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height * 0.40);
    [_hudNode addChild:_tapToStartNode];
    // Tap to Help
    _tapToHelpNode = [SKSpriteNode spriteNodeWithImageNamed:@"menuhelp"];
    _tapToHelpNode.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height * 0.30);
    [_hudNode addChild:_tapToHelpNode];

    [self updateScoreLabel:[self getHighScore]];
}

// clear the asteroids
-(void)clearAllAsteroids
{
    for(Asteroid* asteroid in asteroidArray)
    {
        [asteroid recycle];
    }
}

-(void)updateHighScore
{
    // Get access to standardUserDefaults singleton
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // Get the current high score
    int currentHigh = [defaults integerForKey:@"hiscore"];
    
    // Stop if the current score is less than the current high score
    if(_score < currentHigh)
    {
        return;
    }
    
    // Save high score
    [defaults setInteger:_score forKey:@"hiscore"];
    [defaults synchronize];
}

-(int)getHighScore
{
    // Get access to standardUserDefaults singleton
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // Get the current high score
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
    
    if(gameState == 1) // Game is running
    {
        if(_health>0)
        {
            _health-=0.033;
        }
        else // No health left
        {
            [self updateHighScore];
            
            // Replace with game over image
            _tapToHelpNode = [SKSpriteNode spriteNodeWithImageNamed:@"gameover"];
            _tapToHelpNode.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height * 0.6);
            [self addChild:_tapToHelpNode];

            // Use asteroid controller's timer
            asteroidController.timeToNextAsteroid = 240;
            gameState = 3;
        }
        [self updateHealth:_health];
    }
    else if(gameState == 3) // Game Over is displayed
    {
        if(asteroidController.timeToNextAsteroid <= 1) // Time to return to title screen
        {
            // Remove child: game over sprite
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
    
    // Title screen
    if(gameState == 0)
    {
        if([_tapToStartNode containsPoint:location])
        {
            [_hudNode removeFromParent];
            _health = 100; [self updateHealth:_health];
            _score = 0; [self updateScoreLabel:_score];
            [self clearAllAsteroids];
            gameState =1;
        }
        
        // Display help sprite
        // Add sprite as child replace image with correct one
        else if([_tapToHelpNode containsPoint:location])
        {
            [_hudNode removeFromParent];
            _tapToHelpNode = [SKSpriteNode spriteNodeWithImageNamed:@"helpscreen"];
            _tapToHelpNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
            _tapToHelpNode.size = CGSizeMake(
                                             (CGRectGetMidX(self.frame) + 90),
                                             (CGRectGetMidY(self.frame)  + 90)
                                             );
            [self addChild:_tapToHelpNode];
            gameState =2;
        }
    }
    
    // Game is running
    else if (gameState == 1)
    {
        for(Asteroid *asteroid in asteroidArray)
        {
            if( asteroid.enabled && [asteroid containsPoint:location] )
            {
                switch (asteroid.type) {
                    case 0: // yellow
                        _score ++;
                        [self updateScoreLabel:_score];
                        break;
                        
                    case 1: // blue
                        _health +=25;
                        if(_health > 100){
                            _health = 100;
                        }
                        [self updateHealth:_health];
                        break;
                        
                    case 2: // red
                        _health -=50;
                        [self updateHealth:_health];
                        break;
                        
                    default:
                        break;
                }
                [asteroid recycle];
            }
        }
    }
    
    // Help is displayed
    else if(gameState == 2)
    {
        // Remove child: help sprite
        [_tapToHelpNode removeFromParent];
        [self showTitleScreen];
        gameState = 0;
    }
    
}

@end
