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

- (id)initWithObservedObject:(NSObject *)observedObj keyPath:(NSString *)keyPath action:(ObserveAction)action;
- (void)deactivateBinding;

@end

@implementation ObserveActionBinding
@synthesize observedObj, keyPath, action, bindingActive;

- (id)initWithObservedObject:(NSObject *)_observedObj keyPath:(NSString *)_keyPath action:(ObserveAction)_action {
	if((self = [super init])) {
		self.observedObj = _observedObj; self.keyPath = _keyPath; self.action = _action;
		[self.observedObj addObserver:self forKeyPath:self.keyPath options:0 context:NULL];
		bindingActive = YES;
	}
	return self;
}

- (void)observeValueForKeyPath:(NSString *)_keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	NSAssert2([_keyPath isEqualToString:self.keyPath], @"Action binding called with invalid keyPath %@ instead of ", _keyPath, self.keyPath);
	NSAssert(object == self.observedObj, @"Action binding called with invalid object");
	self.action();
}	

- (void)deactivateBinding {
	if(bindingActive) {
		[self.observedObj removeObserver:self forKeyPath:self.keyPath];
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

- (void)addObserverAction:(ObserveAction)action forKeyPath:(NSString *)keyPath {
	// see "Associative references" in the docs for details
    NSMutableDictionary *actions = objc_getAssociatedObject(self, &observeActionKey);
    if(actions == nil) {
        actions = [NSMutableDictionary new];
        objc_setAssociatedObject(self, &observeActionKey, actions, OBJC_ASSOCIATION_RETAIN);
    }
	
	ObserveActionBinding *binding = [[ObserveActionBinding alloc] initWithObservedObject:self keyPath:keyPath action:action];
	ObserveActionBinding *prevBinding = [actions objectForKey:keyPath];
	[prevBinding deactivateBinding]; // technically not necessary
	[actions setObject:binding forKey:keyPath];
}

- (void)removeActionObserverForKeyPath:(NSString *)keyPath {
	NSMutableDictionary *actions = objc_getAssociatedObject(self, &observeActionKey);
    if(actions == nil) {
        actions = [NSMutableDictionary new];
        objc_setAssociatedObject(self, &observeActionKey, actions, OBJC_ASSOCIATION_RETAIN);
    }
	
	ObserveActionBinding *binding = [actions objectForKey:keyPath];
	[binding deactivateBinding]; // technically not necessary
	[actions removeObjectForKey:keyPath];
}

@end
