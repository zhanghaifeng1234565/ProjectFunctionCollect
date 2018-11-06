//
//  YMUITextField.h
//  YMUICommonlyUsedTools
//
//  Created by iOS on 2018/5/11.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YMUITextField;

@protocol YMUITextFieldDelegate <NSObject>

@optional
- (void)ymTextFieldDeleteBackward:(YMUITextField *)textField;

@end

@interface YMUITextField : UITextField

@property (nonatomic, assign) id <YMUITextFieldDelegate> ym_delegate;

@end
