//
//  UITabBar+HidableTabBar.h
//  TBHidingTest
//
//  Created by Marcel Ruegenberg on 11.06.11.
//  Copyright 2011 Dustlab. All rights reserved.
//  
//

//  WARNING: The implementation of this category makes certain assumptions about the structure of the subviews of a UITabBarController's view. There is no guarantee for this to keep working from one version of iOS to the next.
@interface UITabBarController (HideableTabBar)

- (void)setTabBarHidden:(BOOL)hidden;

- (void)setTabBarFlat:(BOOL)flat;

@end
