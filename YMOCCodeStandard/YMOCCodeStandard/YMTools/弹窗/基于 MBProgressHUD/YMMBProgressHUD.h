//
//  YMMBProgressHUD.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/10/23.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YMMBProgressHUD : NSObject

/**
 展示黑色小弹窗

 @param parentView 展示在的视图
 @param text 展示的内容
 @param afterDelay 展示时长
 */
+ (void)ymShowBlackAlert:(UIView *)parentView text:(NSString *)text afterDelay:(NSTimeInterval)afterDelay;

/**
 显示系统菊花 loading

 @param parentView 所在父视图
 */
+ (void)ymShowLoadingAlert:(UIView *)parentView;

/**
 隐藏加载视图

 @param parentView 所在的视图
 */
+ (void)ymHideLoadingAlert:(UIView *)parentView;

/**
 自定义 loading

 @param parentView 要展示的视图
 @param text 要展示的文字
 */
+ (void)ymShowCustomLoadingAlert:(UIView *)parentView text:(NSString *)text;
@end

NS_ASSUME_NONNULL_END
