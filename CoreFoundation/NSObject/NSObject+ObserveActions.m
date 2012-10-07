//
//  NSObject+ObserveActions.m
//  Classes
//
//  Created by Marcel Ruegenberg on 18.06.11.
//  Copyright 2011 Dustlab. All rights reserved.
//

#import "NSObject+ObserveActions.h"
#import <objc/runtime.h>


@interface ObserveActionBinding : NSObject

// note: never set these directly, only set them with the custom init method
@property (assign) NSObject *observedObj;
@property (copy) NSString *keyPath;
@property (copy) ObserveAction action;
@property BOOL bindingActive;
@property (retain) id context;

- (id)initWithObservedObject:(NSObject *)observedObj keyPath:(NSString *)keyPath action:(ObserveAction)action context:(id)context;
- (void)deactivateBinding;

@end

@implementation ObserveActionBinding
@synthesize observedObj, keyPath, action, bindingActive, context;

- (id)initWithObservedObject:(NSObject *)_observedObj keyPath:(NSString *)_keyPath action:(ObserveAction)_action context:(id)_context {
	if((self = [super init])) {
		self.observedObj = _observedObj; self.keyPath = _keyPath; self.action = _action; self.context = _context;
		[self.observedObj addObserver:self forKeyPath:self.keyPath options:0 context:(__bridge void *)(_context)]; // passing the context is not really necessary
		bindingActive = YES;
	}
	return self;
}

- (void)observeValueForKeyPath:(NSString *)_keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)_context {
	NSAssert2([_keyPath isEqualToString:self.keyPath], @"Action binding called with invalid keyPath %@ instead of ", _keyPath, self.keyPath);
	NSAssert(object == self.observedObj, @"Action binding called with invalid object");
    NSAssert(_context == (__bridge void *)(self.context), @"Action binding called with wrong context");
	self.action();
}	

- (void)deactivateBinding {
	if(bindingActive) {
        [self.observedObj removeObserver:self forKeyPath:self.keyPath context:(__bridge void *)(self.context)];
		bindingActive = NO;
	}
}

- (void) dealloc
{
	[self deactivateBinding];
}


@end



@implementation NSObject (ObserveActions)

static char observeActionKey;

- (void)addObserverAction:(ObserveAction)action forKeyPath:(NSString *)keyPath context:(id)context {
	// see "Associative references" in the docs for details
    NSMutableArray *actions = objc_getAssociatedObject(self, &observeActionKey);
    if(actions == nil) {
        actions = [NSMutableArray new];
        objc_setAssociatedObject(self, &observeActionKey, actions, OBJC_ASSOCIATION_RETAIN);
    }
	
	ObserveActionBinding *binding = [[ObserveActionBinding alloc] initWithObservedObject:self keyPath:keyPath action:action context:context];
    
    NSUInteger c = [actions count];
    for(int i = 0; i < c; ++i) {
        ObserveActionBinding *b = [actions objectAtIndex:i];
        if([b.keyPath isEqualToString:keyPath] && b.context == context) {
            [b deactivateBinding];
            [actions removeObjectAtIndex:i];
            break;
        }
    }
    
    [actions addObject:binding];
}

- (void)addObserverAction:(ObserveAction)action forKeyPath:(NSString *)keyPath {
    [self addObserverAction:action forKeyPath:keyPath context:nil];
}

- (void)removeActionObserverForKeyPath:(NSString *)keyPath context:(id)context {
	NSMutableArray *actions = objc_getAssociatedObject(self, &observeActionKey);
    if(actions == nil) {
        actions = [NSMutableArray new];
        objc_setAssociatedObject(self, &observeActionKey, actions, OBJC_ASSOCIATION_RETAIN);
    }
	
    NSUInteger c = [actions count];
    for(int i = 0; i < c; ++i) {
        ObserveActionBinding *b = [actions objectAtIndex:i];
        if([b.keyPath isEqualToString:keyPath] && b.context == context) {
            [b deactivateBinding];
            [actions removeObjectAtIndex:i];
            break;
        }
    }
}

- (void)removeActionObserverForKeyPath:(NSString *)keyPath {
    [self removeActionObserverForKeyPath:keyPath context:nil];
}

@end
