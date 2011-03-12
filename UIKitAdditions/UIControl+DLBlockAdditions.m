//
//  UIControl+DLBlockAdditions.m
//  Fluxus
//
//  Created by Marcel Ruegenberg on 12.03.11.
//  Copyright 2011 Dustlab. All rights reserved.
//

#import "UIControl+DLBlockAdditions.h"
#import <objc/runtime.h>



@interface DLBlockWrapper : NSObject {
}
@property (nonatomic, copy) DLControlAction block;

- (void)invoke:(id)sender;
@end

@implementation DLBlockWrapper
@synthesize block;

- (void)invoke:(id)sender {
    self.block(sender);
}

- (void)dealloc {
    self.block = nil;
    [super dealloc];
}

@end



@implementation UIControl (UIControl_DLBlockAdditions)

static char actionKey;

- (void)addAction:(DLControlAction)actionBlock forControlEvents:(UIControlEvents)controlEvents {
    // see "Associative references" in the docs for details
    NSMutableArray *actions = objc_getAssociatedObject(self, &actionKey);
    if(actions == nil) {
        actions = [NSMutableArray new];
        objc_setAssociatedObject(self, &actionKey, actions, OBJC_ASSOCIATION_RETAIN);
        [actions release];
    }
    
    if(actions == nil) actions = [NSMutableArray new];
    
    DLBlockWrapper *wrapper = [DLBlockWrapper new];
    wrapper.block = actionBlock;
    [self addTarget:wrapper action:@selector(invoke:) forControlEvents:controlEvents];
    [actions addObject:wrapper];
    [wrapper release];
}

@end
