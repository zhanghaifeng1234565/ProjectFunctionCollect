//
//  UIView+YMConfiguration.m
//  YMOAManageSystem
//
//  Created by iOS on 2018/11/20.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "UIView+YMConfiguration.h"

@implementation UIView (YMConfiguration)

#pragma mark - - 配置背景和圆角
+ (void)ym_view:(UIView *)view backgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)cornerRadius {
    view.backgroundColor = backgroundColor;
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = cornerRadius;
}

#pragma mark - - 配置背景颜色圆角，边线颜色宽度
+ (void)ym_view:(UIView *)view backgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    view.backgroundColor = backgroundColor;
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = cornerRadius;
    view.layer.borderWidth = borderWidth;
    view.layer.borderColor = borderColor.CGColor;
}

@end
