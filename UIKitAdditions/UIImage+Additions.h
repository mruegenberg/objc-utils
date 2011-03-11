//
//  UIImage+Additions.h
//  CheckLists
//
//  Created by Marcel Ruegenberg on 25.10.10.
//  Copyright 2010 Dustlab. All rights reserved.
//

#import <Foundation/Foundation.h>


// from http://www.icab.de/blog/2010/10/01/scaling-images-and-creating-thumbnails-from-uiviews/
@interface UIImage (Additions)
+ (UIImage*)imageFromView:(UIView*)view;
+ (UIImage*)imageFromView:(UIView*)view scaledToSize:(CGSize)newSize;
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
@end
