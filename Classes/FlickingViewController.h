//
//  FlickingViewController.h
//  Flicking
//
//  Created by jschwartz on 5/4/10.
//  Copyright BSSP 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Projectile.h"
#import "FlickArea.h"
#import "ScoreBoard.h"
#import "Target.h"

#define kFriction 0.5
#define kGravity 0.02
#define kGroundZ 0.2

@interface FlickingViewController : UIViewController 
{
    ScoreBoard *scoreBoard;
	FlickArea *flickArea;
	Projectile *ball;
    
    NSMutableArray *targets;
}



@end

