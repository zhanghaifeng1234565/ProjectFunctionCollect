//
//  YMUITabBarController.m
//  YMUICommonlyUsedTools
//
//  Created by iOS on 2018/5/24.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMUITabBarController.h"
#import "YMUINavigationController.h"
#import "YMHomeViewController.h"
#import "YMWorkbenchViewController.h"
#import "YMNewsViewController.h"
#import "YMMineViewController.h"

enum { // 控制器枚举
    ONE = 0,
    TWO,
    THREE,
    FOUR,
};

@interface YMUITabBarController ()

/** 正常图片数组 */
@property (nonatomic, strong) NSArray *normalImageArray;
/** 选中图片数组 */
@property (nonatomic, strong) NSArray *pressImageArray;
/** 图片名称数组 */
@property (nonatomic, strong) NSArray *namesArray;

@end

@implementation YMUITabBarController {
    /** tabBar Btn */
    UIButton *_numberButton;
    /** 文字label */
    UILabel *_numberLable;
}

- (id)init {
    if (self = [super init]) {
        // 创建子导航控制器
        [self setUpChilderNav];
        // 去掉 tabBar 顶部横线
        [self removeTabBarTopLine];
        // 自定义 tabbar
        [self customTabBar];
    }
    return self;
}

#pragma mark -- 创建子导航控制器
- (void)setUpChilderNav {
    YMHomeViewController *vc1 = [[YMHomeViewController alloc] init];
    YMUINavigationController *nav1 = [self setUpChildrenController:vc1 navigtionItemTitle:@"" withTag:ONE];
    
    YMWorkbenchViewController *vc2 = [[YMWorkbenchViewController alloc] init];
    YMUINavigationController *nav2 = [self setUpChildrenController:vc2 navigtionItemTitle:@"图片" withTag:TWO];

    YMNewsViewController *vc3 = [[YMNewsViewController alloc] init];
    YMUINavigationController *nav3 = [self setUpChildrenController:vc3 navigtionItemTitle:@"弹窗" withTag:THREE];
    
    YMMineViewController *vc4 = [[YMMineViewController alloc] init];
    YMUINavigationController *nav4 = [self setUpChildrenController:vc4 navigtionItemTitle:@"我的" withTag:FOUR];
    
    NSArray *viewControllerArray = [[NSArray alloc] initWithObjects:nav1,nav2,nav3,nav4, nil];
    [self setViewControllers:viewControllerArray];
    self.nav1 = nav1;
    self.nav2 = nav2;
    self.nav3 = nav3;
    self.nav4 = nav4;
}

#pragma mark -- 创建自控制器
- (YMUINavigationController *)setUpChildrenController:(UIViewController *)vc navigtionItemTitle:(NSString *)navigationItemTitle withTag:(NSInteger)tag {
    YMUINavigationController *nav = [[YMUINavigationController alloc] initWithRootViewController:vc];
    [vc.navigationItem setTitle:navigationItemTitle];
    [nav.tabBarItem setTag:tag];
    return nav;
}

#pragma mark -- 去掉 tabBar 上部的横线
- (void)removeTabBarTopLine {
    CGRect rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.5);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor colorWithHexString:@"dcdcdc"] CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.tabBar setBackgroundImage:img];
    [self.tabBar setShadowImage:img];
}

#pragma mark -- 自定义 tabBar
- (void)customTabBar {
    //viewTabbar自定义
    UIView *viewTabbar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, TabBarHeight)];
    viewTabbar.backgroundColor = [UIColor redColor];
    
    for (int i = 0; i < [self.viewControllers count]; i++) {
        // 按钮点击
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(MainScreenWidth/[self.viewControllers count]*i, 1, MainScreenWidth/[self.viewControllers count], TabBarHeight-1)];
        [button setTag:i];
        [button addTarget:self action:@selector(tabBarSelected:) forControlEvents:UIControlEventTouchDown];
        
        // 图片
        _numberButton = [[UIButton alloc] initWithFrame:CGRectMake((MainScreenWidth/[self.viewControllers count]-22)/2, 5, 22, 22)];
        _numberButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        _numberButton.tag = i+10;
        [_numberButton setBackgroundImage:[UIImage imageNamed:[self.normalImageArray objectAtIndex:i]] forState:UIControlStateNormal];
        _numberButton.userInteractionEnabled = NO;
        
        // 文字
        _numberLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 32, MainScreenWidth/[self.viewControllers count], 12)];
        _numberLable.tag = i+20;
        _numberLable.text = [self.namesArray objectAtIndex:i];
        _numberLable.adjustsFontSizeToFitWidth = YES;
        _numberLable.textAlignment = NSTextAlignmentCenter;
        _numberLable.font = [UIFont systemFontOfSize:12];
        _numberLable.textColor = [UIColor magentaColor];
        
        [button addSubview:_numberLable];
        [button addSubview:_numberButton];
        [viewTabbar addSubview:button];
    }
    [self.tabBar addSubview:viewTabbar];
    [self tabBar:self.tabBar didSelectItem:self.nav1.tabBarItem];
    UIImageView *barImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, TabBarHeight)];
    barImageView.image = [UIImage imageWithColor:[UIColor colorWithHexString:@"ffffff"]];
    [viewTabbar insertSubview:barImageView atIndex:0];
}

- (void)tabBarSelected:(UIButton*)touchButton {
    // 点击 tabbar 加入过渡动画
    CATransition *transition = [[CATransition alloc] init];
    transition.type = kCATransitionFade;
    [self.view.layer addAnimation:transition forKey:nil];
    
    for (UITabBarItem * tabBarItem in self.tabBar.items) {
        if (tabBarItem.tag == touchButton.tag) {
            [self tabBar:self.tabBar didSelectItem:tabBarItem];
            [self setSelectedIndex:tabBarItem.tag];
        }
    }
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    for (UIView *viewTabbar in [self.tabBar subviews]) {
        if ([viewTabbar isKindOfClass:[UIView class]]) {
            for (UIView *button in [viewTabbar subviews]) {
                if ([button isKindOfClass:[UIButton class]]) {
                    if (button.tag != item.tag) {
                        _numberButton = (UIButton *)[button viewWithTag:10+button.tag];
                        [_numberButton setBackgroundImage:[UIImage imageNamed:[self.normalImageArray objectAtIndex:button.tag]] forState:UIControlStateNormal];
                        [_numberButton setBackgroundImage:[UIImage imageNamed:[self.pressImageArray objectAtIndex:button.tag]] forState:UIControlStateHighlighted];
                        _numberLable = (UILabel *)[button viewWithTag:20+button.tag];
                        _numberLable.textColor = [UIColor colorWithHexString:@"83889a"];
                    } else {
                        _numberButton = (UIButton *)[button viewWithTag:10+button.tag];
                        [_numberButton setBackgroundImage:[UIImage imageNamed:[self.pressImageArray objectAtIndex:button.tag]] forState:UIControlStateNormal];
                        [_numberButton setBackgroundImage:[UIImage imageNamed:[self.normalImageArray objectAtIndex:button.tag]] forState:UIControlStateHighlighted];
                        _numberLable = (UILabel *)[button viewWithTag:20+button.tag];
                        _numberLable.textColor = [UIColor colorWithHexString:@"03abff"];
//                        [self transformScale:button];
                    }
                }
            }
        }
    }
}

#pragma mark -- 动画
- (void)transformScale:(UIView *)view {
    CABasicAnimation *pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.08;
    pulse.repeatCount= 1;
    pulse.autoreverses= YES;
    pulse.fromValue= [NSNumber numberWithFloat:0.8];
    pulse.toValue= [NSNumber numberWithFloat:1.2];
    [[view layer] addAnimation:pulse forKey:nil];
}

#pragma mark -- getter
- (NSArray *)normalImageArray {
    if (_normalImageArray==nil) {
        _normalImageArray = [[NSArray alloc] initWithObjects:@"tab_home_unselected_icon",@"tab_bench_unselected_icon",@"tab_news_unselected_icon",@"tab_mine_unselected_icon",nil];
    }
    return _normalImageArray;
}

- (NSArray *)pressImageArray {
    if (_pressImageArray==nil) {
        _pressImageArray = [[NSArray alloc] initWithObjects:@"tab_home_selected_icon",@"tab_bench_selected_icon",@"tab_news_selected_icon",@"tab_mine_selected_icon",nil];
    }
    return _pressImageArray;
}

- (NSArray *)namesArray {
    if (_namesArray==nil) {
        _namesArray = [[NSArray alloc] initWithObjects:@"首页", @"图片", @"弹窗", @"我的", nil];
    }
    return _namesArray;
}
@end
