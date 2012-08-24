//
//  UIColor+HelperAdditions.m
//  Classes
//
//  Created by Marcel Ruegenberg on 02.08.10.
//  Copyright 2010 Dustlab. All rights reserved.
//

#import "UIColor+HelperAdditions.h"


@implementation UIColor (HelperAdditions)

+ (UIColor *)prussianBlueColor {
	return [UIColor colorWithRed:0.34 green:0.42 blue:0.55 alpha:1.0];
}

- (UIColor *)colorMultipliedByScalar:(CGFloat)scalar withMinimum:(CGFloat) min {
	CGColorRef cgcolor = [self CGColor];
	size_t num_of_components = CGColorGetNumberOfComponents(cgcolor);
	
	const CGFloat *comps = CGColorGetComponents(cgcolor);
	CGFloat *newComps = calloc(num_of_components, sizeof( CGFloat ));
	
	for (size_t i = 0; i < num_of_components - 1; ++i) {
		newComps[i] = comps[i] * scalar;
		if(newComps[i] < min) newComps[i] = min;
	}
	newComps[num_of_components - 1] = comps[num_of_components - 1];
	CGColorRef newCGColor = CGColorCreate(CGColorGetColorSpace(cgcolor), newComps);
	free(newComps);
	
	UIColor *newcolor = [UIColor colorWithCGColor:newCGColor];
	CGColorRelease(newCGColor);
	
	return newcolor;
}

- (UIColor *)colorMultipliedByScalar:(CGFloat)scalar {
	return [self colorMultipliedByScalar:scalar withMinimum:0.0];
}

@end
