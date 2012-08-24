//
//  Array+FPAdditions.m
//  Classes
//
//  Created by Marcel Ruegenberg on 02.08.10.
//  Copyright 2010 Dustlab. All rights reserved.
//

#import "NSArray+FPAdditions.h"
#import "FPTuple.h"


@implementation NSArray (ArrayFP)

- (NSArray *)mapWithBlock:(id (^)(id obj))block {
    NSMutableArray *result = [[NSMutableArray alloc] init];
	for(id val in self) {
        id mappedVal = block(val);
        if(mappedVal)
            [result addObject:mappedVal];
	}
	return result;
}

- (NSArray *)zipWithArray:(NSArray *)otherArray {
	NSUInteger cnt = [self count];
	if(otherArray == nil) cnt = 0;
	else if([otherArray count] < cnt) cnt = [otherArray count];
	
	NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:cnt];
	NSUInteger i;
	for (i = 0; i < cnt; i++) {
		NSObject * obj1 = [self objectAtIndex:i];
		NSObject * obj2 = [otherArray objectAtIndex:i];
		FPTuple *zipped = [FPTuple tupleWithFirst:obj1 second:obj2];
		[result addObject:zipped];
	}
	
	return result;
}

- (id)firstObject {
	if([self count] == 0)
		return nil;
	else
		return [self objectAtIndex:0];
}

- (NSArray *)initialArray {
    NSUInteger c = [self count];
    if(c == 0) return self;
    else return [self subarrayWithRange:NSMakeRange(0, c - 1)];
}

@end

