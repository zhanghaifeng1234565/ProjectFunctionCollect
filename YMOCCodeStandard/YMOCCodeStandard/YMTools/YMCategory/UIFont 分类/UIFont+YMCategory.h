//
//  UIFont+YMCategory.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/14.
//  Copyright © 2018 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (YMCategory)


/**
 正常字体

 @return 字体
 */
+ (UIFont *)normalFont;


/**
 选中字体

 @return 字体
 */
+ (UIFont *)selectFont;

@end

NS_ASSUME_NONNULL_END
