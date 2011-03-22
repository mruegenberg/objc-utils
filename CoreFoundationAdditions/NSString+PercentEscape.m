//
//  NSString+Escape.m
//
//  Created by Yevhene Shemet on 10.08.10.
//  Copyright Componentix 2010. All rights reserved.
//


#import "NSString+PercentEscape.h"


@implementation NSString (PercentEscape)

- (NSString *)stringWithPercentEscape {
    return [(NSString *)CFURLCreateStringByAddingPercentEscapes(
        NULL,
        (CFStringRef)[[self mutableCopy] autorelease],
        NULL,
        CFSTR("￼=,!$&'()*+;@?\n\"<>#\t :/"),
        kCFStringEncodingUTF8) autorelease];
}

@end
