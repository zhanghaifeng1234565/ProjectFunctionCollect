//
//  YMCommonFunc.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/6.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YMCommonFunc : NSObject


/**
 加密方法

 @param known 要加密的字符串
 @param key 加密秘钥
 @return 加密后的字符串
 */
+ (NSString *)encode:(NSString *)known withKey:(NSString *)key;

/**
 解密方法

 @param ciphertext 要解密的字符串
 @param key 加密秘钥
 @return 解密后的字符串
 */
+ (NSString *)decode:(NSString *)ciphertext withKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
