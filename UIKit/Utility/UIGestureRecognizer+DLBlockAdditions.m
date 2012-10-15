//
//  UIGestureRecognizer+DLBlockAdditions.m
//  Classes
//
//  Created by Marcel Ruegenberg on 15.10.12.
//  Copyright (c) 2012 Dustlab. All rights reserved.
//

#import "UIGestureRecognizer+DLBlockAdditions.h"
#import <objc/runtime.h>

@interface DLGestureBlockWrapper : NSObject
@property (nonatomic, copy) GestureRecognizerAction startBlock;
@property (nonatomic, copy) GestureRecognizerAction block;
@property (nonatomic, copy) GestureRecognizerAction endBlock;
- (void)invoke:(id)sender;
@end

@implementation DLGestureBlockWrapper
@synthesize block;

- (void)invoke:(UIGestureRecognizer *)sender {
    if(sender.state == UIGestureRecognizerStateBegan) {
        if(self.startBlock) self.startBlock(sender);
    }
    else if(sender.state == UIGestureRecognizerStateEnded ||
            sender.state == UIGestureRecognizerStateCancelled ||
            sender.state == UIGestureRecognizerStateFailed) {
        if(self.endBlock) self.endBlock(sender);
    }
    else {
        if(self.block) self.block(sender);
    }
}

@end

@implementation UIGestureRecognizer (DLBlockAdditions)

static char gestureActionKey;

- (void)addActionStart:(GestureRecognizerAction)startActionBlock
               running:(GestureRecognizerAction)actionBlock
                   end:(GestureRecognizerAction)endActionBlock {
    // see "Associative references" in the docs for details
    NSMutableArray *actions = objc_getAssociatedObject(self, &gestureActionKey);
    if(actions == nil) {
        actions = [NSMutableArray new];
        objc_setAssociatedObject(self, &gestureActionKey, actions, OBJC_ASSOCIATION_RETAIN);
    }
    
    if(actions == nil) actions = [NSMutableArray new];
    
    DLGestureBlockWrapper *wrapper = [DLGestureBlockWrapper new];
    wrapper.startBlock = startActionBlock;
    wrapper.block = actionBlock;
    wrapper.endBlock = endActionBlock;
    [self addTarget:wrapper action:@selector(invoke:)];
    [actions addObject:wrapper];
}

// not needed; works automatically, at least with ARC
//- (void)cleanup {
//    NSMutableArray *actions = objc_getAssociatedObject(self, &gestureActionKey);
//    if(actions == nil) return;
//    for(DLGestureBlockWrapper *actionWrapper in actions) {
//        actionWrapper.block = nil;
//        actionWrapper.endBlock = nil;
//    }
//    [actions removeAllObjects];
//    objc_setAssociatedObject(self, &gestureActionKey, nil, OBJC_ASSOCIATION_RETAIN);
//}

@end
