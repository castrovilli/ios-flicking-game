//
//  ScoreBoard.m
//  Flicking
//
//  Created by jschwartz on 3/16/11.
//  Copyright 2011 BSSP. All rights reserved.
//

#import "ScoreBoard.h"


@implementation ScoreBoard

@synthesize vx, vy;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        vx = -1;
        vy = 1;
        
        UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg.jpg"]];
        [self addSubview:bg];
        [bg release];
            
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    [super dealloc];
}

@end
