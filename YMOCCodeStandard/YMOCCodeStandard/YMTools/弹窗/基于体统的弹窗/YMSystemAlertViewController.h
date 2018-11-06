//
//  YMSystemAlertViewController.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/10/23.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YMSystemAlertViewController : NSObject

/**
 根据 UIAlertViewController 封装的弹窗

 @param nav 要展示在的导航控制器
 @param title 标题
 @param message 内容
 @param type 类型
 @param sureBlock 确定回调
 @param cancelBlock 取消回调
 */
+ (void)ymSystemAlertVC:(UINavigationController *)nav title:(NSString *)title message:(NSString *)message type:(UIAlertControllerStyle)type sureBlock:(void (^)(UIAlertAction * _Nonnull))sureBlock cancelBlock:(void (^)(UIAlertAction * _Nonnull))cancelBlock;

/**
 根据 UIAlertViewController 封装的弹窗保存图片

 @param nav 要展示在的导航控制器
 @param title 标题
 @param message 内容
 @param type 类型
 @param sureBlock 确定回调
 @param cancelBlock 取消回调
 */
+ (void)ymSystemSavePictureAlertVC:(UINavigationController *)nav title:(NSString *)title message:(NSString *)message type:(UIAlertControllerStyle)type sureBlock:(void (^)(UIAlertAction * _Nonnull))sureBlock cancelBlock:(void (^)(UIAlertAction * _Nonnull))cancelBlock;

@end

NS_ASSUME_NONNULL_END
