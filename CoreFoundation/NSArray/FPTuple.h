//
//  FPTuple.h
//  Classes
//
//  Created by Marcel Ruegenberg on 02.08.10.
//  Copyright 2010 Dustlab. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 A tuple containing two arbitrary objects. 
 This class is here to keep the user from having to write an extra class (or having to use a NSDictionary) when all we want is just a cheap wrapper.
 */
@interface FPTuple : NSObject {
	id fst;
	id snd;
}

@property (nonatomic, strong) id fst;
@property (nonatomic, strong) id snd;

- (id)initWithFirst:(id)fst second:(id)snd;
+ (id)tupleWithFirst:(id)fst second:(id)snd;

@end
