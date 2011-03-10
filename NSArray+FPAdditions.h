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
 Perform a selector on each element of an array, and return an array of the results.
 The method does not check if the result actually works, so it is up to you to supply a selector
 that returns elements that can be packed in an array for each element in self.
 
 This method is simular to the makeObjectsPerformSelector: but aggregates the return values.
 @param aSelector the selector to perform
 @return a new array with the results of performing the selector on each array element
 */
- (NSArray *)fp_mapWithSelector:(SEL)aSelector;

/**
 "Zips" two arrays (for more understanding, look up the word zipper in the dictionary). 
 Each element of self is paired (as an OSTuple) with the corresponding element of otherArray. The length of the result is the length of the shorter of the two arrays.
 [[a,b,c] zipWithArray:[1,2,3,4]] results in [(a,1),(b,2),(c,3)].
 @param otherArray Some other array with which to zip. If this is nil, it is treated as an empty array.
 @return The result of zipping the two arrays as an array of OSTuples.
 */
- (NSArray *)fp_zipWithArray:(NSArray *)otherArray;

/**
 The array's first object. Similar to -[lastObject].
 Returns nil if the array is empty.
 */
- (id)fp_firstObject;

@end