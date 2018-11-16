//
//  YMBaseViewController.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/10/29.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMBaseViewController.h"

@interface YMBaseViewController ()

@end

@implementation YMBaseViewController

#pragma mark - - 销毁
- (void)dealloc{
    // 只要控制器执行此方法，代表VC以及其控件全部已安全从内存中撤出。
    // ARC除去了手动管理内存，但不代表能控制循环引用，虽然去除了内存销毁概念，但引入了新的概念--对象被持有。
    // 框架在使用后能完全从内存中销毁才是最好的优化
    // 不明白ARC和内存泄漏的请自行谷歌，此示例已加入内存检测功能，如果有内存泄漏会alent进行提示
    NSLog(@"控制器%s调用情况，已销毁%@", __func__, self);
}

#pragma mark - - init
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

#pragma mark - - lifeStyle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:self.title style:UIBarButtonItemStylePlain target:self action:nil];
    if (self.customBack == YES) { // 当返回操作多余一个控制器的时候禁止侧滑返回
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    } else {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    
    // MARK: 加载视图
    [self loadSubviews];
    
    // MARK: 配置视图
    [self configSubviews];
    
    // MARK: 布局视图
    [self layoutSubviews];
    
    // MARK: 加载数据
    [self loadData];
}

#pragma mark - - 加载视图
- (void)loadSubviews {
    
}

#pragma mark - - 配置视图
- (void)configSubviews {
    
}

#pragma mark - - 布局视图
- (void)layoutSubviews {
    
}

#pragma mark - - 加载数据
- (void)loadData {
    
}

@end
