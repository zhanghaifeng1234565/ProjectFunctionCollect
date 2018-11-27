//
//  UIView+YMConfiguration.h
//  YMOAManageSystem
//
//  Created by iOS on 2018/11/20.
//  Copyright © 2018 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (YMConfiguration)

/**
 配置背景和圆角

 @param view 要配置的视图
 @param backgroundColor 背景颜色
 @param cornerRadius 圆角大小
 */
+ (void)ym_view:(UIView *)view backgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)cornerRadius;


/**
 配置背景颜色圆角，边线颜色宽度

 @param view 要配置的视图
 @param backgroundColor 背景颜色
 @param cornerRadius 圆角大小
 @param borderWidth 边线宽度
 @param borderColor 边线颜色
 */
+ (void)ym_view:(UIView *)view backgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

@end

NS_ASSUME_NONNULL_END
