//
//  Util.h
//  Classes
//
//  Created by Marcel Ruegenberg on 13.06.11.
//  Copyright 2011 Dustlab. All rights reserved.
//

#import <Foundation/Foundation.h>


id fromNil(id origValue, id alternativeValue);
NSString *fromEmptyStr(NSString *origValue, NSString *alternativeValue);

NSInteger majorOSVersion();
NSInteger minorOSVersion();
