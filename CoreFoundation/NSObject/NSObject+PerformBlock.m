//
//  NSObject+PerformBlock.m
//  CoinToss
//
//  Created by Ludwig Schubert on 23.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSObject+PerformBlock.h"

@implementation NSObject (PerformBlock)

- (void)performBlock:(void(^)(void))block afterDelay:(NSTimeInterval)delay
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC), 
                   dispatch_get_current_queue(), ^{
                       block();
                   });
}

- (void)performBlockOnMainThread:(void(^)(void))block afterDelay:(NSTimeInterval)delay
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC), 
                   dispatch_get_main_queue(), ^{
                       block();
                   });
}


- (void)performBlockInBackground:(void(^)(void))block afterDelay:(NSTimeInterval)delay
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC), 
                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                       block();
                   });
}

@end
