//
//  YMBasePickerView.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/12.
//  Copyright © 2018 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** 内容视图高度 */
static CGFloat kContentViewHeight = 300;
/** 工具栏高度 */
static CGFloat kToolBarViewHeight = 48;

/** 协议方法 */
@protocol YMBasePickerViewDelegate <NSObject>

@optional;
/** 按钮点击代理方法 */
- (void)actionWithButton:(UIButton *)sender;

@end

@interface YMBasePickerView : UIView

/** 代理 */
@property (nonatomic, weak) id<YMBasePickerViewDelegate> delegate;

/** 内容视图 */
@property (nonatomic, strong, readonly) UIView *contentView;

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
 加载视图
 */
- (void)loadSubviews;


/**
 配置属性
 */
- (void)configProprty;


/**
 显示
 */
- (void)show;
@end

NS_ASSUME_NONNULL_END
