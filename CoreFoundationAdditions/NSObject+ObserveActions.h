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

- (void)addObserverAction:(ObserveAction)action forKeyPath:(NSString *)keyPath;

// TODO: make this dependent on the observing object!
- (void)removeActionObserverForKeyPath:(NSString *)keyPath;

@end
