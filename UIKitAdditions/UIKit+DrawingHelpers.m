//
//  DrawingHelpers.m
//  Planner
//
//  Created by Marcel Ruegenberg on 21.09.09.
//  Copyright 2009 Dustlab. All rights reserved.
//

#import "UIKit+DrawingHelpers.h"


void CGContextAddRoundedRect(CGContextRef c, CGRect rect, CGFloat radius) {
	if(2 * radius > rect.size.height) radius = rect.size.height / 2.0;
	if(2 * radius > rect.size.width) radius = rect.size.width / 2.0;
	CGContextAddArc(c, rect.origin.x + radius, rect.origin.y + radius, radius, M_PI, M_PI * 1.5, 0);
	CGContextAddArc(c, rect.origin.x + rect.size.width - radius, rect.origin.y + radius, radius, M_PI * 1.5, M_PI * 2, 0);
	CGContextAddArc(c, rect.origin.x + rect.size.width - radius, rect.origin.y + rect.size.height - radius, radius, M_PI * 2, M_PI * 0.5, 0);
	CGContextAddArc(c, rect.origin.x + radius, rect.origin.y + rect.size.height - radius, radius, M_PI * 0.5, M_PI, 0);
	CGContextAddLineToPoint(c, rect.origin.x, rect.origin.y + radius);
}

void CGContextStrokeRoundedRect(CGContextRef c, CGRect rect, CGFloat radius) {
	CGContextBeginPath(c);
	CGContextAddRoundedRect(c, rect, radius);
	CGContextStrokePath(c);
}

void CGContextFillRoundedRect(CGContextRef c, CGRect rect, CGFloat radius) {
	CGContextBeginPath(c);
	CGContextAddRoundedRect(c, rect, radius);
	CGContextFillPath(c);
}

void CGContextClipToRoundedRect(CGContextRef c, CGRect rect, CGFloat radius) {
	CGContextBeginPath(c);
	CGContextAddRoundedRect(c, rect, radius);
	CGContextClip(c);
}	



void DL_CGContextDrawLinearGradient(CGContextRef context, NSArray *colors, const CGFloat locations[], CGPoint startPoint, CGPoint endPoint) {	
	CGColorSpaceRef myColorspace = CGColorSpaceCreateDeviceRGB();
	NSMutableArray *arr = [NSMutableArray arrayWithCapacity:[colors count]];
	for(UIColor *c in colors) { [arr addObject:(id)[c CGColor]]; }
	CGGradientRef gradient = CGGradientCreateWithColors(myColorspace, (CFArrayRef)arr, locations);
	
	CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
	
	CGGradientRelease(gradient);
	CGColorSpaceRelease(myColorspace);
}

void DL_CGContextDrawLinearGradientOverRect(CGContextRef context, NSArray *colors, const CGFloat locations[], CGRect rect) {
	DL_CGContextDrawLinearGradient(context, colors, locations, rect.origin, CGPointMake(rect.origin.x, rect.origin.y + rect.size.height));
}

void DL_CGContextDrawSteelGradientOverRect(CGContextRef context, CGRect rect) {
	CGFloat locations[4] = { 0.0, 0.015, 0.985, 1.0 };
	DL_CGContextDrawLinearGradientOverRect(context, 
										   [NSArray arrayWithObjects:
											[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0],
											[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0],
											[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1.0],
											[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0],nil],
										   locations, rect);
}

void DL_CGContextDrawDisclosureIndicatorAtPoint(CGContextRef context, CGPoint p) {
	CGContextSetLineWidth(context, 3);
	[[UIColor blackColor] set];
	CGContextSetAlpha(context, 0.66);
	p.x += 0.5; p.y += 0.5;
	CGContextMoveToPoint(context, p.x, p.y);
	p.x += DISCLOSURE_IND_SIZE;
	p.y += DISCLOSURE_IND_SIZE;
	CGContextAddLineToPoint(context, p.x, p.y);
	p.x -= DISCLOSURE_IND_SIZE;
	p.y += DISCLOSURE_IND_SIZE;
	CGContextAddLineToPoint(context, p.x, p.y);
	CGContextStrokePath(context);
	CGContextSetAlpha(context, 1.0);
}
