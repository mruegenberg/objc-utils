//
//  UIView+Additions.m
//  CheckLists
//
//  Created by Marcel Ruegenberg on 31.10.10.
//  Copyright 2010 Dustlab. All rights reserved.
//

#import "UIView+Additions.h"


@implementation UIView (Additions)

- (UIView *)findFirstResponder { 
	if(self.isFirstResponder) return self;
	
	for (UIView *subView in self.subviews) {
		UIView *firstResponder = [subView findFirstResponder];
		if (firstResponder != nil) 
			return firstResponder;
	}
	return nil;
}

@end
