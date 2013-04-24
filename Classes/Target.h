//
//  Target.h
//  Flicking
//
//  Created by jschwartz on 3/18/11.
//  Copyright 2011 BSSP. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Target : UIView {
    UIImageView *bg;
    BOOL hit;
}

@property (nonatomic, assign, getter = isHit) BOOL hit;

@end
