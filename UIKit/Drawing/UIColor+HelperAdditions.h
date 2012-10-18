//
//  UIColor+HelperAdditions.h
//  Classes
//
//  Created by Marcel Ruegenberg on 02.08.10.
//  Copyright 2010 Dustlab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HelperAdditions)

/**
 A color very close to the usual muted blue font color on iOS.
 */
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

/**
 A fully saturated random color. use this for debugging your drawing code.
 */
+ (UIColor *)randomColor;

@end

#define RGB(rVal, gVal, bVal) [UIColor colorWithRed:rVal green:gVal blue:bVal alpha:1.0]
#define RGBA(rVal, gVal, bVal, aVal) [UIColor colorWithRed:rVal green:gVal blue:bVal alpha:aVal]
#define HSB(hVal,sVal,bVal) [UIColor colorWithHue:hVal saturation:sVal brightness:bVal alpha:1.0]
#define HSBA(hVal,sVal,bVal,aVal) [UIColor colorWithHue:hVal saturation:sVal brightness:bVal alpha:aVal]

