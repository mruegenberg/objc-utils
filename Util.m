//
//  Util.m
//  Classes
//
//  Created by Marcel Ruegenberg on 13.06.11.
//  Copyright 2011 Dustlab. All rights reserved.
//

#import "Util.h"

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
