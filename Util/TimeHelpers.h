//
//  TimeHelpers.h
//  Checklists
//
//  Created by Marcel Ruegenberg on 06.02.11.
//  Copyright 2011 Dustlab. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Get the absolute length of a time interval as a string.
 Like timeIntervalToString, but without the "before" and "after" suffix.
 */
NSString *timeLengthToString(NSInteger timeLength);

/**
 Get the absolute length of a time interval as a string.
 Explicitly spells out only the number of days, the rest is abbreviated as hh:mm.
 */
NSString *timeLengthToShortString(NSInteger timeLength);

/**
 Convert a time interval (in seconds) to a string of the form "5 days, 3 hours, 2 minutes before"
 */
NSString *timeIntervalToString(NSInteger timeInterval);
