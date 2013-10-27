//
//  UITabBarController+HideableTabBar.h
//  TBHidingTest
//
//  Created by Marcel Ruegenberg on 11.06.11.
//  Copyright 2011 Dustlab. All rights reserved.
//  
//

#import <UIKit/UIKit.h>

/* WARNING: The implementation of this category makes certain assumptions about the structure of the subviews of a UITabBarController's view. There is no guarantee for this to keep working from one version of iOS to the next.
 In general, it is likely to be stable within at least major version of iOS.
 Tested on iOS 5.*, 6.* and 7.0
 */
@interface UITabBarController (HideableTabBar)

- (void)setTabBarHidden:(BOOL)hidden;

- (void)setTabBarFlat:(BOOL)flat;

@end
