//
//  Target.m
//  Flicking
//
//  Created by jschwartz on 3/18/11.
//  Copyright 2011 BSSP. All rights reserved.
//

#import "Target.h"


@implementation Target

@synthesize hit;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        bg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        bg.image = [UIImage imageNamed:@"target.png"];
        [self addSubview:bg];
        [bg release];
        
        hit = NO;
        
        // Initialization code
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void) setHit:(BOOL)value {
    hit = value;
    if(hit) {
        bg.image = [UIImage imageNamed:@"target_hit.png"];
    }
}

@end
