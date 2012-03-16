//
//  UIImage+Additions.h
//  CheckLists
//
//  Created by Marcel Ruegenberg on 25.10.10.
//  Copyright 2010 Dustlab. All rights reserved.
//

// from http://www.icab.de/blog/2010/10/01/scaling-images-and-creating-thumbnails-from-uiviews/
@interface UIImage (Scaling)
+ (UIImage*)imageFromView:(UIView*)view;
+ (UIImage*)imageFromView:(UIView*)view scaledToSize:(CGSize)newSize;
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
@end

@interface UIImage (Additions)
/**
 Automatically make the image a stretchable image assuming it should only be stretched horizontally with 1 px in the middle being stretched.
 */
- (UIImage *)horizontallyStretchedImage;
@end
