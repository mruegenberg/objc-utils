//
//  UITintedLabel.m
//  Classes
//
//  Created by Marcel Ruegenberg on 05.08.13.
//  Copyright (c) 2013 Dustlab. All rights reserved.
//

#import "UITintedLabel.h"
#import "UIColor+HelperAdditions.h"

@implementation UITintedLabel

- (void)tintColorDidChange {
    UIColor *tintColor = self.textColor;
    if([self respondsToSelector:@selector(tintColor)]) {
        tintColor = [(id)self tintColor];
    }
    self.textColor = tintColor;
    self.highlightedTextColor = [tintColor colorMultipliedByScalar:0.9];
}

@end
