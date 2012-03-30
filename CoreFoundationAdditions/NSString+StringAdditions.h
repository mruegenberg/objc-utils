//
//  NSString+StringAdditions.h
//  Classes
//
//  Created by Marcel Ruegenberg on 30.12.11.
//  Copyright (c) 2011 Dustlab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (StringAdditions)

- (NSString *)reverseString;

- (NSString *)commonSuffixWithString:(NSString *)aString options:(NSStringCompareOptions)mask;

/**
 * Like -[capitalizedString], but capitalizes only the first word.
 */
- (NSString *)startCapitalizedString;

@end

