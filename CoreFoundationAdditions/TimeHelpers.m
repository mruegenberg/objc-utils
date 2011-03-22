//
//  TimeHelpers.m
//  Checklists
//
//  Created by Marcel Ruegenberg on 06.02.11.
//  Copyright 2011 Dustlab. All rights reserved.
//

#import <Foundation/Foundation.h>


// time interval in seconds
NSString *timeIntervalToString(NSInteger timeInterval) {
	if(timeInterval == 0) return @"None";

	NSString *prefix = @"";
	NSString *suffix = timeInterval < 0 ? @"before" : @"after";
	if(timeInterval < 0) timeInterval = timeInterval * (-1);
	if(timeInterval > 60 * 60 * 24) prefix = [NSString stringWithFormat:@"%d days", (timeInterval / (60 * 60 * 24))];
	else if(timeInterval > 60 * 60) prefix = [NSString stringWithFormat:@"%d hours", (timeInterval / (60 * 60))];
	else prefix = [NSString stringWithFormat:@"%d minutes", (timeInterval / 60)];
	return [NSString stringWithFormat:@"%@ %@", prefix, suffix];
}
