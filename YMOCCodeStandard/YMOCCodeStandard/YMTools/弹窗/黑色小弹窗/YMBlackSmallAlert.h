//
//  YMBlackSmallAlert.h
//  YMUICommonlyUsedTools
//
//  Created by iOS on 2018/5/24.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YMBlackSmallAlert : NSObject

/**
 展示黑色小弹窗

 @param message 要展示的信息
 @param time 展示时长
 */
+ (void)showAlertWithMessage:(NSString *)message time:(NSTimeInterval)time;

@end
