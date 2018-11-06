//
//  YMSureCancelAlert.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/10/23.
//  Copyright © 2018年 iOS. All rights reserved.
//

/*
 [[SureCanceAlert shareAlert] setTitleText:@"确定删除此消息？" withMaxHeight:100 withSureBtnClick:^(UIButton *sender) {
 NSLog(@"确定啦");
 } withCancelBtnClick:^(UIButton *sender) {
 NSLog(@"取消啦");
 }];
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, YMAlertButtonTypeStyle) {
    YMAlertButtonTypeStyleDefault = 0, // 默认确定取消按钮
    YMAlertButtonTypeStyleAlone, // 只有确定按钮
};

@interface YMSureCancelAlert : UIView

/**
 设置标题和回到方法 推荐使用

 @param text 要显示的标题
 @param sureTitle 确定按钮文字
 @param maxHeight 是否只有一个按钮
 @param alertStyle 最大显示的高度
 @param sureBtnClickBlock 确定按钮点击回调
 @param cancelBtnClickBlock 取消按钮点击回到
 @return self
 */
- (instancetype)initWithTitleText:(NSString *)text sureBtnTitle:(NSString *)sureTitle maxHeight:(CGFloat)maxHeight alertStyle:(YMAlertButtonTypeStyle)alertStyle sureBtnClick:(void(^)(UIButton *sureBtn))sureBtnClickBlock cancelBtnClick:(void(^)(UIButton *cancelBtn))cancelBtnClickBlock;

/**
 设置标题和回到方法 推荐使用
 
 @param text 要显示的标题
 @param sureTitle 确定按钮文字
 @param maxHeight 是否只有一个按钮
 @param alertStyle 最大显示的高度
 @param sureBtnClickBlock 确定按钮点击回调
 @param cancelBtnClickBlock 取消按钮点击回到
 @return self
 */
+ (instancetype)alertText:(NSString *)text sureBtnTitle:(NSString *)sureTitle maxHeight:(CGFloat)maxHeight alertStyle:(YMAlertButtonTypeStyle)alertStyle sureBtnClick:(void(^)(UIButton *sureBtn))sureBtnClickBlock cancelBtnClick:(void(^)(UIButton *cancelBtn))cancelBtnClickBlock;

/**
 显示
 */
- (void)alertShow;

/**
 隐藏
 */
- (void)alertHidden;
@end

NS_ASSUME_NONNULL_END
