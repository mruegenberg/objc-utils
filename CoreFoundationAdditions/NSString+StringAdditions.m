//
//  NSString+StringAdditions.m
//  Classes
//
//  Created by Marcel Ruegenberg on 30.12.11.
//  Copyright (c) 2011 Dustlab. All rights reserved.
//

#import "NSString+StringAdditions.h"

@implementation NSString (StringAdditions)

- (NSString *)reverseString {
    NSUInteger len = [self length];
    NSMutableString *rtr=[NSMutableString stringWithCapacity:len];
    
    while (len > (NSUInteger)0) { 
        unichar uch = [self characterAtIndex:--len]; 
        [rtr appendString:[NSString stringWithCharacters:&uch length:1]];
    }
    return rtr;
}

- (NSString *)commonSuffixWithString:(NSString *)aString options:(NSStringCompareOptions)mask {
    if(aString == nil) return self;
    return [[[self reverseString] commonPrefixWithString:[aString reverseString] options:mask] reverseString];
}

- (NSString *)startCapitalizedString {
    return [self stringByReplacingCharactersInRange:NSMakeRange(0,1)  
                                         withString:[[self  substringToIndex:1] capitalizedString]];
}

@end
