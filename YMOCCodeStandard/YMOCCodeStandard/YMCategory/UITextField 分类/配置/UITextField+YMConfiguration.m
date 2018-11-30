//
//  UITextField+YMConfiguration.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/30.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "UITextField+YMConfiguration.h"

@implementation UITextField (YMConfiguration)

#pragma mark - - leftView
+ (void)ym_textField:(UITextField *)textField leftView:(UIView *)leftView {
    textField.leftView = leftView;
    textField.leftViewMode = UITextFieldViewModeAlways;
}

#pragma mark rightView
+ (void)ym_textField:(UITextField *)textField rightView:(UIView *)rightView {
    textField.leftView = rightView;
    textField.rightViewMode = UITextFieldViewModeAlways;
}

#pragma mark - - 占位文字颜色大小
+ (void)ym_textField:(UITextField *)textFiled placeHolder:(NSString *)placeHolder placeHolderColor:(UIColor *)placeHolderColor fontSize:(CGFloat)fontSize {
    textFiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeHolder attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:fontSize], NSForegroundColorAttributeName : placeHolderColor}];
}

@end
