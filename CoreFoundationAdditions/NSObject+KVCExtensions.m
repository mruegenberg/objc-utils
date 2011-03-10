//
//  NSObject+KVCExtensions.m
//  Classes
//
//  Created by Marcel Ruegenberg on 02.08.10.
//  Copyright 2010 Dustlab. All rights reserved.
//

#import "NSObject+KVCExtensions.h"


@implementation NSObject (KVCExtensions)

- (void)setValuesForKeyPathsWithDictionary:(NSDictionary *)keyedValues {
	for(id keyPath in keyedValues) {
		if([keyedValues valueForKeyPath:keyPath] == [NSNull null])
			[self setValue:nil forKeyPath:keyPath];
		else
			[self setValue:[keyedValues objectForKey:keyPath] forKeyPath:keyPath];
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
	
	return [dict autorelease];
}

@end