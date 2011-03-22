//
//  NSObject+SimpleBindings.h
//  Fluxus
//
//  Created by Marcel Ruegenberg on 21.03.11.
//  Copyright 2011 Dustlab. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 A simple bindings-like mechanism. Inspired by Cocoa bindings.
 No value transformers are supported. 
 
 For more complex needs, use Signals.
 */
@interface NSObject (SimpleBindings)

/**
 Ensure that the own value for a key is always equal to the value for a keyPath of another object.
 */
- (void)bind:(NSString *)binding toKeyPath:(NSString *)keyPath ofObject:(id)object;

/**
 Removes the binding from all key paths of object to this object.
 */
- (void)unbindObject:(NSObject *)object;


@end
