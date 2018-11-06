//
//  YMUITabBarController.h
//  YMUICommonlyUsedTools
//
//  Created by iOS on 2018/5/24.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YMUINavigationController;

@interface YMUITabBarController : UITabBarController

/** 控制器1 */
@property (nonatomic, strong) YMUINavigationController *nav1;
/** 控制器2 */
@property (nonatomic, strong) YMUINavigationController *nav2;
/** 控制器3 */
@property (nonatomic, strong) YMUINavigationController *nav3;
/** 控制器4 */
@property (nonatomic, strong) YMUINavigationController *nav4;

@end
