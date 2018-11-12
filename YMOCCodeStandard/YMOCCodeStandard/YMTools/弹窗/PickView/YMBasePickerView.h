//
//  YMBasePickerView.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/12.
//  Copyright © 2018 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** 协议方法 */
@protocol YMBasePickerViewDelegate <NSObject>

@optional;
- (void)actionWithButton:(UIButton *)sender;

@end

@interface YMBasePickerView : UIView

/** 代理 */
@property (nonatomic, weak) id<YMBasePickerViewDelegate> delegate;

/**
 析构函数

 @param frame frame
 @param delegate 代理
 @param title 标题
 @param leftBtnTitle 左侧按钮文字
 @param rightBtnTitle 右侧按钮文字
 @return self
 */
- (instancetype)initWithFrame:(CGRect)frame delegate:(id<YMBasePickerViewDelegate>)delegate title:(NSString *)title leftBtnTitle:(NSString *)leftBtnTitle rightBtnTitle:(NSString *)rightBtnTitle;

/**
 显示
 */
- (void)show;
@end

NS_ASSUME_NONNULL_END
