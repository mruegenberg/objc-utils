//
//  NSObject+KVCExtensions.h
//  Classes
//
//  Created by Marcel Ruegenberg on 02.08.10.
//  Copyright 2010 Dustlab. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSObject (KVCExtensions)

/**
 Similar to -[setValuesForKeysWithDictionary:], but uses keyPaths instead of keys.
 */
- (void)setValuesForKeyPathsWithDictionary:(NSDictionary *)keyedValues;

/**
 Similar to -[dictionaryWithValuesForKeys:], but uses keyPaths instead of keys.
 */
- (NSDictionary *)dictionaryWithValuesForKeyPaths:(NSArray *)keyPaths;
@end
