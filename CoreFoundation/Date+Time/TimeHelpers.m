//
//  TimeHelpers.m
//  Checklists
//
//  Created by Marcel Ruegenberg on 06.02.11.
//  Copyright 2011 Dustlab. All rights reserved.
//

// time interval in seconds
NSString *timeLengthToString(NSInteger timeLength) {
    NSString *timeStr = @"";
    if(timeLength < 0) timeLength = timeLength * (-1);
	if(timeLength >= 60 * 60 * 24) {
        if(timeLength == 60 * 60 * 24) timeStr = NSLocalizedStringWithDefaultValue(@"Time Day", @"Generic", [NSBundle mainBundle], @"1 day", @"The format for describing a number of days, if the number is 1, e.g '1 day'");
        else
            timeStr = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"Time Days", @"Generic", [NSBundle mainBundle], @"%d days", @"The format for describing a number of days, e.g '5 days'"), (timeLength / (60 * 60 * 24))];
        timeLength -= (timeLength / (60 * 60 * 24)) * (60 * 60 * 24);
    }
	if(timeLength >= 60 * 60) {
        NSString *prefix;
        NSInteger m = timeLength / (60 * 60);
        if(! [timeStr isEqualToString:@""]) timeStr = [NSString stringWithFormat:@"%@, ", timeStr];
        if(m == 1) prefix = NSLocalizedStringWithDefaultValue(@"Time Hour", @"Generic", [NSBundle mainBundle], @"1 hour", @"The format for describing a number of hours, if the number is 1, e.g '1 hour'");
        else
            prefix = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"Time Hours", @"Generic", [NSBundle mainBundle], @"%d hours", @"The format for describing a number of hours, e.g '5 hours'"), m];
        timeLength -= m * (60 * 60);
        timeStr = [NSString stringWithFormat:@"%@%@", timeStr, prefix];
    }
    {
        NSInteger m = (NSInteger) ceil(((float)timeLength) / 60.0);
        if(m != 0) {
            NSString *prefix;
            if(! [timeStr isEqualToString:@""]) timeStr = [NSString stringWithFormat:@"%@, ", timeStr];
            if(m == 1) prefix = NSLocalizedStringWithDefaultValue(@"Time Minute", @"Generic", [NSBundle mainBundle], @"1 minute", @"The format for describing a number of minutes, if the number is 1, e.g '1 minute'");
            else
                prefix = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"Time Minutes", @"Generic", [NSBundle mainBundle], @"%d minutes", @"The format for describing a number of minutes, e.g '5 minutes'"), m];
            timeStr = [NSString stringWithFormat:@"%@%@", timeStr, prefix];
        }
    }
    return timeStr;
}

NSString *timeLengthToShortString(NSInteger timeLength) {
    NSString *prefix = @"";
    if(timeLength < 0) timeLength = timeLength * (-1);
	if(timeLength >= 60 * 60 * 24) {
        if(timeLength == 60 * 60 * 24) prefix = NSLocalizedStringWithDefaultValue(@"Time Day", @"Generic", [NSBundle mainBundle], @"1 day", @"The format for describing a number of days, if the number is 1, e.g '1 day'");
        else
            prefix = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"Time Days", @"Generic", [NSBundle mainBundle], @"%d days", @"The format for describing a number of days, e.g '5 days'"), (timeLength / (60 * 60 * 24))];
        timeLength = timeLength % (60 * 60 * 24);
    }
    {
        NSInteger hours = timeLength / (60 * 60);
        NSInteger minutes = (NSInteger) ceil(((float)(timeLength - (hours * 60 * 60))) / 60.0);
        prefix = [NSString stringWithFormat:([prefix isEqualToString:@""] ? @"%@%d:%02d" : @"%@, %d:%02d"), prefix, hours, minutes];
    }
    
    return prefix;
}

NSString *timeIntervalToString(NSInteger timeInterval) {
	if(timeInterval == 0) return NSLocalizedStringWithDefaultValue(@"Time None", @"Generic", [NSBundle mainBundle], @"None", @"Text that describes a time interval of zero length");

    NSString *format = NSLocalizedStringWithDefaultValue(@"Time Interval Format", @"Generic", [NSBundle mainBundle], @"%1$@ %2$@", @"Format for time interval strings. If the normal order would be like '5 minutes after', leave it as '1 2', if in your language the 'after' would come after the rest, change the order, i.e '2 1'");
	NSString *indicator = timeInterval < 0 ? NSLocalizedStringWithDefaultValue(@"Time Before Suffix", @"Generic", [NSBundle mainBundle], @"before", @"Suffix that describes that something occured before something else, i.e the 'before' in '60 minutes before'") : NSLocalizedStringWithDefaultValue(@"Time After Suffix", @"Generic", [NSBundle mainBundle], @"after", @"Suffix that describes that something occured after something else, i.e the 'after' in 'Ring the bell 60 minutes after the event'");
    NSString *timeLen = timeLengthToString(timeInterval);
	return [NSString stringWithFormat:format, timeLen, indicator];
}
