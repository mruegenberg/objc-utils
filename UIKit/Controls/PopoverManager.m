//
//  PopoverManager.m
//  Lists
//
//  Created by Marcel Ruegenberg on 25.02.11.
//  Copyright 2011 Dustlab. All rights reserved.
//

#import "PopoverManager.h"

@interface PopoverManager ()
- (void)didReceiveMemoryWarning:(NSNotification *)notification;
@end

@implementation PopoverManager
@synthesize currentPopoverController;

+ (PopoverManager *)sharedPopoverManager {
    static PopoverManager *sharedPopoverManager;
    if(sharedPopoverManager == nil) sharedPopoverManager = [PopoverManager new];
    return sharedPopoverManager;
}

- (id)init {
	if((self = [super init])) {
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveMemoryWarning:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
	}
	return self;
}

- (void)setCurrentPopoverController:(UIPopoverController *)thePopoverController {
	if(thePopoverController != currentPopoverController) {
		if(currentPopoverController && currentPopoverController.popoverVisible) {
#ifndef NDEBUG
            if(thePopoverController != nil)
                NSLog(@"Warning: New popover being set in PopoverManager while existing popover is still visible.");
#endif
			[currentPopoverController dismissPopoverAnimated:NO]; // no animation when dismissing because this should not happen
		}
		currentPopoverController = thePopoverController;
	}
}

- (void)didReceiveMemoryWarning:(NSNotification *)notification {
	if(self.currentPopoverController && ! self.currentPopoverController.popoverVisible) {
		self.currentPopoverController = nil;
	}
}

- (void) dealloc
{
	self.currentPopoverController = nil;
}

	
@end
