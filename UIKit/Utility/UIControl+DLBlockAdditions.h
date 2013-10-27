//
//  UIControl+DLBlockAdditions.h
//  Fluxus
//
//  Created by Marcel Ruegenberg on 12.03.11.
//  Copyright 2011 Dustlab. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DLControlAction)(id sender);

@interface UIControl (UIControl_DLBlockAdditions)

/**
 Add an action to this UIControl. Quite similar to -[addTarget:action:forControlEvents:].
 */
- (void)addAction:(DLControlAction)actionBlock forControlEvents:(UIControlEvents)controlEvents;

// call this before deallocating the control
// TODO: this is most likely not needed when using ARC.
//       if so, remove this
- (void)cleanup;

@end
