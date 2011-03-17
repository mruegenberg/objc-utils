//
//  TimeHelpers.h
//  Checklists
//
//  Created by Marcel Ruegenberg on 06.02.11.
//  Copyright 2011 Dustlab. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Convert a time interval (in seconds) to a string of the form "5 days, 3 hours, 2 minutes before"
 */
NSString *timeIntervalToString(NSInteger timeInterval);