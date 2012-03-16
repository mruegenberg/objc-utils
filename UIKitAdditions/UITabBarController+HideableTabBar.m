//
//  UITabBar+HidableTabBar.m
//  TBHidingTest
//
//  Created by Marcel Ruegenberg on 11.06.11.
//  Copyright 2011 Dustlab. All rights reserved.
//

#import "UITabBarController+HideableTabBar.h"


@implementation UITabBarController (HideableTabBar)

- (void)setTabBarHidden:(BOOL)hidden {
    UIView *contentView = nil;
    
    NSArray *subviews = self.view.subviews;
    NSAssert([subviews count] >= 2, @"Structural problem in implementation of Tab bar hiding.");
    
    // contentView is the subview that is not the tab bar
    if([[subviews objectAtIndex:0] isKindOfClass:[UITabBar class]])
        contentView = [subviews objectAtIndex:1];
    else
        contentView = [subviews objectAtIndex:0];
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.tabBar.frame;
        
        if (hidden) {
            contentView.frame = self.view.bounds;
            f.origin.y = self.view.bounds.origin.y + self.view.bounds.size.height;
        }
        else {
            contentView.frame = CGRectMake(self.view.bounds.origin.x,
                                           self.view.bounds.origin.y,
                                           self.view.bounds.size.width,
                                           self.view.bounds.size.height - f.size.height);
            f.origin.y = self.view.bounds.origin.y + self.view.bounds.size.height - f.size.height;
        }
        
        self.tabBar.frame = f;
    }];
}

- (void)setTabBarFlat:(BOOL)flat {
    CGFloat h = flat ? 39 : 49;
    UIView *contentView = nil;
    
    NSArray *subviews = self.view.subviews;
    NSAssert([subviews count] >= 2, @"Structural problem in implementation of Tab bar hiding.");
    
    // contentView is the subview that is not the tab bar
    if([[subviews objectAtIndex:0] isKindOfClass:[UITabBar class]])
        contentView = [subviews objectAtIndex:1];
    else
        contentView = [subviews objectAtIndex:0];
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.tabBar.frame;
        f.size.height = h;
        
        contentView.frame = CGRectMake(self.view.bounds.origin.x,
                                       self.view.bounds.origin.y,
                                       self.view.bounds.size.width,
                                       self.view.bounds.size.height - f.size.height);
        f.origin.y = self.view.bounds.origin.y + self.view.bounds.size.height - f.size.height;
        
        self.tabBar.frame = f;
    }];
}

@end
