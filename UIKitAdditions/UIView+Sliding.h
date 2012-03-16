//
//  UIView+Sliding.h
//  Classes
//
//  Created by Marcel Ruegenberg on 13.09.11.
//  Copyright 2011 Dustlab. All rights reserved.
//

@interface UIView (UIView_Sliding)

/**
 Slide in the view, as a direct child of the window.
 @param viewToAdjust A view whose size should be adjusted to make space for the new view.
 */
- (void)slideInToView:(UIView *)parentView andAdjustView:(UIView *)viewToAdjust;

- (void)slideOutOfView:(UIView *)parentView andAdjustView:(UIView *)viewToAdjust;

@end
