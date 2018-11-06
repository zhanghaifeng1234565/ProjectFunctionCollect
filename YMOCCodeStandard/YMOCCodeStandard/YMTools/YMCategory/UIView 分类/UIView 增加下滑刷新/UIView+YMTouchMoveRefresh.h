//
//  UIView+YMTouchMoveRefresh.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/9/14.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 一个不借助 scrollView 实现的刷新控件 */
@interface UIView (YMTouchMoveRefresh)

/** 系统菊花 */
@property (nonatomic, strong, readonly) UIActivityIndicatorView *ym_activityIndicatorView;
/** 点到的初始位置字符串 y */
@property (nonatomic, copy, readonly) NSString *ym_touchBeginYStr;
/** 点到的初始位置 y */
@property (nonatomic, assign, readonly) CGFloat ym_touchBeginY;

/**
 添加刷新视图
 */
- (void)ym_addRefreshView;

/**
 开启刷新
 */
- (void)ym_startRefreshData;

/**
 结束刷新
 */
- (void)ym_endRefreshData;
@end
