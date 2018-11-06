//
//  YMUIPlaceholderTextView.h
//  YMUICommonlyUsedTools
//
//  Created by iOS on 2018/5/7.
//  Copyright © 2018年 iOS. All rights reserved.
//
/*
 使用
 self.textView = [[PHTextView alloc] initWithFrame:CGRectMake(15, 100, [UIScreen mainScreen].bounds.size.width-30, 100)];
 self.textView.placeholderColor = [UIColor grayColor];
 self.textView.placeholderFont = 15;
 self.textView.placeholder = @"我是打酱油的";
 [self.view addSubview:self.textView];
 NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
 paragraphStyle.lineSpacing = 10;
 self.textView.typingAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15],NSParagraphStyleAttributeName:paragraphStyle};
 self.textView.layer.borderWidth = 0.5;
 self.textView.layer.borderColor = [UIColor redColor].CGColor;
 
 */
#import <UIKit/UIKit.h>

/** 带有占位文字的 textView */
@interface YMUIPlaceholderTextView : UITextView

/** 占位文字 */
@property (nonatomic, copy) NSString *placeholder;
/** 占位文字颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;
/** 占位文字大小 */
@property (nonatomic, assign) CGFloat placeholderFont;

@end
