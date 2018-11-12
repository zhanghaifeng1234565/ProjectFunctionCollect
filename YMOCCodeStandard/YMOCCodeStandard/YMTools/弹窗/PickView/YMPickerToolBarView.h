//
//  YMPickerToolBarView.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/12.
//  Copyright © 2018 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YMPickerToolBarView : UIView

/** 左侧按钮点击调用 */
@property (nonatomic, copy) void(^leftBtnClickBlock)(UIButton *sender);
/** 右侧按钮点击调用 */
@property (nonatomic, copy) void(^rightBtnClickBlcok)(UIButton *sender);

/** 标题标签 */
@property (nonatomic, strong) UILabel *titleLabel;
/** 左侧按钮 */
@property (nonatomic, strong) UIButton *leftBtn;
/** 右侧按钮 */
@property (nonatomic, strong) UIButton *rightBtn;

@end

NS_ASSUME_NONNULL_END
