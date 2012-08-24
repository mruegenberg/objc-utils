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
 Return a string representing the time component of the date.
 */
- (NSString *)shortTimeString;

/**
 Return a string representing the date component of the date in 
 (locale-dependent) short date form.
 */
- (NSString *)dateString;

/**
 Return a string representing the full weekday component of the date in the current locale
 */
- (NSString *)weekdayString;

/**
 Return a string representing the full weekday component of the date in the current locale
 */
- (NSString *)shortWeekdayString;


/**
 Return a string representing the date and time component of the string in 
 (locale-dependent) short date and short time form.
 */
- (NSString *)dateTimeString;


/**
 Return a string representing the date and time component of the string in 
 (locale-dependent) short date and short time form, with the weekday.
 */
- (NSString *)longDateTimeString;

@end


@interface NSDate (DateHelpers)
- (NSDate *)nextHour;
- (NSDate *)prevHour;
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

- (NSDate *)beginOfDay;

- (NSDate *)endOfDay;

- (NSDate *)middleOfDay;

/**
 Returns a version of the date whose minutes component is rounded to the amount of minutes in the first argument.
 @param minutes The minutes to which to round. If zero, the minute part is discarded.
 */
- (NSDate *)dateRoundedToMinutes:(NSUInteger)minutes;

+ (NSDate *)dateWithHour:(NSUInteger)hour minutes:(NSUInteger)minutes seconds:(NSUInteger)seconds;

- (NSInteger)daysSinceDate:(NSDate *)date;

// a fast implementtion of daysSinceDate. Requires that self is already equal to [self beginOfDay].
- (NSInteger)daysSinceDateFast:(NSDate *)date;

- (BOOL)isWeekend;

- (BOOL)isEarlier:(NSDate *)other;
- (BOOL)isLater:(NSDate *)other;
@end


@interface NSDate (Decomposition)

@property (readonly) NSInteger hour;
@property (readonly) NSInteger minute;
@property (readonly) NSInteger day;
@property (readonly) NSInteger month;
@property (readonly) NSInteger year;

@end

