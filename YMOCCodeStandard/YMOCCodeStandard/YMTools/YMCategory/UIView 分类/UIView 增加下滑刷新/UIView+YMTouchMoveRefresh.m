//
//  UIView+YMTouchMoveRefresh.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/9/14.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "UIView+YMTouchMoveRefresh.h"
#import <objc/runtime.h>

static const CGFloat kRefreshViewTopLocation = -30;

@interface UIView ()

/** 系统菊花 */
@property (nonatomic, strong, readwrite) UIActivityIndicatorView *ym_activityIndicatorView;
/** 点到的初始位置字符串 y */
@property (nonatomic, copy, readwrite) NSString *ym_touchBeginYStr;
/** 点到的初始位置 y */
@property (nonatomic, assign, readwrite) CGFloat ym_touchBeginY;
/** y 偏移 */
@property (nonatomic, assign, readwrite) CGFloat ym_differenceY;
/** y 偏移 */
@property (nonatomic, assign, readwrite, getter=ym_isGesterExist) BOOL ym_gesterExist;

@end

@implementation UIView (YMTouchMoveRefresh)

#pragma mark -- touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
//    if (self.ym_isGesterExist == YES) { // 如果下划手势已经存在返回
//        return;
//    }
//
//    UITouch *touch = touches.anyObject;
//    CGPoint touchPoint = [touch locationInView:self];
//    self.ym_touchBeginY = touchPoint.y;
//    [self.ym_activityIndicatorView startAnimating];
//    self.ym_gesterExist = YES;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    
//    UITouch *touch = touches.anyObject;
//    CGPoint touchPoint = [touch locationInView:self];
//
//    self.ym_differenceY = touchPoint.y - self.ym_touchBeginY;
//    if (self.ym_differenceY > 0) {
//        self.ym_activityIndicatorView.top = self.ym_differenceY < NavBarHeight ? self.ym_differenceY : NavBarHeight;
//        self.ym_activityIndicatorView.hidden = NO;
//    } else {
//        self.ym_activityIndicatorView.top = kRefreshViewTopLocation;
//        self.ym_activityIndicatorView.hidden = YES;
//    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [super touchesEnded:touches withEvent:event];
//    
//    if (self.ym_differenceY < NavBarHeight) {
//        [self ym_endRefreshData];
//    }
}

#pragma mark -- runtime
//定义常量 必须是C语言字符串
static char *ym_activityIndicatorView_key = "ym_activityIndicatorView_key";
- (UIActivityIndicatorView *)ym_activityIndicatorView {
    return objc_getAssociatedObject(self, ym_activityIndicatorView_key);
}

- (void)setYm_activityIndicatorView:(UIActivityIndicatorView *)ym_activityIndicatorView {
    objc_setAssociatedObject(self, ym_activityIndicatorView_key, ym_activityIndicatorView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark -- 分类中增加属性的写法一
static char *touch_begin_y_key = "touch_begin_y_key";
- (NSString *)ym_touchBeginYStr {
    return objc_getAssociatedObject(self, touch_begin_y_key);
}

- (void)setYm_touchBeginYStr:(NSString *)ym_touchBeginYStr {
    objc_setAssociatedObject(self, touch_begin_y_key, ym_touchBeginYStr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark -- 分类中增加属性的写法二
- (CGFloat)ym_touchBeginY {
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}

- (void)setYm_touchBeginY:(CGFloat)ym_touchBeginY {
    objc_setAssociatedObject(self, @selector(ym_touchBeginY), @(ym_touchBeginY), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)ym_differenceY {
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}

- (void)setYm_differenceY:(CGFloat)ym_differenceY {
    objc_setAssociatedObject(self, @selector(ym_differenceY), @(ym_differenceY), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)ym_isGesterExist {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setYm_gesterExist:(BOOL)ym_gesterExist {
    objc_setAssociatedObject(self, @selector(ym_isGesterExist), @(ym_gesterExist), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark -- 添加刷新视图
- (void)ym_addRefreshView {
    self.ym_activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((MainScreenWidth-15)/2, kRefreshViewTopLocation, 15, 15)];
    self.ym_activityIndicatorView.color = [UIColor redColor];
    [[UIApplication sharedApplication].keyWindow addSubview:self.ym_activityIndicatorView];
}

#pragma mark -- 开始刷新
- (void)ym_startRefreshData {
    self.ym_activityIndicatorView.top = kRefreshViewTopLocation;
    self.ym_activityIndicatorView.hidden = NO;
    [self.ym_activityIndicatorView startAnimating];
    self.ym_touchBeginY = 0;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5 animations:^{
            self.ym_activityIndicatorView.top = NavBarHeight;
        } completion:^(BOOL finished) {
           
        }];
    });
}

#pragma mark -- 结束刷新
- (void)ym_endRefreshData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.1f animations:^{
            self.ym_activityIndicatorView.top = kRefreshViewTopLocation;
        } completion:^(BOOL finished) {
            [self.ym_activityIndicatorView stopAnimating];
            self.ym_activityIndicatorView.hidden = YES;
            self.ym_touchBeginY = 0;
            self.ym_differenceY = 0;
            self.ym_gesterExist = NO;
        }];
    });
}
@end
