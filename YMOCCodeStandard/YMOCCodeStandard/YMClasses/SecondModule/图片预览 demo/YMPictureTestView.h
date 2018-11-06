//
//  YMPictureTestView.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/5.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YMPictureTestView : UIView

/**
 初始化方法

 @param frame  frame
 @param type 1 是本地图片 否则 网络图片
 @return self
 */
- (instancetype)initWithFrame:(CGRect)frame imageType:(NSString *)type;
@end

NS_ASSUME_NONNULL_END
