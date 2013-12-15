//
//  NSObject+KVCExtensions.m
//  Classes
//
//  Created by Marcel Ruegenberg on 02.08.10.
//  Copyright 2010 Dustlab. All rights reserved.
//

#import "NSObject+KVCExtensions.h"
#import "Util.h"

@implementation NSObject (KVCExtensions)

- (void)setValuesForKeyPathsWithDictionary:(NSDictionary *)keyedValues {
	for(id keyPath in keyedValues) {
        NSArray *components = [keyPath componentsSeparatedByString:@"."];
        NSArray *initialPathAry = [components subarrayWithRange:NSMakeRange(0, MAX(0, [components count] - 1))];
        NSString *initialPath = [initialPathAry componentsJoinedByString:@"."];
        NSString *path = initialPath;
        if(path == nil || [path isEqualToString:@""]) {
            path = keyPath;
        }
		if([keyedValues valueForKeyPath:keyPath] == [NSNull null]) {
            if([self valueForKeyPath:path] != nil)
                [self setValue:nil forKeyPath:keyPath];
            else
                [self setValue:nil forKey:keyPath];
        }
		else {
            if([self valueForKeyPath:path] != nil)
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
