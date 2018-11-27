//
//  UIButton+YMConfiguration.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/27.
//  Copyright © 2018 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (YMConfiguration)

/**
 设置按钮文字颜色大小

 @param button 要设置的按钮
 @param title 文字
 @param fontSize 大小
 @param color 颜色
 */
+ (void)ym_button:(UIButton *)button title:(NSString *)title fontSize:(CGFloat)fontSize titleColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
