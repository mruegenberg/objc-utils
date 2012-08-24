//
//  Array+FPAdditions.h
//  Classes
//
//  Created by Marcel Ruegenberg on 02.08.10.
//  Copyright 2010 Dustlab. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 Helpers for more idiomatic programming with arrays.
 Inspired by functional programming languages.
 
 The methods are prefixed with fp_ to prevent possible future name clashes.
 */
@interface NSArray (ArrayFP)

/**
 Perform a block on each element of an array, and return an array of the results.
 If the block returns nil for an object, that object is not added to the block. This may change in the future to NSNull objects being added, you should not rely on this behavior.
 
 This method is somewhat similar to the makeObjectsPerformSelector: but uses a block and aggregates the return values.
 @param aSelector the selector to perform
 @return a new array with the results of performing the selector on each array element
 */
- (NSArray *)mapWithBlock:(id (^)(id obj))block;

/**
 "Zips" two arrays (for more understanding, look up the word zipper in the dictionary). 
 Each element of self is paired (as an OSTuple) with the corresponding element of otherArray. The length of the result is the length of the shorter of the two arrays.
 [[a,b,c] zipWithArray:[1,2,3,4]] results in [(a,1),(b,2),(c,3)].
 @param otherArray Some other array with which to zip. If this is nil, it is treated as an empty array.
 @return The result of zipping the two arrays as an array of OSTuples.
 */
- (NSArray *)zipWithArray:(NSArray *)otherArray;

/**
 The array's first object. Similar to -[lastObject].
 Returns nil if the array is empty.
 */
- (id)firstObject;

// array with all objects but the last; if the original array was empty, returns the original array
- (NSArray *)initialArray;

@end
