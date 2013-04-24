//
//  ScoreBoard.h
//  Flicking
//
//  Created by jschwartz on 3/16/11.
//  Copyright 2011 BSSP. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ScoreBoard : UIView {
    float vx;
    float vy;
}

@property (nonatomic, assign) float vx;
@property (nonatomic, assign) float vy;

@end
