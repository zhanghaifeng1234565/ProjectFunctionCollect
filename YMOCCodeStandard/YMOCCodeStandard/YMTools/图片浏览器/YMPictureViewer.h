//
//  YMPictureViewer.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/5.
//  Copyright © 2018年 iOS. All rights reserved.
//

/**
 
 YMPictureViewer *browserView = [[YMPictureViewer alloc] init];
 browserView.originalViews = imageMArr;
 browserView.currentIndex = indexPath.item;
 [browserView show];
 
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class YMSectorProgressView;

@interface YMPictureViewer : UIView
<UIScrollViewDelegate>

/** 原图片视图集合 */
@property (nonatomic, copy) NSArray<UIImageView *> *originalViews;
/** 高清图片 */
@property (nonatomic, copy) NSArray<NSString *> *urls;
/** 当前选中的index */
@property (nonatomic) NSUInteger currentIndex;

/**
 展示图片浏览器
 */
- (void)show;

@end



@interface YMImageBrowserItem : UIView
<UIGestureRecognizerDelegate,
UIScrollViewDelegate>

/** 用来放大缩小 */
@property (nonatomic, strong) UIScrollView *scrollView;
/** 图片 */
@property (nonatomic, strong) UIImageView *imgView;
/** 下载进度条 */
@property (nonatomic, strong) YMSectorProgressView *progressView;
/** 是否在加载中 */
@property (nonatomic) BOOL isloading;
/** 关闭图片浏览器回调 */
@property (nonatomic, copy) void(^closeBlcok)(void);


/**
 加载url图片

 @param urlString 图片路径
 */
- (void)loadImgUrl:(NSString *)urlString;

/**
 配置内容大小
 */
- (void)configContentSize;

@end



@interface YMSectorProgressView : UIView

/** 外圆半径 默认20 */
@property (nonatomic) CGFloat radius;
/** 进度 */
@property (nonatomic) CGFloat progress;

@end

NS_ASSUME_NONNULL_END
