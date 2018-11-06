//
//  YMHomeViewController.h
//  YMDoctorClient
//
//  Created by iOS on 2018/6/14.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMBaseRootViewController.h"

typedef void(^YMHomeViewControllerRefreshBlock)(NSString *name, int age);

/** 首页 */
@interface YMHomeViewController : YMBaseRootViewController

/** 外界只可以读取的字符串 */
@property (nonatomic, copy, readonly) NSString *titleString;

@end
