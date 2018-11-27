//
//  UILabel+YMConfiguration.h
//  YMOAManageSystem
//
//  Created by iOS on 2018/11/20.
//  Copyright © 2018 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (YMConfiguration)


/**
 配置 label 的大小 颜色

 @param label 配置 label
 @param fontSize 大小
 @param textColor 颜色
 */
+ (void)ym_label:(UILabel *)label fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor;


/**
 配置 label 的行间距

 @param label 配置的 label
 @param lineSpace  行间距
 @param maxWidth 要展示的最大宽度
 @param alignment 对齐方式
 */
+ (void)ym_label:(UILabel *)label lineSpace:(CGFloat)lineSpace maxWidth:(CGFloat)maxWidth  alignment:(NSTextAlignment)alignment;


/**
 或去带有行间距 string 的高度

 @param string 要获取的字符串
 @param fontSize 字体大小
 @param lineSpace 行间距
 @param maxWidth 最大宽度
 @return 高度
 */
+ (CGFloat)ym_getHeightWithString:(NSString *)string fontSize:(CGFloat)fontSize lineSpace:(CGFloat)lineSpace maxWidth:(CGFloat)maxWidth;

@end

NS_ASSUME_NONNULL_END
