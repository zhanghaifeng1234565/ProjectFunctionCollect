//
//  UILabel+YMConfiguration.m
//  YMOAManageSystem
//
//  Created by iOS on 2018/11/20.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "UILabel+YMConfiguration.h"

@implementation UILabel (YMConfiguration)

#pragma mark - - 配置 label 字体大小 颜色
+ (void)ym_label:(UILabel *)label fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor {
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = textColor;
    label.textAlignment = NSTextAlignmentLeft;
    label.numberOfLines = 0;
}

#pragma mark - - 配置 label 行间距
+ (void)ym_label:(UILabel *)label lineSpace:(CGFloat)lineSpace maxWidth:(CGFloat)maxWidth {
    CGFloat textDefaultMarginHeiht = (label.font.lineHeight - label.font.pointSize);
    lineSpace = lineSpace - textDefaultMarginHeiht;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:label.text];
    CGSize size = [label.text boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : label.font} context:nil].size;
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = label.lineBreakMode;
    paraStyle.lineSpacing = size.height + 1 > label.font.pointSize * 2 ? lineSpace : 0;
    
    NSRange range = NSMakeRange(0, [label.text length]);
    [attributedString addAttribute:NSBaselineOffsetAttributeName value:NSBaselineOffsetAttributeName range:range];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paraStyle range:range];
    
    label.attributedText = attributedString;
}

#pragma mark - - 获取字符串高度
+ (CGFloat)ym_getHeightWithString:(NSString *)string fontSize:(CGFloat)fontSize lineSpace:(CGFloat)lineSpace maxWidth:(CGFloat)maxWidth {
    
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    CGFloat textDefaultMarginHeiht = (font.lineHeight - font.pointSize);
    lineSpace = lineSpace - textDefaultMarginHeiht;
    
    CGFloat stringHeight = 0.0f;
    CGSize originSize = [string boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = originSize.height + 1 > fontSize * 2 ? lineSpace : 0;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName : paraStyle, NSBaselineOffsetAttributeName : NSBaselineOffsetAttributeName};
    
    CGSize size = [string boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine |
                   NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    stringHeight = size.height + 1;
    
    return stringHeight;
}

@end
