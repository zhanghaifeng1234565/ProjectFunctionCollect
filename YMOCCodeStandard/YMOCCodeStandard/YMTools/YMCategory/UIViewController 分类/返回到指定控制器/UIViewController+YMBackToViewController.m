//
//  UIViewController+YMBackToViewController.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/9/18.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "UIViewController+YMBackToViewController.h"

@implementation UIViewController (YMBackToViewController)

#pragma mark -- 返回到指定的控制器
- (void)ym_backToController:(NSString *)controllerName animated:(BOOL)animaed {
    if (self.navigationController) {
        NSArray *controllers = self.navigationController.viewControllers;
        NSArray *result = [controllers filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            return [evaluatedObject isKindOfClass:NSClassFromString(controllerName)];
        }]];
        
        if (result.count > 0) {
            [self.navigationController popToViewController:result[0] animated:YES];
        }
    }
}
@end
