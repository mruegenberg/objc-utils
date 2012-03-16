//
//  UIImage+Additions.m
//  CheckLists
//
//  Created by Marcel Ruegenberg on 25.10.10.
//  Copyright 2010 Dustlab. All rights reserved.
//

#import "UIImage+Additions.h"
#import <QuartzCore/QuartzCore.h>


@implementation UIImage (Scaling)

+ (UIImage*)imageFromView:(UIView*)view
{
	UIGraphicsBeginImageContext([view bounds].size);
    BOOL hidden = [view isHidden];
    [view setHidden:NO];
	[view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    [view setHidden:hidden];
    return image;
}

+ (UIImage*)imageFromView:(UIView*)view scaledToSize:(CGSize)newSize
{
    UIImage *image = [self imageFromView:view];
    if ([view bounds].size.width != newSize.width ||
		[view bounds].size.height != newSize.height) {
        image = [self imageWithImage:image scaledToSize:newSize];
    }
    return image;
}

+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
	UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    return newImage;
}

@end

@implementation UIImage (Additions)

- (UIImage *)horizontallyStretchedImage {
    return [self stretchableImageWithLeftCapWidth:((self.size.width - 1) / 2.0) topCapHeight:0];
}

@end
