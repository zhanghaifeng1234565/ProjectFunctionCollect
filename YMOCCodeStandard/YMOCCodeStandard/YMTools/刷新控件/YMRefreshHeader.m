//
//  YMRefreshHeader.m
//  YMOAManageSystem
//
//  Created by iOS on 2018/11/20.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "YMRefreshHeader.h"
#import <Lottie/Lottie.h>
#import "MJRefreshHeader+YMRefreshHeader.h"

#define YM_iPhoneXLater ([[UIApplication sharedApplication] statusBarFrame].size.height > 20 ? YES : NO)

static CGFloat navigationIsTransparentHeight = 94;
static CGFloat navigationIsNormalHeight = 70.0f;
static CGFloat kAnimationVWidth = 146;
static CGFloat kAnimationVHeight = 65;

@interface YMRefreshHeader ()

/** 下拉动画控件 */
@property (nonatomic, weak) LOTAnimationView *animationV;

@end

@implementation YMRefreshHeader

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"%s --- %@", __func__, [self class]);
}

#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare {
    [super prepare];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshPlay) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    LOTAnimationView *animation = [LOTAnimationView animationNamed:@"OARefreshHeader"];
    animation.loopAnimation = YES;
    [animation play];
    [animation playWithCompletion:^(BOOL animationFinished) {
        // Do Something
    }];
    [self addSubview:animation];
    self.animationV = animation;
}

#pragma mark -- 重新转动
- (void)refreshPlay {
    self.animationV.loopAnimation = YES;
    [self.animationV play];
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews {
    [super placeSubviews];

    CGFloat animationVTopMargin = 5.0f;
    if (YM_iPhoneXLater) {
        if (self.ym_navigationIsTransparent == YES) {
            // 设置控件的高度
            self.mj_h = navigationIsTransparentHeight;
            animationVTopMargin = navigationIsTransparentHeight - kAnimationVHeight + 5.0;
        } else {
            self.mj_h = navigationIsNormalHeight;
            animationVTopMargin = 5.0f;
        }
    } else {
        self.mj_h = navigationIsNormalHeight;
        animationVTopMargin = 5.0f;
    }
    
    self.animationV.frame = CGRectMake((self.frame.size.width - kAnimationVWidth) / 2, animationVTopMargin, kAnimationVWidth, kAnimationVHeight);
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change {
    [super scrollViewContentSizeDidChange:change];
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change {
    [super scrollViewPanStateDidChange:change];
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state {
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            [self.animationV play];
            break;
        case MJRefreshStatePulling:
            [self.animationV play];
            break;
        case MJRefreshStateRefreshing:
            [self.animationV play];
            break;
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent {
    [super setPullingPercent:pullingPercent];
    
    // 1.0 0.5 0.0
    // 0.5 0.0 0.5
//    CGFloat red = 1.0 - pullingPercent * 0.5;
//    CGFloat green = 0.5 - 0.5 * pullingPercent;
//    CGFloat blue = 0.5 * pullingPercent;
//    self.label.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

@end
