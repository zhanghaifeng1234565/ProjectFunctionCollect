//
//  UIImage+YMGif.h
//  YMOAManageSystem
//
//  Created by iOS on 2018/11/23.
//  Copyright © 2018 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (YMGif)

/// Property

/** 图片二进制 */
@property (nonatomic, strong) NSData *ym_imgData;


/// Method
/**
 加载本地的一张 gif 图

 @param gifName gif 图的名字
 @return gif 图片
 */
+ (UIImage *)ym_setImageWithBundleGifName:(NSString *)gifName;


/**
 加载一张网络的图片

 @param urlStr 网址链接
 @return gif 图片
 */
+ (UIImage *)ym_setImageWithUrlGifName:(NSString *)urlStr;


@end

NS_ASSUME_NONNULL_END
