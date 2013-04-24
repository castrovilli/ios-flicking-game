//
//  FlickingViewController.m
//  Flicking
//
//  Created by jschwartz on 5/4/10.
//  Copyright BSSP 2010. All rights reserved.
//

#import "FlickingViewController.h"

@implementation FlickingViewController


- (void)dealloc {
    [targets release];
    
    [super dealloc];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	/*
    scoreBoard = [[ScoreBoard alloc] initWithFrame:CGRectMake(0, 0, 2000, 2000)];
    [self.view addSubview:scoreBoard];
    [scoreBoard release];
    */
    
    // create targets
    targets = [[NSMutableArray alloc] init];
    
    
    float tSpacer = 24;
    float tx = tSpacer;
    float ty = tSpacer;
    
    for(int i = 0; i < 31; i++ ) {
        
        Target *t = [[Target alloc] initWithFrame:CGRectMake(tx, ty, 100, 100)];
        [targets addObject:t];
        [self.view addSubview:t];
        [t release];
        
        tx += t.frame.size.width + tSpacer;
        
        if(i%6 == 5) {
            tx = tSpacer;
            ty += t.frame.size.height + tSpacer;
        }
    }
    
    
	flickArea = [[FlickArea alloc] initWithFrame:CGRectMake(0,0,260,260)];
	flickArea.center = CGPointMake(768/2,1024 - 100);
	[self.view addSubview:flickArea];
	[flickArea release];
	
	ball = [[Projectile alloc] initWithFrame:CGRectMake(0,0,50,50)];
	ball.flickArea = flickArea;
	ball.mass = 4;
	[self.view addSubview:ball];
	[ball release];
 	
	NSTimer *ballTimer = [NSTimer scheduledTimerWithTimeInterval:1/60.0f target:self selector:@selector(timerHandler:) userInfo:nil repeats:YES];

	UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resetBall)];
	tapGestureRecognizer.numberOfTapsRequired = 2;
	[self.view addGestureRecognizer:tapGestureRecognizer];
	
	[super viewDidLoad];
}


- (void)resetBall
{
	ball.center = flickArea.center;
	[ball reset];
}

- (void)timerHandler:(NSTimer *)timer
{
    // move scoreboard
    /*float newScoreBoardX = scoreBoard.frame.origin.x + scoreBoard.vx;
    float newScoreBoardY = scoreBoard.frame.origin.y + scoreBoard.vy;
    
    if(newScoreBoardX >= 0) {
        newScoreBoardX = 0;
        scoreBoard.vx = scoreBoard.vx * -1;
    }
    if(newScoreBoardX <= 768 - scoreBoard.frame.size.width) {
        newScoreBoardX = 768 - scoreBoard.frame.size.width;
        scoreBoard.vx = scoreBoard.vx * -1;
    }
    
    if(newScoreBoardY >= 0) {
        newScoreBoardY = 0;
        scoreBoard.vy = scoreBoard.vy * -1;
    }
    if(newScoreBoardY <= 1024 - scoreBoard.frame.size.height) {
        newScoreBoardY = 1024 - scoreBoard.frame.size.height;
        scoreBoard.vy = scoreBoard.vy * -1;
    }
    
    scoreBoard.frame = CGRectMake(newScoreBoardX, 
                                  newScoreBoardY, 
                                  scoreBoard.frame.size.width,
                                  scoreBoard.frame.size.height);
    */
    
	// move ball
	
	if(!ball.beingDragged)
	{
        if(ball.inAir) {
            // apply physics to ball velocity
            float speed = sqrt(ball.vx * ball.vx + ball.vy * ball.vy);
            float angle = atan2(ball.vy, ball.vx);
            
            if(speed > kFriction)
                speed -= kFriction;
            else {
                speed = 0;
            }
            
            ball.vx = cos(angle) * speed;
            ball.vy = sin(angle) * speed + .98;
            
            
            // make new ball position variables
            float newBallX = ball.center.x + ball.vx;
            float newBallY = ball.center.y + ball.vy;
            
            // set new ball position
            ball.center = CGPointMake(newBallX, newBallY);
            
            
            
            if(ball.inAir)
            {
                // scale ball 
                ball.z -= kGravity;
                
                // detect if ball has hit wall
                if(ball.z <= kGroundZ)
                {
                    ball.z = kGroundZ;
                    ball.inAir = NO;
                    
                    NSLog(@"ball frame: %f", ball.frame.size.width);
                    
                    for(int i = 0; i < [targets count]; i++) {
                        
                        Target *t = [targets objectAtIndex:i];
                        
                        if(!t.hit) {
                            float dx = t.center.x - ball.center.x;
                            float dy = t.center.y - ball.center.y;
                            float dist = sqrt(dx*dx+dy*dy);
                            if(dist < t.frame.size.width/2 - ball.frame.size.width/2) {
                                t.hit = YES;
                            }
                        }
                    }
                }
            }
            
            
            float left = -50;
            float right = 810;//718;
            float top = -50;
            float bottom = 1024 + 50;
            
            if(ball.center.x <= left)
                ball.center = CGPointMake(left, ball.center.y);
            if(ball.center.x >= right)
                ball.center = CGPointMake(right, ball.center.y);
            if(ball.center.y <= top)
                ball.center = CGPointMake(ball.center.x, top);
            if(ball.center.y >= bottom)
                ball.center = CGPointMake(ball.center.x, bottom);
        }
	}
	else
	{
		float drag_dx = flickArea.center.x - ball.center.x;
		float drag_dy = flickArea.center.y - ball.center.y;
		float drag_dist = sqrt(drag_dx * drag_dx + drag_dy * drag_dy);
		float drag_angle = atan2( drag_dy, drag_dx);
		
		if(drag_dist > flickArea.frame.size.width / 2)
		{
			drag_dist = flickArea.frame.size.width / 2;
			
			drag_dx = cos( -drag_angle ) * drag_dist;//* ( M_PI / 180 ) 
			drag_dy = sin( -drag_angle ) * drag_dist;//* ( M_PI / 180 ) 
			
			ball.center = CGPointMake(flickArea.center.x - drag_dx, flickArea.center.y + drag_dy);
		}
		/*else 
		{
			ball.isInFlickingArea = YES;
		}*/
		
	}

}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}



@end
