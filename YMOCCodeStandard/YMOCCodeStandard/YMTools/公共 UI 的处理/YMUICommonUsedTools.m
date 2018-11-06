//
//  YMUICommonUsedTools.m
//  YMUICommonlyUsedTools
//
//  Created by iOS on 2018/5/7.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMUICommonUsedTools.h"
#import "YMUIPlaceholderTextView.h"

@implementation YMUICommonUsedTools

#pragma mark -- 公共方法
#pragma mark -- 配置 视图 的属性【背景颜色】【圆角大小】【边线颜色】
+ (void)configPropertyWithView:(UIView *)view backgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    view.backgroundColor = backgroundColor;
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = cornerRadius;
    view.layer.borderWidth = borderWidth;
    view.layer.borderColor = borderColor.CGColor;
}

#pragma mark -- 配置 视图 的属性【背景颜色】【边线颜色】
+ (void)configPropertyWithView:(UIView *)view backgroundColor:(UIColor *)backgroundColor borderColor:(UIColor *)borderColor {
    view.backgroundColor = backgroundColor;
    view.layer.borderColor = borderColor.CGColor;
}

#pragma mark -- 配置任意圆角的方法
+ (void)configArbitraryCornerRadiusView:(UIView *)view cornerRadius:(CGFloat)cornerRadius withType:(ArbitraryCornerRadiusViewType)type {
    UIBezierPath *maskPath = [[UIBezierPath alloc] init];
    switch (type) {
        case ArbitraryCornerRadiusViewTypeDefault:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds            byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        }
            break;
        case ArbitraryCornerRadiusViewTypeTopLeft:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds            byRoundingCorners:UIRectCornerTopLeft cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        }
            break;
        case ArbitraryCornerRadiusViewTypeTopRight:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds            byRoundingCorners:UIRectCornerTopRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        }
            break;
        case ArbitraryCornerRadiusViewTypeBottomLeft:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds            byRoundingCorners:UIRectCornerBottomLeft cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        }
            break;
        case ArbitraryCornerRadiusViewTypeBottomRight:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds            byRoundingCorners:UIRectCornerBottomRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        }
            break;
        case ArbitraryCornerRadiusViewTypeTopLeftTopRight:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds            byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        }
            break;
        case ArbitraryCornerRadiusViewTypeTopLeftBottomLeft:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds            byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        }
            break;
        case ArbitraryCornerRadiusViewTypeTopLeftBottomRight:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds            byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        }
            break;
        case ArbitraryCornerRadiusViewTypeTopRightBottomLeft:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds            byRoundingCorners:UIRectCornerTopRight|UIRectCornerBottomLeft cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        }
            break;
        case ArbitraryCornerRadiusViewTypeTopRightBottomRight:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds            byRoundingCorners:UIRectCornerTopRight|UIRectCornerBottomRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        }
            break;
        case ArbitraryCornerRadiusViewTypeBottomLeftBottomRight:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds            byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        }
            break;
        case ArbitraryCornerRadiusViewTypeTopLeftTopRightBottomLeft:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds            byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        }
            break;
        case ArbitraryCornerRadiusViewTypeTopLeftTopRightBottomRight:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds            byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        }
            break;
        case ArbitraryCornerRadiusViewTypeTopLeftBottomLeftBottomRight:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds            byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        }
            break;
        case ArbitraryCornerRadiusViewTypeTopRightBottomLeftBottomRight:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds            byRoundingCorners:UIRectCornerTopRight|UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        }
            break;
        default:
            break;
    }
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

#pragma mark -- label 相关
#pragma mark -- 配置 label 的属性【字体】【颜色】【对齐方式】【显示行数】
+ (void)configPropertyWithLabel:(UILabel *)label font:(CGFloat)font textColor:(UIColor *)color textAlignment:(NSTextAlignment)textAlignment numberOfLine:(CGFloat)numberOfLine {
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = color;
    label.textAlignment = textAlignment;
    label.numberOfLines = numberOfLine;
}

#pragma mark -- 配置 label 的属性【行间距】【要显示的最大宽度】
+ (void)configPropertyWithLabel:(UILabel *)label font:(CGFloat)font lineSpace:(CGFloat)lineSpace maxWidth:(CGFloat)maxWidth lineBreakMode:(NSLineBreakMode)lineBreakMode {
    // NSKernAttributeName:@1.5f 字间距
    // NSKernAttributeName:@1.5f
    // CGFloat textDefaultMarginHeiht = (label.font.lineHeight-label.font.pointSize); 当前字体下文本的默认间距
    CGFloat textDefaultMarginHeiht = (label.font.lineHeight-label.font.pointSize);
    lineSpace = lineSpace-textDefaultMarginHeiht;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:label.text];
    CGSize size = [label.text boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = lineBreakMode;
    paraStyle.lineSpacing = size.height+1>font*2 ? lineSpace:0;
    NSRange range = NSMakeRange(0, [label.text length]);
    [attributedString addAttribute:NSBaselineOffsetAttributeName value:NSBaselineOffsetAttributeName range:range];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paraStyle range:range];
    label.attributedText = attributedString;
}

#pragma mark -- 配置 label 的属性【行间距】【要显示的最大宽度】【要变色的范围】
+ (void)configPropertyWithLabel:(UILabel *)label
                           font:(CGFloat)font
                      lineSpace:(CGFloat)lineSpace
                       maxWidth:(CGFloat)maxWidth
                  lineBreakMode:(NSLineBreakMode)lineBreakMode
                       rangStr1:(NSString *)rangStr1
                       rangStr2:(NSString *)rangStr2 {
    CGFloat textDefaultMarginHeiht = (label.font.lineHeight-label.font.pointSize);
    lineSpace = lineSpace-textDefaultMarginHeiht;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:label.text];
    CGSize size = [label.text boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = lineBreakMode;
    paraStyle.lineSpacing = size.height+1>font*2 ? lineSpace:0;
    NSRange range = NSMakeRange(0, [label.text length]);
    [attributedString addAttribute:NSBaselineOffsetAttributeName value:NSBaselineOffsetAttributeName range:range];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paraStyle range:range];
    
    [attributedString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"507daf"]} range:NSMakeRange(0, rangStr1.length)];
    [attributedString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"507daf"]} range:NSMakeRange(rangStr1.length+2, rangStr2.length)];
    label.attributedText = attributedString;
}

#pragma mark -- 配置 label 的属性【行间距】【要显示的最大宽度】【要变色的范围【带有时间的图片】
+ (void)configPropertyWithLabel:(UILabel *)label
                           font:(CGFloat)font
                      lineSpace:(CGFloat)lineSpace
                       maxWidth:(CGFloat)maxWidth
                  lineBreakMode:(NSLineBreakMode)lineBreakMode
                       rangStr1:(NSString *)rangStr1
                       rangStr2:(NSString *)rangStr2
                        timeStr:(NSString *)timeStr {
    NSString *marginStr = [NSString stringWithFormat:@"    "];
    label.text = [label.text stringByAppendingString:marginStr];
    CGFloat textDefaultMarginHeiht = (label.font.lineHeight-label.font.pointSize);
    lineSpace = lineSpace-textDefaultMarginHeiht;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:label.text];
    CGSize size = [label.text boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = lineBreakMode;
    paraStyle.lineSpacing = size.height+1>font*2 ? lineSpace:0;
    NSRange range = NSMakeRange(0, [label.text length]);
    [attributedString addAttribute:NSBaselineOffsetAttributeName value:NSBaselineOffsetAttributeName range:range];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paraStyle range:range];
    
    // 要处理的字符串
    [attributedString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"507daf"]} range:NSMakeRange(0, rangStr1.length)];
    [attributedString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"507daf"]} range:NSMakeRange(rangStr1.length+2, rangStr2.length)];
    
    NSMutableAttributedString *mutableAttr = [[NSMutableAttributedString alloc] init];
    CGFloat timeStrWidth = [timeStr sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}].width+1;
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.bounds = CGRectMake(0, -4, timeStrWidth, 17);
    attachment.image = [self createShareImage:[UIImage js_createImageWithColor:[UIColor clearColor] withSize:CGSizeMake(timeStrWidth, 17)] Context:timeStr textFont:12 textColor:[UIColor  colorWithHexString:@"a8aab7"]];

    // 通过NSTextAttachment创建富文本
    // 图片的富文本
    NSAttributedString *imageAttr = [NSAttributedString attributedStringWithAttachment:attachment];
    
    [mutableAttr appendAttributedString:attributedString];
    [mutableAttr appendAttributedString:imageAttr];
    label.attributedText = mutableAttr;
}

#pragma mark -- 生成一张带文字的图片
+ (UIImage *)createShareImage:(UIImage *)sourceImage
                      Context:(NSString *)text
                     textFont:(CGFloat)nameFont
                    textColor:(UIColor *)color {
    CGSize imageSize; //画的背景 大小
    imageSize = [sourceImage size];
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    [sourceImage drawAtPoint:CGPointMake(0, 0)];
    //获得 图形上下文
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextDrawPath(context, kCGPathStroke);
    //画 自己想要画的内容
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:nameFont]};
    CGRect sizeToFit = [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, nameFont) options:NSStringDrawingUsesDeviceMetrics attributes:attributes context:nil];
    NSLog(@"图片: %f %f",imageSize.width,imageSize.height);
    NSLog(@"sizeToFit: %f %f",sizeToFit.size.width,sizeToFit.size.height);
    CGContextSetFillColorWithColor(context, color.CGColor);
    [text drawAtPoint:CGPointMake(0,2.5) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:nameFont], NSForegroundColorAttributeName:color}];
    //返回绘制的新图形
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark -- 计算带有行间距的 label 的高度
+ (CGFloat)getHeightWithLabel:(UILabel *)label
                         font:(CGFloat)font lineSpace:
(CGFloat)lineSpace maxWidth:(CGFloat)maxWidth
                lineBreakMode:(NSLineBreakMode)lineBreakMode {
    // NSKernAttributeName:@1.5f
    // CGFloat textDefaultMarginHeiht = (label.font.lineHeight-label.font.pointSize); 当前字体下文本的默认间距
    CGFloat textDefaultMarginHeiht = (label.font.lineHeight-label.font.pointSize);
    lineSpace = lineSpace-textDefaultMarginHeiht;
    CGFloat labelHeight = 0.0f;
    CGSize originSize = [label.text boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = lineBreakMode;
    paraStyle.lineSpacing = originSize.height+1>font*2 ? lineSpace:0;
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:font],
                          NSParagraphStyleAttributeName:paraStyle
                          ,NSBaselineOffsetAttributeName:NSBaselineOffsetAttributeName};
    CGSize size = [label.text boundingRectWithSize:CGSizeMake(maxWidth,MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine |
                   NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    labelHeight = size.height+1;
    return labelHeight;
}

#pragma mark -- 计算带有行间距的 字符串 的高度
+ (CGFloat)getHeightWithStr:(NSString *)str
               withFontSize:(CGFloat)fontSize
                  lineSpace:(CGFloat)lineSpace
                   maxWidth:(CGFloat)maxWidth {
    // NSKernAttributeName:@1.5f
    // CGFloat textDefaultMarginHeiht = (label.font.lineHeight-label.font.pointSize); 当前字体下文本的默认间距
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    CGFloat textDefaultMarginHeiht = (font.lineHeight-font.pointSize);
    lineSpace = lineSpace-textDefaultMarginHeiht;
    CGFloat labelHeight = 0.0f;
    CGSize originSize = [str boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = originSize.height+1>fontSize*2 ? lineSpace:0;
    NSDictionary *dic = @{NSFontAttributeName:font,
                          NSParagraphStyleAttributeName:paraStyle
                          ,NSBaselineOffsetAttributeName:NSBaselineOffsetAttributeName};
    CGSize size = [str boundingRectWithSize:CGSizeMake(maxWidth,MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine |
                   NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    labelHeight = size.height+1;
    return labelHeight;
}

#pragma mark -- 计算文字单行显示的宽度
+ (CGFloat)getWidthWithLabel:(UILabel *)label font:(CGFloat)font {
    // 当文字单行显示的时候 label 的高度
    CGSize size = [label.text boundingRectWithSize:CGSizeMake(MAXFLOAT, font) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    return size.width+1;
}

#pragma mark -- button 相关
#pragma mark -- 配置按钮的 【显示文字】 【字体颜色】 【字体大小】
+ (void)configPropertyWithButton:(UIButton *)button title:(NSString *)title titleColor:(UIColor *)titleColor titleLabelFont:(CGFloat)font {
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:font];
}

#pragma mark -- 配置按钮的 【显示文字】 【字体颜色】
+ (void)configPropertyWithButton:(UIButton *)button title:(NSString *)title titleColor:(UIColor *)titleColor {
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
}

#pragma mark -- 配置按钮的背景图片
+ (void)configPropertyWithButton:(UIButton *)button
           normalBackgroundImage:(NSString *)normalBackgroundImage
        highlightBackgroundImage:(NSString *)highlightBackgroundImage {
    [button setBackgroundImage:[UIImage imageNamed:normalBackgroundImage] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highlightBackgroundImage] forState:UIControlStateHighlighted];
}

#pragma mark -- textField 相关
+ (void)configPropertyWithTextField:(UITextField *)textField
                           textFont:(CGFloat)textFont
                          textColor:(UIColor *)textColor
                    textPlaceHolder:(NSString *)placeHolder
                textPlaceHolderFont:(CGFloat)textPlaceHolderFont
           textPlaceHolderTextColor:(UIColor *)textPlaceHolderTextColor
                      textAlignment:(NSTextAlignment)textAlignment {
    textField.font = [UIFont systemFontOfSize:textFont];
    textField.textColor = textColor;
    textField.attributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:placeHolder attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:textPlaceHolderFont],NSForegroundColorAttributeName:textPlaceHolderTextColor}];
    textField.textAlignment = textAlignment;
}

#pragma mark -- textView 相关
+ (void)configPropertyWithTextView:(YMUIPlaceholderTextView *)textView
                          textFont:(CGFloat)textFont
                         textColor:(UIColor *)textColor
                         lineSpace:(CGFloat)lineSpace
                   textPlaceHolder:(NSString *)placeHolder
               textPlaceHolderFont:(CGFloat)textPlaceHolderFont
          textPlaceHolderTextColor:(UIColor *)textPlaceHolderTextColor
                     textAlignment:(NSTextAlignment)textAlignment {
    textView.font = [UIFont systemFontOfSize:textFont];
    textView.textColor = textColor;
    textView.textAlignment = textAlignment;
    textView.placeholder = placeHolder;
    textView.placeholderColor = textPlaceHolderTextColor;
    textView.placeholderFont = textPlaceHolderFont;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpace;
    textView.typingAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:textFont],NSParagraphStyleAttributeName:paragraphStyle};
}

#pragma mark -- 实现图文混排
+ (NSAttributedString *)creatAttrStringWithText:(NSString *)text image:(UIImage *)image isHaveImage:(BOOL)isHaveImage {
    // 文字的富文本
    NSAttributedString *textAttr = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15], NSForegroundColorAttributeName:[UIColor colorWithHexString:@"35465f"]}];
    NSMutableAttributedString *mutableAttr = [[NSMutableAttributedString alloc] init];
    // 将图片、文字拼接
    // 如果要求图片在文字的后面只需要交换下面两句的顺序
    [mutableAttr appendAttributedString:textAttr];
    if (isHaveImage == YES) {
        // NSTextAttachment可以将图片转换为富文本内容
        NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
        attachment.image = image;
        attachment.bounds = CGRectMake(0, -2, 15, 15);
        
        // NSTextAttachment可以将图片转换为富文本内容
        NSTextAttachment *tempAttachment = [[NSTextAttachment alloc] init];
        tempAttachment.image = [UIImage imageWithColor:[UIColor clearColor]];
        tempAttachment.bounds = CGRectMake(0, 0.5, 6, 15);
        // 通过NSTextAttachment创建富文本
        // 图片的富文本
        NSAttributedString *imageAttr = [NSAttributedString attributedStringWithAttachment:attachment];
        NSAttributedString *tempImageAttr = [NSAttributedString attributedStringWithAttachment:tempAttachment];
        
        [mutableAttr appendAttributedString:tempImageAttr];
        [mutableAttr appendAttributedString:imageAttr];
    }
    return [mutableAttr copy];
}

#pragma mark -- 视图虚线边框
+ (void)drawDottedLineWithView:(UIView *)view {
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 6.0f;
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.bounds = CGRectMake(0, 0, view.width, view.height);
    borderLayer.position = CGPointMake(CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds));
    
    borderLayer.path = [UIBezierPath bezierPathWithRoundedRect:borderLayer.bounds cornerRadius:6.0f].CGPath;
    borderLayer.lineWidth = 0.5;
    //虚线边框
    borderLayer.lineDashPattern = @[@6, @6];
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.strokeColor = [UIColor colorWithHexString:@"dfe1e4"].CGColor;
    [view.layer addSublayer:borderLayer];
}
@end
