//
//  NSObject+SimpleBindings.m
//  Fluxus
//
//  Created by Marcel Ruegenberg on 21.03.11.
//  Copyright 2011 Dustlab. All rights reserved.
//

#import "NSObject+SimpleBindings.h"
#import <objc/runtime.h>


@interface ObjectBinding : NSObject {
}

@property (assign) NSObject *obj1;
@property (copy) NSString *keyPath1;
@property (assign) NSObject *obj2;
@property (copy) NSString *keyPath2;

- (id)initWithKeyPath:(NSString *)keyPath1 ofObj:(NSObject *)obj1 keyPath:(NSString *)keyPath2 ofObj:(NSObject *)obj2;

- (void)deactivateBinding;

- (BOOL)containsObject:(NSObject *)object;

- (NSObject *)otherObject:(NSObject *)obj;

@end

@implementation ObjectBinding
@synthesize obj1, keyPath1, obj2, keyPath2;

- (id)initWithKeyPath:(NSString *)keyPath1_ ofObj:(NSObject *)obj1_ keyPath:(NSString *)keyPath2_ ofObj:(NSObject *)obj2_ {
    if((self = [super init])) {
        self.obj1 = obj1_; self.keyPath1 = keyPath1_;
        self.obj2 = obj2_; self.keyPath2 = keyPath2_;
        [self.obj1 addObserver:self forKeyPath:self.keyPath1 options:0 context:NULL];
        [self.obj2 addObserver:self forKeyPath:self.keyPath2 options:0 context:NULL];
    }
    return self;
}

- (void)deactivateBinding {
    [self.obj1 removeObserver:self forKeyPath:self.keyPath1];
    [self.obj2 removeObserver:self forKeyPath:self.keyPath2];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    NSObject *otherObject = nil; NSString *otherKeyPath = nil;
    if(object == self.obj1 && [keyPath isEqualToString:self.keyPath1]) { otherObject = self.obj2; otherKeyPath = self.keyPath2; }
    else if(object == self.obj2 && [keyPath isEqualToString:self.keyPath2]) { otherObject = self.obj1; otherKeyPath = self.keyPath1; }
    else return;
    
    id val = [object valueForKeyPath:keyPath];
    
    if([object valueForKeyPath:keyPath] != [otherObject valueForKeyPath:otherKeyPath]) {
        [otherObject setValue:val forKeyPath:otherKeyPath];
    }
}

- (BOOL)containsObject:(NSObject *)object {
    return self.obj1 == object || self.obj2 == object;
}

- (NSObject *)otherObject:(NSObject *)obj {
    if(obj == self.obj1) return obj1;
    else if(obj == self.obj2) return obj2;
    else return nil;
}

- (void)dealloc {
    self.obj1 = nil;
    self.keyPath1 = nil;
    self.obj2 = nil;
    self.keyPath2 = nil;
    [super dealloc];
}

@end


@interface NSObject (SimpleBindingsPrivate)

- (void)bindOtherObject:(ObjectBinding *)binding;

- (void)unbindOtherObject:(ObjectBinding *)binding;

@end


@implementation NSObject (SimpleBindings)

static char bindingsKey;

- (void)bind:(NSString *)binding toKeyPath:(NSString *)keyPath ofObject:(id)object {
    // see "Associative references" in the docs for details
    NSMutableSet *bindings = objc_getAssociatedObject(self, &bindingsKey);
    if(bindings == nil) {
        bindings = [NSMutableSet new];
        objc_setAssociatedObject(self, &bindingsKey, bindings, OBJC_ASSOCIATION_RETAIN);
        [bindings release];
    }
    
    ObjectBinding *b = [[ObjectBinding alloc] initWithKeyPath:binding ofObj:self keyPath:keyPath ofObj:object];
    [bindings addObject:b];
    
    [object bindOtherObject:b];
    [b release];
}

- (void)unbindObject:(NSObject *)object {
    NSMutableSet *bindings = objc_getAssociatedObject(self, &bindingsKey);
    if(! bindings) return;
    
    NSMutableSet *bindingsToRemove = [NSMutableSet set];
    for(ObjectBinding *b in bindings) {
        if([b containsObject:object]) {
            [b deactivateBinding];
            [[b otherObject:self] unbindOtherObject:b];
            [bindingsToRemove addObject:b];
        }
    }
    [bindings minusSet:bindingsToRemove];
    
}

@end


@implementation NSObject (SimpleBindingsPrivate)

- (void)bindOtherObject:(ObjectBinding *)binding {
    NSMutableSet *bindings = objc_getAssociatedObject(self, &bindingsKey);
    if(bindings == nil) {
        bindings = [NSMutableSet new];
        objc_setAssociatedObject(self, &bindingsKey, bindings, OBJC_ASSOCIATION_RETAIN);
        [bindings release];
    }
    
    [bindings addObject:binding];
}

- (void)unbindOtherObject:(NSSet *)bindingsToRemove {
    NSMutableSet *bindings = objc_getAssociatedObject(self, &bindingsKey);
    if(! bindings) return;
    
    [bindings minusSet:bindingsToRemove];
}

@end

