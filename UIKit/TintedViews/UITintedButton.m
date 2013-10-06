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
#import "Util.h"

@implementation UITintedButton
@synthesize roundedBackgroundColor=_roundedBackgroundColor;

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef c = UIGraphicsGetCurrentContext();
    
    if(self.roundedBackgroundColor) {
        [self.roundedBackgroundColor setFill];
        CGContextFillRoundedRect(c, self.bounds, 7);
    }
    
    if(majorOSVersion() >= 7 && [self imageForState:UIControlStateNormal]) {
        [self.imageView removeFromSuperview];
        
        UIImage *img = [self imageForState:self.state];
        if(img) {
            CGRect r = self.bounds;
            CGSize s = img.size;
            r.origin.x = (r.size.width - s.width) / 2;
            r.origin.y = (r.size.height - s.height) / 2;
            r.size = s;
            CGContextClipToMask(c, r, [img CGImage]);
            [self.tintColor setFill];
            CGContextFillRect(c, self.bounds);
            
            if(self.state & UIControlStateHighlighted || self.state & UIControlStateSelected) {
                [[UIColor colorWithWhite:1.0 alpha:0.4] setFill];
                CGContextFillRect(c, self.bounds);
            }
        }
    }
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
    if(_roundedBackgroundColor == nil && ! [self imageForState:UIControlStateNormal]) {
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

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    if(majorOSVersion() >= 7 && [self imageForState:UIControlStateNormal]) {
        [self setNeedsDisplay];
    }
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if(majorOSVersion() >= 7 && [self imageForState:UIControlStateNormal]) {
        [self setNeedsDisplay];
    }
}

@end
