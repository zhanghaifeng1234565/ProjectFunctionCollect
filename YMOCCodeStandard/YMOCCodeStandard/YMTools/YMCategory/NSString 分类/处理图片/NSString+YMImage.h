//
//  NSString+YMImage.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/6.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (YMImage)

/**
 判断图片格式

 @param data 图片的二进制
 @return 图片格式
 */
+ (NSString *)ym_contentTypeForImageData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
