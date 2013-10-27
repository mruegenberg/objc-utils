//
//  UIView+Additions.h
//  CheckLists
//
//  Created by Marcel Ruegenberg on 31.10.10.
//  Copyright 2010 Dustlab. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (Additions)

// find the current first responder in this view or its subviews
- (UIView *)findFirstResponder;

@end
