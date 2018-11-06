//
//  YMUINavigationController.h
//  YMUICommonlyUsedTools
//
//  Created by iOS on 2018/5/24.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "JTNavigationController.h"
//#import "UIViewController+JTNavigationExtension.h"

// 定义一个protocol，实现此协议的类提供它自己的返回规则或者进行相应的个性化处理
@protocol YMUINavigationControllerDelegate <NSObject>
@optional
/** 拦截返回按钮事件 */
- (BOOL)shouldPopOnBackButtonPress;
@end

@interface YMUINavigationController : UINavigationController

/** 自定义导航代理 */
@property (nonatomic, weak) id <YMUINavigationControllerDelegate> ymUINavigationControllerDelegate;
@end
