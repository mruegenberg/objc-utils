//
//  UIColor+HelperAdditions.h
//  Classes
//
//  Created by Marcel Ruegenberg on 02.08.10.
//  Copyright 2010 Dustlab. All rights reserved.
//

@interface UIColor (HelperAdditions)

+ (UIColor *)prussianBlueColor;

/**
 Returns a copy of the color whose non-alpha components were multiplied by a scalar value.
 */
- (UIColor *)colorMultipliedByScalar:(CGFloat)scalar;

/**
 Returns a copy of the color whose non-alpha components were multiplied by a scalar value.
 @param min If the value of a component is smaller than min after the multiplication, it is set to min instead.
 */
- (UIColor *)colorMultipliedByScalar:(CGFloat)scalar withMinimum:(CGFloat)min;

@end
