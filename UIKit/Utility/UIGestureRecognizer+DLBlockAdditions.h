//
//  UIGestureRecognizer+DLBlockAdditions.h
//  Classes
//
//  Created by Marcel Ruegenberg on 15.10.12.
//  Copyright (c) 2012 Dustlab. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GestureRecognizerAction)(UIGestureRecognizer *sender);

@interface UIGestureRecognizer (DLBlockAdditions)

/**
 Add an action to this gesture recognizer. Quite similar to -[addTarget:action:forControlEvents:].
 */
- (void)addActionStart:(GestureRecognizerAction)startActionBlock running:(GestureRecognizerAction)actionBlock end:(GestureRecognizerAction)endActionBlock;

@end
