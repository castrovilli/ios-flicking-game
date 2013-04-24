//
//  Ball.m
//  Flicking
//
//  Created by jschwartz on 5/4/10.
//  Copyright 2010 BSSP. All rights reserved.
//

#import "Projectile.h"


@implementation Projectile

@synthesize flickArea;
@synthesize inAir, inFlickingArea, beingDragged, wasFlicked;
@synthesize flick_angle, mass, vx, vy, vz, ax, ay, az, z;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) 
	{
		[self reset];
		
		// create ball image
		UIImage *i = [UIImage imageNamed:@"ball.png"];
		UIImageView *iv = [[UIImageView alloc] initWithImage:i];
		iv.frame = CGRectMake(0,0,i.size.width,i.size.height);
		[self addSubview:iv];
		[iv release];
		
		// set frame
		self.frame = CGRectMake(0,0,i.size.width,i.size.height);
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *t = [touches anyObject];
	CGPoint tl = [t locationInView:self];
	
	// reset values
	vx = 0;
	vy = 0;
	vz = 0;
	self.z = 1;
	
	// set is being dragged
	self.beingDragged = YES;
	
	// set time and point vars
	newTouchTime = event.timestamp;
	newTouchPoint = tl;
	lastTouchTime = event.timestamp;
	lastTouchPoint = tl;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	// get touch object and find point of touch in view
	UITouch *t = [touches anyObject];
	CGPoint tl = [t locationInView:[self superview]];
	
	// constrain drag to flick area
	float drag_dx = flickArea.center.x - tl.x;
	float drag_dy = flickArea.center.y - tl.y;
	float drag_dist = sqrt(drag_dx * drag_dx + drag_dy * drag_dy);
	float drag_angle = atan2( drag_dy, drag_dx);
	
	if(drag_dist > flickArea.frame.size.width / 2)
	{
		drag_dist = flickArea.frame.size.width / 2;
		
		drag_dx = cos( -drag_angle ) * drag_dist; 
		drag_dy = sin( -drag_angle ) * drag_dist;
		self.center = CGPointMake(flickArea.center.x - drag_dx, flickArea.center.y + drag_dy);
	}
	else 
	{
		self.center = CGPointMake(tl.x, tl.y);
	}

	
	// set new & old touchTime vars
	lastTouchTime = newTouchTime;
	newTouchTime = event.timestamp;
	
	// set new & old touchPoint vars
	lastTouchPoint = newTouchPoint;
	newTouchPoint = self.center;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *t = [touches anyObject];
	CGPoint tl = [t locationInView:[self superview]];
	
	
	newTouchTime = event.timestamp;
	newTouchPoint = tl;
	
	/* formulas
     
	 force = mass x acceleration
	 acceleration = force / mass
	 acceleration = (final velocity - initial velocity) / (final time - initial time)
	 */
	float time_diff = newTouchTime - lastTouchTime;
	
	float flick_dx = newTouchPoint.x - lastTouchPoint.x;
	float flick_dy = newTouchPoint.y - lastTouchPoint.y;
	float flick_dist = sqrt(flick_dx * flick_dx + flick_dy * flick_dy);
	if(flick_dist > kMaxFlickDistance)
		flick_dist = kMaxFlickDistance;
	
	float flick_force = (flick_dist / (time_diff * 20)) / mass;
	flick_angle = atan2(flick_dy, flick_dx);
	
	ax = cos(flick_angle) * flick_force;
	ay = sin(flick_angle) * flick_force;
	self.vx += ax;
	self.vy += ay;
	
	self.beingDragged = NO;
	self.inAir = YES;
	self.wasFlicked = YES;
	
    
    
}

//==================================================================
// SETTERS AND GETTERS
//==================================================================

- (void)setZ:(float)newZ {
	z = newZ;
	self.transform = CGAffineTransformMakeScale(z, z);
}




- (void)reset
{
	self.wasFlicked = NO;
	self.inAir = NO;
	self.beingDragged = NO;
	self.vx = 0;
	self.vy = 0;
	self.vz = 0;
	self.z = 1;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc {
    [super dealloc];
}


@end
