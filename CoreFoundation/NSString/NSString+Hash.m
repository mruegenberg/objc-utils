//
//  NSString+Hash.m
//  Lists
//
//  Created by Marcel Ruegenberg on 28.02.11.
//  Copyright 2011 Dustlab. All rights reserved.
//

#import "NSString+Hash.h"
#import "NSData+CocoaDevUsersAdditions.h"
#import <CommonCrypto/CommonDigest.h>


@implementation NSString (Hash)

- (NSString *)sha1Hash {
	NSData *theData = [self dataUsingEncoding:NSUTF8StringEncoding]; 
	static uint8_t digest[CC_SHA1_DIGEST_LENGTH] = {0}; //static, because it can be reused
	CC_SHA1(theData.bytes, theData.length, digest);
	NSString *theHash = [[NSData dataWithBytes:digest length:CC_SHA1_DIGEST_LENGTH] base32String];
	return theHash;
}

@end
