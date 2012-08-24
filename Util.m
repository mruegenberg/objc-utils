//
//  Util.m
//  Classes
//
//  Created by Marcel Ruegenberg on 13.06.11.
//  Copyright 2011 Dustlab. All rights reserved.
//

#import "Util.h"
#import <UIKit/UIKit.h>


id fromNil(id origValue, id alternativeValue) {
	if(origValue == nil || origValue == [NSNull null]) {
		return alternativeValue;
	}
	return origValue;
}

NSString *fromEmptyStr(NSString *origValue, NSString *alternativeValue) {
	if(origValue == nil || [origValue isEqualToString:@""]) {
		return alternativeValue;
	}
	return origValue;
}

NSInteger majorOSVersion() {
    static NSInteger osVersion = -1;
    if(osVersion < 0) {
        NSString *v = [[UIDevice currentDevice] systemVersion];
        NSArray *c = [v componentsSeparatedByString:@"."];
        if([c count] > 0) osVersion = [[c objectAtIndex:0] integerValue];
    }
    return osVersion;
}

NSInteger minorOSVersion() {
    static NSInteger osVersion = -1;
    if(osVersion < 0) {
        NSString *v = [[UIDevice currentDevice] systemVersion];
        NSArray *c = [v componentsSeparatedByString:@"."];
        if([c count] > 1) osVersion = [[c objectAtIndex:1] integerValue];
    }
    return osVersion;
}
