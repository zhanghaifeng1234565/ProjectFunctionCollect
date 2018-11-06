//
//  YMBaseViewController.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/10/29.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMUINavigationController.h"

NS_ASSUME_NONNULL_BEGIN

@interface YMBaseViewController : UIViewController<YMUINavigationControllerDelegate>

/** 是否使用自定义返回操作 建议当返回操作多余一个控制器时使用 */
@property (nonatomic, assign, getter=isCustomBack) BOOL customBack;
@end

NS_ASSUME_NONNULL_END
