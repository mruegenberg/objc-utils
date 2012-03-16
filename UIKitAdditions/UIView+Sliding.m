//
//  UIView+Sliding.m
//  Classes
//
//  Created by Marcel Ruegenberg on 13.09.11.
//  Copyright 2011 Dustlab. All rights reserved.
//

#import "UIView+Sliding.h"

@implementation UIView (UIView_Sliding)

- (void)slideInToView:(UIView *)parentView andAdjustView:(UIView *)viewToAdjust {
	[parentView addSubview:self];
	
	// size up the view to our screen and compute the start/end frame origin for our slide up animation
    
    CGRect originalAdjustViewFrame = viewToAdjust.frame; 
	
	// compute the start frame
	CGRect screenRect = parentView.bounds;
	CGSize viewSize = [self sizeThatFits:CGSizeZero];
	CGRect startRect = CGRectMake(0.0,
								  screenRect.origin.y + screenRect.size.height,
								  MAX(viewSize.width, parentView.bounds.size.width), 
                                  viewSize.height);
	self.frame = startRect;
	
	// compute the end frame
	CGRect viewRect = CGRectMake(0.0,
                                 screenRect.origin.y + screenRect.size.height - viewSize.height,
                                 MAX(viewSize.width, parentView.bounds.size.width),
                                 viewSize.height);
    if(viewToAdjust == parentView) viewToAdjust = nil; // since we add self to the parentView, it makes no sense to adjust its frame
	// start the slide up animation
    [UIView animateWithDuration:0.3 animations:^(void) {
        self.frame = viewRect;
        
        // shrink the table vertical size to make room for the view
        if(viewToAdjust != nil) {
            CGRect newFrame = originalAdjustViewFrame;
            newFrame.size.height -= self.frame.size.height;
            viewToAdjust.frame = newFrame;
        }
    }];
}

- (void)slideOutOfView:(UIView *)parentView andAdjustView:(UIView *)viewToAdjust {
    if(parentView == viewToAdjust) return;
    
	CGRect screenRect = (parentView != nil) ? parentView.bounds : [[UIScreen mainScreen] applicationFrame];
	CGRect endFrame = self.frame;
	endFrame.origin.y = screenRect.origin.y + screenRect.size.height;
	
	// start the slide down animation
    [UIView animateWithDuration:0.3 animations:^(void) {
        self.frame = endFrame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
     
     // TODO: put this in the animation block?
     // grow the table back again in vertical size to make room for the view
     CGRect newFrame = viewToAdjust.frame;
     newFrame.size.height += self.frame.size.height;
     if(viewToAdjust != nil) viewToAdjust.frame = newFrame;
}

@end
