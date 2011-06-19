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

@property BOOL bindingActive;

@end

@implementation ObjectBinding
@synthesize obj1, keyPath1, obj2, keyPath2, bindingActive;

- (id)initWithKeyPath:(NSString *)keyPath1_ ofObj:(NSObject *)obj1_ keyPath:(NSString *)keyPath2_ ofObj:(NSObject *)obj2_ {
    if((self = [super init])) {
        self.obj1 = obj1_; self.keyPath1 = keyPath1_;
        self.obj2 = obj2_; self.keyPath2 = keyPath2_;
		[self.obj1 setValue:[self.obj2 valueForKeyPath:self.keyPath2] forKeyPath:self.keyPath1];
        [self.obj1 addObserver:self forKeyPath:self.keyPath1 options:0 context:NULL];
        [self.obj2 addObserver:self forKeyPath:self.keyPath2 options:0 context:NULL];
		self.bindingActive = YES;
    }
    return self;
}

- (void)deactivateBinding {
    [self.obj1 removeObserver:self forKeyPath:self.keyPath1];
    [self.obj2 removeObserver:self forKeyPath:self.keyPath2];
	self.bindingActive = NO;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    NSObject *otherObject = nil; NSString *otherKeyPath = nil;
    if(object == self.obj1 && [keyPath isEqualToString:self.keyPath1]) { otherObject = self.obj2; otherKeyPath = self.keyPath2; }
    else if(object == self.obj2 && [keyPath isEqualToString:self.keyPath2]) { otherObject = self.obj1; otherKeyPath = self.keyPath1; }
    else return;
    
    id val = [object valueForKeyPath:keyPath];

	if((! [[object valueForKeyPath:keyPath] isEqual:[otherObject valueForKeyPath:otherKeyPath]]) && ! (val == nil && [otherObject valueForKeyPath:otherKeyPath] == nil)) {
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
	if(self.bindingActive) [self deactivateBinding];
    self.obj1 = nil;
    self.keyPath1 = nil;
    self.obj2 = nil;
    self.keyPath2 = nil;
    [super dealloc];
}

@end

@interface TransformedObjectBinding : ObjectBinding {
}

@property (copy) SimpleBindingTransformer transformer;

- (id)initWithKeyPath:(NSString *)keyPath1 ofObj:(NSObject *)obj1 keyPath:(NSString *)keyPath2 ofObj:(NSObject *)obj2 withTransformer:(SimpleBindingTransformer)transformer;

@end

@implementation TransformedObjectBinding
@synthesize transformer;

- (id)initWithKeyPath:(NSString *)keyPath1_ ofObj:(NSObject *)obj1_ keyPath:(NSString *)keyPath2_ ofObj:(NSObject *)obj2_ withTransformer:(SimpleBindingTransformer)transformer_ {
    if((self = [super init])) {
        self.obj1 = obj1_; self.keyPath1 = keyPath1_;
        self.obj2 = obj2_; self.keyPath2 = keyPath2_;
        self.transformer = transformer_;
		[self.obj1 setValue:(self.transformer([self.obj2 valueForKeyPath:self.keyPath2])) forKeyPath:self.keyPath1];
        [self.obj2 addObserver:self forKeyPath:self.keyPath2 options:0 context:NULL];
    }
    return self;
}

- (void)deactivateBinding {
    [self.obj2 removeObserver:self forKeyPath:self.keyPath2];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    NSAssert(object == self.obj2 && [keyPath isEqualToString:self.keyPath2], @"Error in simple bindings mechanism.");
    
    id val = [object valueForKeyPath:keyPath];
    if(self.transformer)
        val = self.transformer(val);
    
    if(! [[self.obj1 valueForKeyPath:self.keyPath1] isEqual:val]) {
        [self.obj1 setValue:val forKeyPath:self.keyPath1];
    }
}

- (void)dealloc {
    self.transformer = nil;
    [super dealloc];
}

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
	
    [b release];
}

- (void)unbindObject:(NSObject *)object {
    NSMutableSet *bindings = objc_getAssociatedObject(self, &bindingsKey);
    if(! bindings) return;
    
    NSMutableSet *bindingsToRemove = [NSMutableSet set];
    for(ObjectBinding *b in bindings) {
        if([b containsObject:object]) {
            [b deactivateBinding];
            [bindingsToRemove addObject:b];
        }
    }
    [bindings minusSet:bindingsToRemove];
}

static char transformedBindingsKey;

- (void)bind:(NSString *)binding toKeyPath:(NSString *)keyPath ofObject:(id)object withTransformer:(SimpleBindingTransformer)transformer {
    // see "Associative references" in the docs for details
    NSMutableSet *bindings = objc_getAssociatedObject(self, &transformedBindingsKey);
    if(bindings == nil) {
        bindings = [NSMutableSet new];
        objc_setAssociatedObject(self, &transformedBindingsKey, bindings, OBJC_ASSOCIATION_RETAIN);
        [bindings release];
    }
    
    TransformedObjectBinding *b = [[TransformedObjectBinding alloc] initWithKeyPath:binding ofObj:self keyPath:keyPath ofObj:object withTransformer:transformer];
    [bindings addObject:b];
    
    [b release];
}

- (void)unbindObjectTransformed:(NSObject *)object {
    NSMutableSet *bindings = objc_getAssociatedObject(self, &transformedBindingsKey);
    if(! bindings) return;
    
    NSMutableSet *bindingsToRemove = [NSMutableSet set];
    for(TransformedObjectBinding *b in bindings) {
        if([b containsObject:object]) {
            [b deactivateBinding];
            [bindingsToRemove addObject:b];
        }
    }
    [bindings minusSet:bindingsToRemove];
}

@end
