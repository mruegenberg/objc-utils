//
//  NSObject+KVCExtensions.m
//  Classes
//
//  Created by Marcel Ruegenberg on 02.08.10.
//  Copyright 2010 Dustlab. All rights reserved.
//

#import "NSObject+KVCExtensions.h"
#import "NSArray+FPAdditions.h"
#import "Util.h"

@implementation NSObject (KVCExtensions)

- (void)setValuesForKeyPathsWithDictionary:(NSDictionary *)keyedValues {
	for(id keyPath in keyedValues) {
		if([keyedValues valueForKeyPath:keyPath] == [NSNull null]) {
            if([self valueForKeyPath:fromEmptyStr([[[keyPath componentsSeparatedByString:@"."] initialArray] componentsJoinedByString:@"."], keyPath)] != nil)
                [self setValue:nil forKeyPath:keyPath];
            else
                [self setValue:nil forKey:keyPath];
        }
		else {
            if([self valueForKeyPath:fromEmptyStr([[[keyPath componentsSeparatedByString:@"."] initialArray] componentsJoinedByString:@"."], keyPath)] != nil)
                [self setValue:[keyedValues objectForKey:keyPath] forKeyPath:keyPath];
            else
                [self setValue:[keyedValues objectForKey:keyPath] forKey:keyPath];
        }
	}
}

- (NSDictionary *)dictionaryWithValuesForKeyPaths:(NSArray *)keyPaths {
	NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
	
	for(NSString *k in keyPaths) {
		if([self valueForKeyPath:k] == nil)
			[dict setValue:[NSNull null] forKey:k];
		else
			[dict setValue:[self valueForKeyPath:k] forKey:k];
	}
	
	return dict;
}

@end
