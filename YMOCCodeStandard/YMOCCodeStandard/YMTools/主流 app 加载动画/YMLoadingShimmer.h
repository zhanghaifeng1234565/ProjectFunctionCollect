//
//  YMLoadingShimmer.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/29.
//  Copyright © 2018 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YMLoadingShimmer : NSObject

/**
 开始覆盖子控件

 @param view 要覆盖的视图
 */
+ (void)startCovering:(UIView *)view;


/**
 停止覆盖子控件

 @param view 被覆盖的视图
 */
+ (void)stopCovering:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
