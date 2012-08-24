//
//  FPTuple.m
//  Classes
//
//  Created by Marcel Ruegenberg on 02.08.10.
//  Copyright 2010 Dustlab. All rights reserved.
//

#import "FPTuple.h"


@implementation FPTuple
@synthesize fst, snd;

- (id)initWithFirst:(id)first second:(id)second {
	if((self = [super init])) {
		self.fst = first;
		self.snd = second;
	}
	return self;
}

+ (id)tupleWithFirst:(id)first second:(id)second {
	return [[FPTuple alloc] initWithFirst:first second:second];
}



@end
