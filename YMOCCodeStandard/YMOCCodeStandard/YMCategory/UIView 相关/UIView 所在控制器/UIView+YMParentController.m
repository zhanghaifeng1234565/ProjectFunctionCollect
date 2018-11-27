//
//  UIView+YMParentController.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/9/18.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "UIView+YMParentController.h"
#import <objc/runtime.h>

@interface UIView ()

/** 视图所在父控制器 */
@property (nonatomic, strong, readwrite) UIViewController *ym_parentViewController;
/** 视图所在导航控制器 */
@property (nonatomic, strong, readwrite) UINavigationController *ym_parentNavController;

@end

@implementation UIView (YMParentController)

#pragma mark -- 关联 ym_parentViewController getter - setter 方法
- (UIViewController *)ym_parentViewController {
    self.ym_parentViewController = [self ym_parentController];
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setYm_parentViewController:(UIViewController *)ym_parentViewController {
    objc_setAssociatedObject(self, @selector(ym_parentViewController), ym_parentViewController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark -- 关联 ym_parentNavController getter - setter 方法
- (UINavigationController *)ym_parentNavController {
    self.ym_parentNavController = [self ym_parentNavigationController];
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setYm_parentNavController:(UINavigationController *)ym_parentNavController {
    objc_setAssociatedObject(self, @selector(ym_parentNavController), ym_parentNavController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark -- 视图所在父控制器
- (UIViewController *)ym_parentController {
    UIResponder *responder = [self nextResponder];
    while (responder) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = [responder nextResponder];
    }
    return nil;
}

#pragma mark -- 视图所在导航控制器
- (UINavigationController *)ym_parentNavigationController {
    return [self ym_parentController].navigationController;
}
@end
