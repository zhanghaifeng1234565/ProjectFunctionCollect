//
//  YMUINavigationController.m
//  YMUICommonlyUsedTools
//
//  Created by iOS on 2018/5/24.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMUINavigationController.h"

@interface YMUINavigationController ()
<UINavigationBarDelegate>

/** 加入一个属性，标记是否正在执行pop */
@property (nonatomic) BOOL isAnimating;

@end

@implementation YMUINavigationController

#pragma mark -- lifeStyle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_navigation_bg_6p"] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.shadowImage = [UIImage new];
    [self.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"staff_list_return_arrow"]];
    [self.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"staff_list_return_arrow"]];
    self.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17], NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    BOOL shouldPop = YES;
    NSUInteger count = self.viewControllers.count;
    NSUInteger itemsCount = navigationBar.items.count;
    if(self.isAnimating == YES){
        if(count < itemsCount){
            self.isAnimating = NO;
            return shouldPop;
        }else{
            return NO;
        }
    }
    self.isAnimating = YES;
    if(count < itemsCount){
        self.isAnimating = NO;
        return shouldPop;
    }
    UIViewController *vc = self.topViewController;
    if([vc respondsToSelector:@selector(shouldPopOnBackButtonPress)]){
        shouldPop = [vc performSelector:@selector(shouldPopOnBackButtonPress)];
    }
    if(shouldPop == NO){
        [self setNavigationBarHidden:YES];
        [self setNavigationBarHidden:NO];
    } else {
        if(count >= itemsCount){
            dispatch_async(dispatch_get_main_queue(), ^{
                [self popViewControllerAnimated: YES];
            });
        }
    }
    [self resumeAnimationAfter:0.2];
    return shouldPop;
}

- (void)resumeAnimationAfter:(CGFloat)delay {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        self.isAnimating = NO;
    });
}

@end
