//
//  YMUICommonUsedTools.h
//  YMUICommonlyUsedTools
//
//  Created by iOS on 2018/5/7.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YMUIPlaceholderTextView;

typedef NS_ENUM(NSInteger, ArbitraryCornerRadiusViewType) {
    /** 默认全角 */
    ArbitraryCornerRadiusViewTypeDefault = 0,
    /** 左上角 */
    ArbitraryCornerRadiusViewTypeTopLeft = 1,
    /** 右上角 */
    ArbitraryCornerRadiusViewTypeTopRight = 2,
    /** 左下角 */
    ArbitraryCornerRadiusViewTypeBottomLeft = 3,
    /** 右下角 */
    ArbitraryCornerRadiusViewTypeBottomRight = 4,
    /** 左上角和右上角 */
    ArbitraryCornerRadiusViewTypeTopLeftTopRight = 5,
    /** 左上角和左下角 */
    ArbitraryCornerRadiusViewTypeTopLeftBottomLeft = 6,
    /** 左上角和右下角 */
    ArbitraryCornerRadiusViewTypeTopLeftBottomRight = 7,
    /** 右上角和左下角 */
    ArbitraryCornerRadiusViewTypeTopRightBottomLeft = 8,
    /** 右上角和右下角 */
    ArbitraryCornerRadiusViewTypeTopRightBottomRight = 9,
    /** 左下角和右下角 */
    ArbitraryCornerRadiusViewTypeBottomLeftBottomRight = 10,
    /** 左上角和右上角和左下角 */
    ArbitraryCornerRadiusViewTypeTopLeftTopRightBottomLeft = 11,
    /** 左上角和右上角和右下角 */
    ArbitraryCornerRadiusViewTypeTopLeftTopRightBottomRight = 12,
    /** 左上角和左下角和右下角 */
    ArbitraryCornerRadiusViewTypeTopLeftBottomLeftBottomRight = 13,
    /** 右上角和左下角和右下角 */
    ArbitraryCornerRadiusViewTypeTopRightBottomLeftBottomRight = 14,
};

@interface YMUICommonUsedTools : NSObject

/**********************  公共方法  *************************/
/**
 配置 label 的圆角颜色
 
 @param view 要配置的 view
 @param backgroundColor  背景颜色
 @param cornerRadius 圆角大小
 @param borderWidth 边框宽度
 @param borderColor 边框颜色
 */
+ (void)configPropertyWithView:(UIView *)view
               backgroundColor:(UIColor *)backgroundColor
                  cornerRadius:(CGFloat)cornerRadius
                   borderWidth:(CGFloat)borderWidth
                   borderColor:(UIColor *)borderColor;

/**
 配置视图边框背景

 @param view 要配置的视图
 @param backgroundColor 背景颜色
 @param borderColor 边框颜色
 */
+ (void)configPropertyWithView:(UIView *)view
               backgroundColor:(UIColor *)backgroundColor
                   borderColor:(UIColor *)borderColor;

/**
 视图切任意方向圆角

 @param view 要切圆角的视图
 @param cornerRadius 圆角大小
 @param type 圆角类型
 */
+ (void)configArbitraryCornerRadiusView:(UIView *)view
                           cornerRadius:(CGFloat)cornerRadius
                               withType:(ArbitraryCornerRadiusViewType)type;

/**********************  label 相关  *************************/
/**
 配置 label 的属性

 @param label 要配置的 label
 @param font  字体大小
 @param color 字体颜色
 @param textAlignment 文字对齐方式
 */
+ (void)configPropertyWithLabel:(UILabel *)label
                           font:(CGFloat)font
                      textColor:(UIColor *)color
                  textAlignment:(NSTextAlignment)textAlignment
                   numberOfLine:(CGFloat)numberOfLine;

/**
 配置 label 的行间距

 @param label 要配置的 label
 @param font 要配置的 label 的字体大小
 @param lineSpace  行间距
 @param lineBreakMode 文本截断方式
 @param maxWidth 要展示的最大宽度
 */
+ (void)configPropertyWithLabel:(UILabel *)label
                           font:(CGFloat)font
                      lineSpace:(CGFloat)lineSpace
                       maxWidth:(CGFloat)maxWidth
                  lineBreakMode:(NSLineBreakMode)lineBreakMode;

/**
 配置 label 的行间距

 @param label 要配置的 label
 @param font 要配置的 label 的字体大小
 @param lineSpace 行间距
 @param maxWidth 要展示的最大宽度
 @param lineBreakMode 文本截断方式
 @param rangStr1 要变色的字符串 1
 @param rangStr2 要变色的字符串 2
 */
+ (void)configPropertyWithLabel:(UILabel *)label
                           font:(CGFloat)font
                      lineSpace:(CGFloat)lineSpace
                       maxWidth:(CGFloat)maxWidth
                  lineBreakMode:(NSLineBreakMode)lineBreakMode
                       rangStr1:(NSString *)rangStr1
                       rangStr2:(NSString *)rangStr2;

/**
 配置 label 的行间距
 
 @param label 要配置的 label
 @param font 要配置的 label 的字体大小
 @param lineSpace 行间距
 @param maxWidth 要展示的最大宽度
 @param lineBreakMode 文本截断方式
 @param rangStr1 要变色的字符串 1
 @param rangStr2 要变色的字符串 2
 @param timeStr 要拼接的字体图片
 */
+ (void)configPropertyWithLabel:(UILabel *)label
                           font:(CGFloat)font
                      lineSpace:(CGFloat)lineSpace
                       maxWidth:(CGFloat)maxWidth
                  lineBreakMode:(NSLineBreakMode)lineBreakMode
                       rangStr1:(NSString *)rangStr1
                       rangStr2:(NSString *)rangStr2
                        timeStr:(NSString *)timeStr;


/**
 生成一张带文字的图片

 @param sourceImage 原始图片
 @param text 文字
 @param nameFont 文字大小
 @param color 字体颜色
 @return 带文字的图片
 */
+ (UIImage *)createShareImage:(UIImage *)sourceImage
                      Context:(NSString *)text
                     textFont:(CGFloat)nameFont
                    textColor:(UIColor *)color;

/**
 设置行间距的前提下的 label 高度

 @param label 要获取的 label
 @param font  字体大小
 @param lineSpace 行间距
 @param maxWidth 最大显示宽度
 @param lineBreakMode 文本截断方式
 @return 要展示的 label 的高度
 */
+ (CGFloat)getHeightWithLabel:(UILabel *)label
                         font:(CGFloat)font
                    lineSpace:(CGFloat)lineSpace
                     maxWidth:(CGFloat)maxWidth
                lineBreakMode:(NSLineBreakMode)lineBreakMode;

/**
 获取字符串的高度

 @param str 要计算的字符串
 @param fontSize 字体大小
 @param lineSpace 行间距
 @param maxWidth 最大宽度
 @return 字符串高度
 */
+ (CGFloat)getHeightWithStr:(NSString *)str
               withFontSize:(CGFloat)fontSize
                  lineSpace:(CGFloat)lineSpace
                   maxWidth:(CGFloat)maxWidth;

/**
 获取 label 单行显示的时候需要的宽度

 @param label 要获取的 label
 @param font  字体大小
 @return 宽度
 */
+ (CGFloat)getWidthWithLabel:(UILabel *)label
                        font:(CGFloat)font;

/**********************  button 相关  *************************/
/**
 配置按钮的文字

 @param button 要配置的按钮
 @param title 按钮显示的文字
 @param titleColor 文字的颜色
 @param font 文字的大小
 */
+ (void)configPropertyWithButton:(UIButton *)button
                           title:(NSString *)title
                      titleColor:(UIColor *)titleColor
                  titleLabelFont:(CGFloat)font;

/**
 配置按钮标题和颜色

 @param button 要配置的按钮
 @param title 按钮的标题
 @param titleColor 按钮的颜色
 */
+ (void)configPropertyWithButton:(UIButton *)button
                           title:(NSString *)title
                      titleColor:(UIColor *)titleColor;

/**
 配置按钮背景图片

 @param button 要配置的按钮
 @param normalBackgroundImage 普通状态下的按钮背景图片
 @param highlightBackgroundImage 高亮状态下的按钮图片
 */
+ (void)configPropertyWithButton:(UIButton *)button
           normalBackgroundImage:(NSString *)normalBackgroundImage
        highlightBackgroundImage:(NSString *)highlightBackgroundImage;

/**********************  textField 相关  *************************/
/**
 配置 textField 输入框

 @param textField 要配置的 textField
 @param textFont 字体大小
 @param textColor 字体颜色
 @param placeHolder 占位文字
 @param textPlaceHolderFont 占位文字大小
 @param textPlaceHolderTextColor 占位文字颜色
 @param textAlignment 字体对齐方式
 */
+ (void)configPropertyWithTextField:(UITextField *)textField
                           textFont:(CGFloat)textFont
                          textColor:(UIColor *)textColor
                    textPlaceHolder:(NSString *)placeHolder
                textPlaceHolderFont:(CGFloat)textPlaceHolderFont
           textPlaceHolderTextColor:(UIColor *)textPlaceHolderTextColor
                      textAlignment:(NSTextAlignment)textAlignment;

/**
 配置带有占位文字包含字体间距的 textView

 @param textView  要配置的 textView
 @param textFont textView 字体大小
 @param textColor textView 字体颜色
 @param lineSpace textView 行间距
 @param placeHolder textView 占位文字
 @param textPlaceHolderFont textView 占位文字大小
 @param textPlaceHolderTextColor textView 占位文字颜色
 @param textAlignment 文字对齐方式
 */
+ (void)configPropertyWithTextView:(YMUIPlaceholderTextView *)textView
                          textFont:(CGFloat)textFont
                         textColor:(UIColor *)textColor
                         lineSpace:(CGFloat)lineSpace
                   textPlaceHolder:(NSString *)placeHolder
               textPlaceHolderFont:(CGFloat)textPlaceHolderFont
          textPlaceHolderTextColor:(UIColor *)textPlaceHolderTextColor
                     textAlignment:(NSTextAlignment)textAlignment;

/**
 首页广播实现图文混排

 @param text 文字
 @param image 图片
 @param isHaveImage 是否有图
 @return 富文本对象
 */
+ (NSAttributedString *)creatAttrStringWithText:(NSString *)text
                                          image:(UIImage *)image
                                    isHaveImage:(BOOL)isHaveImage;


/**
 视图虚线边框

 @param view 要设虚线的视图
 */
+ (void)drawDottedLineWithView:(UIView *)view;
@end
