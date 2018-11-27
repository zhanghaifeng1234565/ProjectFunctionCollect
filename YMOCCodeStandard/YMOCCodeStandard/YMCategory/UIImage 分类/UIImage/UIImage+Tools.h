//
//  UIImage+Tools.h
//  YMUICommonlyUsedTools
//
//  Created by iOS on 2018/5/25.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Tools)

/** 图片二进制 */
@property (nonatomic, strong) NSData *ym_imageData;


/**
 生成一张图片

 @param color 颜色值
 @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;


/**
 设置图片的透明度

 @param alpha 透明度
 @return 图片
 */
- (UIImage *)imageByScrollAlpha:(CGFloat)alpha;


/**
 *  创建纯色图片
 *
 *  @param color     生成纯色图片的颜色
 *  @param imageSize 需要创建纯色图片的尺寸
 *
 *  @return 纯色图片
 */
+ (UIImage *)js_createImageWithColor:(UIColor *)color withSize:(CGSize)imageSize;


/**
 *  创建圆角图片
 *
 *  @param originalImage 原始图片
 *
 *  @return 带圆角的图片
 */
+ (UIImage *)js_imageWithOriginalImage:(UIImage *)originalImage;


/**
 *  创建圆角纯色图片
 *
 *  @param color     设置圆角纯色图片的颜色
 *  @param imageSize 设置元角纯色图片的尺寸
 *
 *  @return 圆角纯色图片
 */
+ (UIImage *)js_createRoundedImageWithColor:(UIColor *)color withSize:(CGSize)imageSize;


/**
 *  生成带圆环的圆角图片
 *
 *  @param originalImage 原始图片
 *  @param borderColor   圆环颜色
 *  @param borderWidth   圆环宽度
 *
 *  @return 带圆环的圆角图片
 */
+ (UIImage *)js_imageWithOriginalImage:(UIImage *)originalImage withBorderColor:(UIColor *)borderColor withBorderWidth:(CGFloat)borderWidth;


/**
 创建任意圆角纯色图片

 @param color 生成图片颜色
 @param imageSize 生成图片大小
 @param cornerRadius 圆角大小
 @return 生成的图片
 */
+ (UIImage *)js_createRoundedImageWithColor:(UIColor *)color withSize:(CGSize)imageSize cornerRadius:(CGFloat)cornerRadius;


/**
 压缩图片

 @param sourceImage 原始图片
 @return 压缩后的图片
 */
+ (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage;

@end
