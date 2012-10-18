//
//  NSObject+PerformBlock.h
//  CoinToss
//
//  Created by Ludwig Schubert on 23.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (PerformBlock)

- (void)performBlock:(void(^)(void))block afterDelay:(NSTimeInterval)delay;

- (void)performBlockOnMainThread:(void(^)(void))block afterDelay:(NSTimeInterval)delay;

- (void)performBlockInBackground:(void(^)(void))block afterDelay:(NSTimeInterval)delay;

@end
