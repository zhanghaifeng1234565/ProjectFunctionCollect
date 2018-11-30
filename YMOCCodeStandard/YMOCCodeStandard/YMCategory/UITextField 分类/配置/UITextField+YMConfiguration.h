//
//  UITextField+YMConfiguration.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/30.
//  Copyright © 2018 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (YMConfiguration)

/**
 leftView

 @param textField textField description
 @param leftView leftView description
 */
+ (void)ym_textField:(UITextField *)textField leftView:(UIView *)leftView;


/**
 rightView

 @param textField textField description
 @param rightView rightView description
 */
+ (void)ym_textField:(UITextField *)textField rightView:(UIView *)rightView;


/**
 占位文字颜色大小

 @param textFiled textFiled description
 @param placeHolder placeHolder description
 @param placeHolderColor placeHolderColor description
 @param fontSize fontSize description
 */
+ (void)ym_textField:(UITextField *)textFiled placeHolder:(NSString *)placeHolder placeHolderColor:(UIColor *)placeHolderColor fontSize:(CGFloat)fontSize;

@end

NS_ASSUME_NONNULL_END
