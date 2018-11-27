//
//  UIImage+YMHDQRcode.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/16.
//  Copyright © 2018 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (YMHDQRcode)

/**
 生成一张带 logo 的二维码

 @param url 要生成的二维码
 @param imageName logo
 @return 二维码图片
 */
+ (UIImage *)createQRCodeWithUrl:(NSString *)url logoImageName:(NSString *)imageName;

@end

NS_ASSUME_NONNULL_END
