//
//  NSURL+ParameterParsing.h
//  Classes
//
//  Created by Marcel Ruegenberg on 02.08.10.
//  Copyright 2010 Dustlab. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSURL (ParameterParsing)

/**
 Get the parameters that were specified in the URL's query
 as a &-separated list of "key=value" pairs.
 The behaviour if there is more than one = (i.e. not with a & in between) in the string is undefined.
 */
- (NSDictionary *)getParameters;

@end
