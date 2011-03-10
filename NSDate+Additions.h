//
//  NSDate+Additions.h
//  Classes
//
//  Created by Marcel Ruegenberg on 02.08.10.
//  Copyright 2010 Dustlab. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 Helpers for displaying dates.
 */
@interface NSDate (DatePrinters)

/**
 Return a string representing the time component of the string.
 */
- (NSString *)shortTimeString;

/**
 Return a string representing the date component of the string in 
 (locale-dependent) short date form.
 */
- (NSString *)dateString;


/**
 Return a string representing the date and time component of the string in 
 (locale-dependent) short date and short time form.
 */
- (NSString *)dateTimeString;

@end


@interface NSDate (DateHelpers)
- (NSDate *)nextHour;
- (NSDate *)dateByAddingDays:(NSInteger)days;
- (NSDate *)dateByAddingMinutes:(NSInteger)minutes;
- (NSDate *)prevDay;
- (NSDate *)nextDay;
- (NSDate *)prevWeek;
- (NSDate *)nextWeek;
/**
 Returns a date that represents the current time.
 */
//+ (NSDate *)nowTime;
/**
 Returns a date that represents just the time of self.
 */
- (NSDate *)justTime;
/**
 Returns a date that represents just the time of self with minutes and seconds set to zero.
 */
- (NSDate *)justHour;

/**
 Returns a date that represents just the time of right now.
 */
+ (NSDate *)nowTime;

/**
 Returns a version of the date whose minutes component is rounded to the amount of minutes in the first argument.
 @param minutes The minutes to which to round. If zero, the minute part is discarded.
 */
- (NSDate *)dateRoundedToMinutes:(NSUInteger)minutes;
@end
