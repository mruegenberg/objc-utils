//
//  UITintedButton.m
//  Classes
//
//  Created by Marcel Ruegenberg on 05.08.13.
//  Copyright (c) 2013 Dustlab. All rights reserved.
//

#import "UITintedButton.h"
#import "UIKit+DrawingHelpers.h"
#import "UIColor+HelperAdditions.h"

@implementation UITintedButton
@synthesize roundedBackgroundColor=_roundedBackgroundColor;

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef c = UIGraphicsGetCurrentContext();
    
    [self.roundedBackgroundColor setFill];
    CGContextFillRoundedRect(c, self.bounds, 7);
}

- (void)tintColorDidChange {
    UIColor *tintColor = [self titleColorForState:UIControlStateNormal];
    if([self respondsToSelector:@selector(tintColor)]) {
        tintColor = [self tintColor];
    }
    [self setTitleColor:tintColor forState:UIControlStateNormal];
    [self setTitleColor:[tintColor colorMultipliedByScalar:0.9] forState:UIControlStateHighlighted];
    
}

- (UIColor *)roundedBackgroundColor {
    if(_roundedBackgroundColor == nil) {
        _roundedBackgroundColor = [UIColor colorWithWhite:0.0 alpha:0.03];
    }
    return _roundedBackgroundColor;
}

- (void)setRoundedBackgroundColor:(UIColor *)roundedBackgroundColor {
    if(_roundedBackgroundColor != roundedBackgroundColor) {
        _roundedBackgroundColor = roundedBackgroundColor;
        [self setNeedsDisplay];
    }
}

@end
