//
//  UITintedTextfield.m
//  Classes
//
//  Created by Marcel Ruegenberg on 05.08.13.
//  Copyright (c) 2013 Dustlab. All rights reserved.
//

#import "UITintedTextfield.h"

@implementation UITintedTextfield

- (void)tintColorDidChange {
    UIColor *tintColor = self.textColor;
    if([self respondsToSelector:@selector(tintColor)]) {
        tintColor = [(id)self tintColor];
    }
    self.textColor = tintColor;
}

@end
