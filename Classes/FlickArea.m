//
//  FlickArea.m
//  Flicking
//
//  Created by jschwartz on 5/4/10.
//  Copyright 2010 BSSP. All rights reserved.
//

#import "FlickArea.h"


@implementation FlickArea


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
		
		UIImage *bgImg = [UIImage imageNamed:@"ring.png"];
		UIImageView *bg = [[UIImageView alloc] initWithImage:bgImg];
		[self addSubview:bg];
		[bg release];
    }
    return self;
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
