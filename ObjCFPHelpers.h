//
//  ObjCFPHelpers.h
//  Classes
//
//  Created by Marcel Ruegenberg on 02.08.10.
//  Copyright 2010 Dustlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSArray+FPAdditions.h"


/* 
 If origValue is nil, return alternativeValue, otherwise return origValue.
 
 You can not use origValue || alternativeValue for this in Obj-C.
 */
id fromNil(id origValue, id alternativeValue);