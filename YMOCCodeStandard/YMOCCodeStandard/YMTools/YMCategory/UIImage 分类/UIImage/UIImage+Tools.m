//
//  UIImage+Tools.m
//  YMUICommonlyUsedTools
//
//  Created by iOS on 2018/5/25.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "UIImage+Tools.h"

@implementation UIImage (Tools)
#pragma mark -- 生成一张图片
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
#pragma mark -- 生成带有透明度的图片【滚动情况下】
- (UIImage *)imageByScrollAlpha:(CGFloat)alpha {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    CGContextSetAlpha(ctx, alpha);
    CGContextDrawImage(ctx, area, self.CGImage);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
#pragma mark -- 生成纯色图片
+ (UIImage *)js_createImageWithColor:(UIColor *)color withSize:(CGSize)imageSize {
    CGRect rect = CGRectMake(0.0f, 0.0f, imageSize.width, imageSize.height);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}
#pragma mark -- 生成圆角图片
+ (UIImage *)js_imageWithOriginalImage:(UIImage *)originalImage {
    CGRect rect = CGRectMake(0, 0, originalImage.size.width, originalImage.size.height);
    UIGraphicsBeginImageContextWithOptions(originalImage.size, NO, 0.0);
    CGFloat cornerRadius = MIN(originalImage.size.width, originalImage.size.height) * 0.5;
    [[UIBezierPath bezierPathWithRoundedRect:rect
                                cornerRadius:cornerRadius] addClip];
    [originalImage drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
#pragma mark -- 生成圆角任意圆角图片
+ (UIImage *)js_imageWithOriginalImage:(UIImage *)originalImage cornerRadius:(CGFloat)cornerRadius {
    CGRect rect = CGRectMake(0, 0, originalImage.size.width, originalImage.size.height);
    UIGraphicsBeginImageContextWithOptions(originalImage.size, NO, 0.0);
    [[UIBezierPath bezierPathWithRoundedRect:rect
                                cornerRadius:cornerRadius] addClip];
    [originalImage drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
#pragma mark -- 生成纯色圆角图片
+ (UIImage *)js_createRoundedImageWithColor:(UIColor *)color withSize:(CGSize)imageSize {
    UIImage *originalImage = [self js_createImageWithColor:color withSize:imageSize];
    return [self js_imageWithOriginalImage:originalImage];
}
#pragma mark -- 生成纯色任意圆角图片
+ (UIImage *)js_createRoundedImageWithColor:(UIColor *)color withSize:(CGSize)imageSize cornerRadius:(CGFloat)cornerRadius {
    UIImage *originalImage = [self js_createImageWithColor:color withSize:imageSize];
    return [self js_imageWithOriginalImage:originalImage cornerRadius:cornerRadius];
}
#pragma mark -- 生成带圆环的圆角图片
+ (UIImage *)js_imageWithOriginalImage:(UIImage *)originalImage withBorderColor:(UIColor *)borderColor withBorderWidth:(CGFloat)borderWidth {
    CGRect rect = CGRectMake(0, 0, originalImage.size.width, originalImage.size.height);
    UIGraphicsBeginImageContextWithOptions(originalImage.size, NO, 0.0);
    CGFloat cornerRadius = MIN(originalImage.size.width, originalImage.size.height) * 0.5;
    [[UIBezierPath bezierPathWithRoundedRect:rect
                                cornerRadius:cornerRadius] addClip];
    [originalImage drawInRect:rect];
    
    CGPoint center = CGPointMake(originalImage.size.width * 0.5, originalImage.size.height * 0.5);
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:center radius:cornerRadius - borderWidth*0.5 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    circlePath.lineWidth = borderWidth;
    [borderColor setStroke];
    [circlePath stroke];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
#pragma mark image scale utility
+ (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < MainScreenWidth) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = MainScreenWidth;
        btWidth = sourceImage.size.width * (MainScreenWidth / sourceImage.size.height);
    } else {
        btWidth = MainScreenWidth;
        btHeight = sourceImage.size.height * (MainScreenWidth / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

+ (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}
@end
