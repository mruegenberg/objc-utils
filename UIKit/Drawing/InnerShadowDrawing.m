//
//  InnerShadowDrawing.m
//  HDCalc
//
//  Created by Marcel Ruegenberg on 18.03.11.
//  Copyright 2011 Dustlab. All rights reserved.
//

#import "InnerShadowDrawing.h"


UIImage *blackSquare(CGSize size) {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);  
    [[UIColor blackColor] setFill];
    CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, size.width, size.height));
    UIImage *blackSquare = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return blackSquare;
}

CGImageRef createMask(CGSize size, void (^shapeBlock)(void)) {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);  
    shapeBlock();
    CGImageRef shape = [UIGraphicsGetImageFromCurrentImageContext() CGImage];
    UIGraphicsEndImageContext();  
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(shape),
                                        CGImageGetHeight(shape),
                                        CGImageGetBitsPerComponent(shape),
                                        CGImageGetBitsPerPixel(shape),
                                        CGImageGetBytesPerRow(shape),
                                        CGImageGetDataProvider(shape), NULL, false);
    return mask;
}

void drawWithInnerShadow(CGRect rect, 
                         CGSize shadowSize, 
                         CGFloat shadowBlur, 
                         UIColor *shadowColor, 
                         void (^drawJustShapeBlock)(void), 
                         void (^drawColoredShapeBlock)(void)) {
    CGImageRef mask = createMask(rect.size, ^{
        [[UIColor blackColor] setFill];
        CGContextFillRect(UIGraphicsGetCurrentContext(), rect);
        [[UIColor whiteColor] setFill];
        drawJustShapeBlock();
    });
    
    CGImageRef cutoutRef = CGImageCreateWithMask(blackSquare(rect.size).CGImage, mask);
    CGImageRelease(mask);
    UIImage *cutout = [UIImage imageWithCGImage:cutoutRef scale:[[UIScreen mainScreen] scale] orientation:UIImageOrientationUp];
    CGImageRelease(cutoutRef);
    
    CGImageRef shadedMask = createMask(rect.size, ^{
        [[UIColor whiteColor] setFill];
        CGContextFillRect(UIGraphicsGetCurrentContext(), rect);
        CGContextSetShadowWithColor(UIGraphicsGetCurrentContext(), shadowSize, shadowBlur, [shadowColor CGColor]);
        [cutout drawAtPoint:CGPointZero];
    });
    
    // create negative image
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [[UIColor blackColor] setFill];
    drawJustShapeBlock();
    UIImage *negative = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext(); 
    
    CGImageRef innerShadowRef = CGImageCreateWithMask(negative.CGImage, shadedMask);
    CGImageRelease(shadedMask);
    UIImage *innerShadow = [UIImage imageWithCGImage:innerShadowRef scale:[[UIScreen mainScreen] scale] orientation:UIImageOrientationUp];
    CGImageRelease(innerShadowRef);
    
    // draw actual image
    drawColoredShapeBlock();

    // finally apply shadow
    [innerShadow drawAtPoint:CGPointZero];
}
