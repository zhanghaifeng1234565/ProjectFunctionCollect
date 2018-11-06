//
//  YMActiveAlertView.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/10/23.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YMActiveAlertView : UIView

/**
 展示

 @param parsentView 要展示在的视图
 */
- (void)showAlertInParsentView:(UIView *)parsentView;

/**
 隐藏
 */
- (void)hiddenAlert;
@end

NS_ASSUME_NONNULL_END
