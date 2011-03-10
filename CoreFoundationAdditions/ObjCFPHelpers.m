//
//  ObjCFPHelpers.m
//  Classes
//
//  Created by Marcel Ruegenberg on 02.08.10.
//  Copyright 2010 Dustlab. All rights reserved.
//

#import "ObjCFPHelpers.h"


id fromNil(id origValue, id alternativeValue) {
	if(origValue == nil || origValue == [NSNull null]) {
		return alternativeValue;
	}
	return origValue;
}