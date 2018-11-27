//
//  UIViewController+YMBackToViewController.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/9/18.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (YMBackToViewController)

/**
 返回指定的控制器
 
 @param controllerName 要返回的控制器的名字
 @param animaed 是否有动画
 */
- (void)ym_backToController:(NSString *)controllerName animated:(BOOL)animaed;
@end

NS_ASSUME_NONNULL_END
