//
//  QRCode.h
//  OA
//
//  Created by iOS开发 on 2018/11/21.
//  Copyright © 2018年 iOS开发. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const kfailErrorCode = @"-100";
static NSString *const kfailErrorDesc = @"识别二维码失败";

NS_ASSUME_NONNULL_BEGIN

@interface QRCode : NSObject


/**
 扫描二维码

 @param view 渲染在view上
 @param successBlock 成功回调
 @param failBlock 失败回调
 */
- (void)initDeviceAndAddView:(UIView *)view WithSuccessBlock:(void(^)(NSString *qrcode))successBlock failBlock:(void(^)(NSError *error))failBlock;
// 开始/停止扫描
- (void)starScanning;
- (void)stopScanning;

/**
 生成二维码
 
 @param string 二维码文字
 @param size 宽
 @return 二维码
 */
+ (UIImage *)creatQrWithString:(NSString *)string withSize:(CGFloat)size;

/**
 通过图片读取二维码
 
 @param image 图片
 @return 二维码
 */
+ (NSString *)readAlbumQRCode:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
