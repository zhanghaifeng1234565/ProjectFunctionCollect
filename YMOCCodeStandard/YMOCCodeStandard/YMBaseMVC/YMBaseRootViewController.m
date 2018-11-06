//
//  YMBaseRootViewController.m
//  YMDoctorClient
//
//  Created by iOS on 2018/6/14.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMBaseRootViewController.h"

@interface YMBaseRootViewController ()

@end

@implementation YMBaseRootViewController
- (void)dealloc{
    // 只要控制器执行此方法，代表VC以及其控件全部已安全从内存中撤出。
    // ARC除去了手动管理内存，但不代表能控制循环引用，虽然去除了内存销毁概念，但引入了新的概念--对象被持有。
    // 框架在使用后能完全从内存中销毁才是最好的优化
    // 不明白ARC和内存泄漏的请自行谷歌，此示例已加入内存检测功能，如果有内存泄漏会alent进行提示
    NSLog(@"控制器%s调用情况，已销毁%@", __func__, self);
}

#pragma mark -- lifeStyle
- (void)viewDidLoad {
    [super viewDidLoad];
}
@end
