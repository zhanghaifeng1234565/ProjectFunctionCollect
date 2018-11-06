//
//  YMTouchMoveView.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/9/14.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMTouchMoveView.h"
#import "UIView+YMParentController.h"

#import "YMWorkbenchViewController.h"

@interface YMTouchMoveView ()

/** 系统菊花 */
@property (nonatomic, strong, readwrite) UIActivityIndicatorView *activityIndicatorView;

@end

@implementation YMTouchMoveView {
    /** 点到的初始位置 y */
    CGFloat _touchBeginY;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 添加视图
        [self addSubViews];
        // 布局视图
        [self layoutSubViews];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self layoutSubViews];
}

#pragma mark -- 添加视图
- (void)addSubViews {
    [[UIApplication sharedApplication].keyWindow addSubview:self.activityIndicatorView];
}

#pragma mark -- 布局视图
- (void)layoutSubViews {
    self.activityIndicatorView.frame = CGRectMake((MainScreenWidth-15)/2, -15, 15, 15);
}

#pragma mark -- touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    CGPoint touchPoint = [touch locationInView:self];
    _touchBeginY = touchPoint.y;
    NSLog(@"x=%f -- y=%f", touchPoint.x, touchPoint.y);
    
//    YMWorkbenchViewController *vc = [[YMWorkbenchViewController alloc] init];
//    vc.title = @"工作台";
//    [self.ym_parentNavController pushViewController:vc animated:YES];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    CGPoint touchPoint = [touch locationInView:self];
    NSLog(@"x=%f -- y=%f", touchPoint.x, touchPoint.y);
    
    CGFloat differenceY = touchPoint.y - _touchBeginY;
    if (differenceY > 0) {
        self.activityIndicatorView.top = differenceY <= NavBarHeight ? differenceY : NavBarHeight;
        self.activityIndicatorView.hidden = NO;
        [self.activityIndicatorView startAnimating];
    } else {
        self.activityIndicatorView.top = -15;
        self.activityIndicatorView.hidden = YES;
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5 animations:^{
            self.activityIndicatorView.top = -15;
        } completion:^(BOOL finished) {
            self.activityIndicatorView.hidden = YES;
            self->_touchBeginY = 0;
        }];
    });
}

#pragma mark -- lazyLoadUI
- (UIActivityIndicatorView *)activityIndicatorView {
    if (_activityIndicatorView == nil) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc] init];
        _activityIndicatorView.hidden = YES;
        _activityIndicatorView.color = [UIColor redColor];
    }
    return _activityIndicatorView;
}
@end
