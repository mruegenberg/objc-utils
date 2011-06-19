//
//  NSObject+SimpleBindings.h
//  Fluxus
//
//  Created by Marcel Ruegenberg on 21.03.11.
//  Copyright 2011 Dustlab. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id(^SimpleBindingTransformer)(id value);

/**
 A simple bindings-like mechanism. Inspired by Cocoa bindings.
 No value transformers are supported. 
 
 For more complex needs, use Signals.
 */
@interface NSObject (SimpleBindings)

/**
 Ensure that the own value for a key is always equal to the value for a keyPath of another object.
 Works both ways, i.e the keypath of the other object is also updated if it changes in self.
 
 The value for the binding of self is initially set to the value of the keyPath of object.
 
 Before deallocating object, you must call unbindObject on self explicitly. 
 If self is deallocated first, unbinding happens automatically. As a rule of thumb, always call bind:... on the more shortlived of two objects.
 */
- (void)bind:(NSString *)binding toKeyPath:(NSString *)keyPath ofObject:(id)object;

/**
 Removes the binding from all key paths of object to this object.
 You must call this method on the same object that you called -[bind:toKeyPath:ofObject:] on.
 Even though the bindings work both ways for most purposes, the do not for memory management.
 */
- (void)unbindObject:(NSObject *)object;

/**
 Ensure that the own value for a key is always equal to the transformed value for a keyPath of another object.
 Works only one way, i.e the key path is not set for the other object if the bound value in this object changes.
 @param transformer A block that takes the value for keyPath of object and returns the value that the keypath represented by binding of self should be set to.
 */
- (void)bind:(NSString *)binding toKeyPath:(NSString *)keyPath ofObject:(id)object withTransformer:(SimpleBindingTransformer)transfomer;

- (void)unbindObjectTransformed:(NSObject *)object;


@end
