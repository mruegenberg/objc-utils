//
//  NSURL+ParameterParsing.m
//  Classes
//
//  Created by Marcel Ruegenberg on 02.08.10.
//  Copyright 2010 Dustlab. All rights reserved.
//

#import "NSURL+ParameterParsing.h"


@implementation NSURL (ParameterParsing)

- (NSDictionary *)getParameters {
	NSArray *pairs = [[self query] componentsSeparatedByString:@"&"];
	NSMutableDictionary *result = [NSMutableDictionary dictionary];
	for(NSString *pair in pairs) {
		NSArray *keyValue = [pair componentsSeparatedByString:@"="];
		if([keyValue count] > 1)
			[result setValue:[keyValue objectAtIndex:1] 
					  forKey:[keyValue objectAtIndex:0]];
		else if([keyValue count] > 0)
			[result setValue:@"" forKey:[keyValue objectAtIndex:0]];
	}
	
	return result;
}

@end
