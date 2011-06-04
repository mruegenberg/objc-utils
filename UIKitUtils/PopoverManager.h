//
//  PopoverManager.h
//  Lists
//
//  Created by Marcel Ruegenberg on 25.02.11.
//  Copyright 2011 Dustlab. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 
 A class for managing the retaining of popovers in a central place.

 Because even though Apple basically tells you to have only one popover at a time, they make it surprisingly hard to do this properly.
 */
@interface PopoverManager : NSObject {
	UIPopoverController *currentPopoverController;
}

@property (nonatomic, retain) UIPopoverController *currentPopoverController;

+ (PopoverManager *)sharedPopoverManager;

@end
