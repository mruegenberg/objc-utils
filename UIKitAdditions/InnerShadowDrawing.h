//
//  InnerShadowDrawing.h
//  HDCalc
//
//  Created by Marcel Ruegenberg on 18.03.11.
//  Copyright 2011 Dustlab. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 Allows generic drawing of inner shadows.
 Based on http://stackoverflow.com/questions/3231690/inner-shadow-in-uilabel
 @param rect A rectangle, as in the drawRect: method of UIView
 @param shadowSize The size of the inner shadow
 @param drawJustShapeBlock A block that draws the shape itself, without setting colors
 @param drawColoredShapeBlock A block the draws the shape the way it should appear with the shadow
 */
void drawWithInnerShadow(CGRect rect, 
                         CGSize shadowSize, 
                         CGFloat shadowBlur, 
                         UIColor *shadowColor, 
                         void (^drawJustShapeBlock)(void), 
                         void (^drawColoredShapeBlock)(void));
