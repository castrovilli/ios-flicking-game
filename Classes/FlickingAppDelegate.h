//
//  FlickingAppDelegate.h
//  Flicking
//
//  Created by jschwartz on 5/4/10.
//  Copyright BSSP 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlickingViewController;

@interface FlickingAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    FlickingViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet FlickingViewController *viewController;

@end

