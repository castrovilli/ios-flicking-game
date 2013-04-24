//
//  Ball.h
//  Flicking
//
//  Created by jschwartz on 5/4/10.
//  Copyright 2010 BSSP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlickArea.h"

#define kMaxFlickDistance 120.0

@interface Projectile : UIView 
{
	// flick variables
	CGPoint lastTouchPoint;
	CGPoint newTouchPoint;
	NSTimeInterval lastTouchTime;
	NSTimeInterval newTouchTime;
	
	// draggin vars
	BOOL wasFlicked;
	BOOL inAir;
	BOOL inFlickingArea;
	BOOL beingDragged;
	FlickArea *flickArea;
	
	
	
	
	// movement variables
	float flick_angle;
	float mass;
	float ax;
	float ay;
	float az;
	float vx;
	float vy;
	float vz;
	float z;
}

@property (nonatomic, assign) FlickArea *flickArea;

@property (nonatomic, assign) float flick_angle;
@property (nonatomic, assign) float mass;
@property (nonatomic, assign) float ax;
@property (nonatomic, assign) float ay;
@property (nonatomic, assign) float az;
@property (nonatomic, assign) float vx;
@property (nonatomic, assign) float vy;
@property (nonatomic, assign) float vz;
@property (nonatomic, assign) float z;


@property (nonatomic, assign, getter = isInAir) BOOL inAir;
@property (nonatomic, assign, getter = isInFlickingArea) BOOL inFlickingArea;
@property (nonatomic, assign, getter = isBeingDragged) BOOL beingDragged;
@property (nonatomic, assign) BOOL wasFlicked;




- (void)reset;

@end
