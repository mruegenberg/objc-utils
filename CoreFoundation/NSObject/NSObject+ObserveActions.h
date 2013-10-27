//
//  NSObject+ObserveActions.h
//  Classes
//
//  Created by Marcel Ruegenberg on 18.06.11.
//  Copyright 2011 Dustlab. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^ObserveAction)(void);

/**
 Allows for a specific action (in the form of a block) to be executed when a specific value of an object changes.
 */

@interface NSObject (ObserveActions)

// add an observer action for a keypath. if an observer with the same context already exists, that observer is overwritten.
// usually pass the object from which you call the method as a reference both when adding and removing the observer.
- (void)addObserverAction:(ObserveAction)action forKeyPath:(NSString *)keyPath context:(id)context;

// for backwards compatibility. uses `nil` as the context.
- (void)addObserverAction:(ObserveAction)action forKeyPath:(NSString *)keyPath;
// DEPRECATED_MSG_ATTRIBUTE("Supersed by -[addObserverAction:forKeyPath:context:]. Will be removed in a future release.");

// remove the action observer for the corresponding keypath with a specific context (which may be nil)
- (void)removeActionObserverForKeyPath:(NSString *)keyPath context:(id)context;

// for backwards compatibility. uses `nil` as the context.
- (void)removeActionObserverForKeyPath:(NSString *)keyPath;
// DEPRECATED_MSG_ATTRIBUTE("Supersed by -[removeActionObserverForKeyPath:context:]. Will be removed in a future release.");

@end
