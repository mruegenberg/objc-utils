//
//  DrawingHelpers.h
//  
//
//  Created by Marcel Ruegenberg on 21.09.09.
//  Copyright 2009 Dustlab. All rights reserved.
//

#import <UIKit/UIKit.h>

void CGPathAddRoundedRectSimple(CGMutablePathRef path, CGRect rect, CGFloat radius);

/**
 Add a rounded rectangle to the current CGContext.
 @param c the CGContext
 @param rect the rectangle to which the rounded rectangle corresponds
 @param radius the radius of the arcs of the rectangle corners
 */
void CGContextAddRoundedRect(CGContextRef c, CGRect rect, CGFloat radius);

/**
 Stroke a rounded rectangle in a CGContext.
 */
void CGContextStrokeRoundedRect(CGContextRef c, CGRect rect, CGFloat radius);

/**
 Fill a rounded rectangle in a CGContext.
 */
void CGContextFillRoundedRect(CGContextRef c, CGRect rect, CGFloat radius);

/**
 Clip a CGContext to a rounded rectangle.
 */
void CGContextClipToRoundedRect(CGContextRef c, CGRect rect, CGFloat radius);


/**
 Draw a linear gradient with a number of colors.
 This function is very similar to CGGradientCreateWithColors, but immediately draws the gradient and keeps us from having to worry about color spaces.
 
 Please note that the supplied UIColors in the array must be RGB colors.
 */
void DL_CGContextDrawLinearGradient(CGContextRef context, NSArray *colors, const CGFloat locations[], CGPoint startPoint, CGPoint endPoint);

/**
 Draw a linear gradient from top to bottom of a supplied rectangle.
 */
void DL_CGContextDrawLinearGradientOverRect(CGContextRef context, NSArray *colors, const CGFloat locations[], CGRect rect);

/**
 Draw the typical steel gradient.
 */
void DL_CGContextDrawSteelGradientOverRect(CGContextRef context, CGRect rect);
void DL_CGContextDrawLightSteelGradientOverRect(CGContextRef context, CGRect rect);

/**
 Draw highlights at top and bottom.
 */
void DL_CGContextDrawHighlightsOverRect(CGContextRef context, CGRect rect);

#define DISCLOSURE_IND_SIZE 6
/**
 Draw a disclosure indicator
 @param upLeft The upper left corner of the disclosure indicator.
 */
void DL_CGContextDrawDisclosureIndicatorAtPoint(CGContextRef context, CGPoint upLeft);

