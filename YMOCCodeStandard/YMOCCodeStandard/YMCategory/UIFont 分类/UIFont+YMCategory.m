//
//  UIFont+YMCategory.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/14.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "UIFont+YMCategory.h"

@implementation UIFont (YMCategory)

#pragma mark - - 正常状态下不同屏幕字体
+ (UIFont *)normalFont {
    if (IPHONE4 || IPHONE5) {
        return [UIFont systemFontOfSize:11];
    } else if (IPHONE6 || iPhoneX) {
        return [UIFont systemFontOfSize:13];
    } else {
        return [UIFont systemFontOfSize:15];
    }
}

#pragma mark - - 选中状态下不同屏幕字体
+ (UIFont *)selectFont {
    if (IPHONE4 || IPHONE5) {
        return [UIFont systemFontOfSize:13];
    } else if (IPHONE6 || iPhoneX) {
        return [UIFont systemFontOfSize:15];
    } else {
        return [UIFont systemFontOfSize:17];
    }
}

@end
