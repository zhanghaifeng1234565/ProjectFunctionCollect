//
//  UIView+YMParentController.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/9/18.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (YMParentController)

#pragma mark --- 通过属性获取

/** 视图所在父控制器 */
@property (nonatomic, strong, readonly) UIViewController *ym_parentViewController;
/** 视图所在导航控制器 */
@property (nonatomic, strong, readonly) UINavigationController *ym_parentNavController;

#pragma mark --- 通过方法获取

/**
 视图所在父控制器

 @return 当前父控制器
 */
- (UIViewController *)ym_parentController;

/**
 视图所在导航控制器

 @return 当前导航控制器
 */
- (UINavigationController *)ym_parentNavigationController;
@end

NS_ASSUME_NONNULL_END
