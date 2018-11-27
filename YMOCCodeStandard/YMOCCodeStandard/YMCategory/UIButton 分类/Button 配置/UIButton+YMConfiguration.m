//
//  UIButton+YMConfiguration.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/27.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "UIButton+YMConfiguration.h"

@implementation UIButton (YMConfiguration)

#pragma mark - - 设置按钮文字 颜色 大小
+ (void)ym_button:(UIButton *)button title:(NSString *)title fontSize:(CGFloat)fontSize titleColor:(UIColor *)color {
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
}

@end
