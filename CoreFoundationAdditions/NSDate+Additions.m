//
//  NSDate+Additions.m
//  Classes
//
//  Created by Marcel Ruegenberg on 02.08.10.
//  Copyright 2010 Dustlab. All rights reserved.
//

#import "NSDate+Additions.h"


NSDateFormatter *timeFormatter = nil;
NSDateFormatter *dateFormatter = nil;
NSDateFormatter *dateTimeFormatter = nil;

#define DATE_COMPONENTS (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)

@implementation NSDate (DatePrinters)

- (NSString *)shortTimeString {
	if(timeFormatter == nil) {
		timeFormatter = [[NSDateFormatter alloc] init];
		[timeFormatter setDateStyle:NSDateFormatterNoStyle];
		[timeFormatter setTimeStyle:NSDateFormatterShortStyle];
	}
	
	NSString *r = [timeFormatter stringFromDate:self];
	return r;
}

- (NSString *)dateString {
	if(dateFormatter == nil) {
		dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateStyle:NSDateFormatterShortStyle];
		[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
	}
	
	NSString *r = [dateFormatter stringFromDate:self];
	return r;
}

- (NSString *)weekdayString {
    static NSDateFormatter *wDayFormatter = nil;
    if(wDayFormatter == nil) wDayFormatter = [[NSDateFormatter alloc] init];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:DATE_COMPONENTS fromDate:self];
    NSAssert(wDayFormatter != nil, @"Date Formatter for weekdays is nil, but should have a value.");
    return [[wDayFormatter standaloneWeekdaySymbols] objectAtIndex:([components weekday] - 1)];
}

- (NSString *)shortWeekdayString {
    static NSDateFormatter *wDayFormatter = nil;
    if(wDayFormatter == nil) wDayFormatter = [[NSDateFormatter alloc] init];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:DATE_COMPONENTS fromDate:self];
    NSAssert(wDayFormatter != nil, @"Date Formatter for short weekdays is nil, but should have a value.");
    return [[wDayFormatter shortStandaloneWeekdaySymbols] objectAtIndex:([components weekday] - 1)];
}

- (NSString *)dateTimeString {
	if(dateTimeFormatter == nil) {
		dateTimeFormatter = [[NSDateFormatter alloc] init];
		[dateTimeFormatter setDateStyle:NSDateFormatterShortStyle];
		[dateTimeFormatter setTimeStyle:NSDateFormatterShortStyle];
	}
	
	NSString *r = [dateTimeFormatter stringFromDate:self];
	return r;
}

@end


@implementation NSDate (DateHelpers)

- (NSDate *)nextHour {
	return [self dateByAddingMinutes:60];
}

- (NSDate *)prevHour {
	return [self dateByAddingMinutes:(-60)];
}

- (NSDate *)dateByAddingDays:(NSInteger)days {
	NSInteger secsToAdd = 60 * 60 * 24 * days;
	return [[[NSDate alloc] initWithTimeInterval:secsToAdd sinceDate:self] autorelease];
}

- (NSDate *)dateByAddingMinutes:(NSInteger)minutes {
	NSInteger secsToAdd = 60 * minutes;
	return [[[NSDate alloc] initWithTimeInterval:secsToAdd sinceDate:self] autorelease];
}

- (NSDate *)prevDay {
	return [self dateByAddingDays:(-1)];
}

- (NSDate *)nextDay {
	return [self dateByAddingDays:1];
}

- (NSDate *)prevWeek {
	return [self dateByAddingDays:((-1) * 7)];
}

- (NSDate *)nextWeek {
	return [self dateByAddingDays:(7)];
}

- (NSDate *)justTime {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	static unsigned unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit;
	NSDateComponents *components = [calendar components:unitFlags fromDate:self];
	[components setYear:1970]; [components setMonth:1]; [components setDay:1]; 
	return [calendar dateFromComponents:components];
}

- (NSDate *)justHour {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	static unsigned unitFlags = NSHourCalendarUnit;
	NSDateComponents *components = [calendar components:unitFlags fromDate:self];
	[components setYear:1970]; [components setMonth:1]; [components setDay:1];
	[components setMinute:0]; [components setSecond:0];
	return [calendar dateFromComponents:components];
}

+ (NSDate *)nowTime {
	return [[NSDate date] justTime];
}

- (NSDate *)beginOfDay {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:DATE_COMPONENTS fromDate:self];
    [components setHour:0]; [components setMinute:0]; [components setSecond:0];
	return [[NSCalendar currentCalendar] dateFromComponents:components];
}

- (NSDate *)endOfDay {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:DATE_COMPONENTS fromDate:self];
    [components setHour:23]; [components setMinute:59]; [components setSecond:59];
	return [[NSCalendar currentCalendar] dateFromComponents:components];
}

- (NSDate *)dateRoundedToMinutes:(NSUInteger)minutes {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	static unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit;
	NSDateComponents *comps = [calendar components:unitFlags fromDate:self];
	NSInteger dateMinutes = [comps minute];
	if(minutes == 0) dateMinutes = 0;
	else dateMinutes = (dateMinutes / minutes) * minutes;
	[comps setMinute:dateMinutes];
	return [calendar dateFromComponents:comps];
}

+ (NSDate *)dateWithHour:(NSUInteger)hour minutes:(NSUInteger)minutes seconds:(NSUInteger)seconds {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:DATE_COMPONENTS fromDate:[NSDate date]];
    [components setHour:hour];
    [components setMinute:minutes];
    [components setSecond:seconds];
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

- (NSInteger)daysSinceDate:(NSDate *)date {
	return ([self timeIntervalSinceDate:date] / (60 * 60 * 24));
}

@end


@implementation NSDate (Decomposition)

- (NSInteger)hour {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:DATE_COMPONENTS fromDate:self];
	return [components hour];
}

- (NSInteger)minute {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:DATE_COMPONENTS fromDate:self];
	return [components minute];
}

- (NSInteger)day {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:DATE_COMPONENTS fromDate:self];
	return [components day];
}

- (NSInteger)month {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:DATE_COMPONENTS fromDate:self];
	return [components month];
}

- (NSInteger)year {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:DATE_COMPONENTS fromDate:self];
	return [components year];
}

@end
