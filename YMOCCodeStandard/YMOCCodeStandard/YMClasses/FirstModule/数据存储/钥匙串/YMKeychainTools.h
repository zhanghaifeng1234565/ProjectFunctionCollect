//
//  YMKeychainTools.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/12/4.
//  Copyright © 2018 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YMKeychainTools : NSObject


/**
 保存信息到钥匙串

 @param sValue 要保存的值
 @param sKey 要保存的键
 */
+ (void)saveKeychainValue:(NSString *)sValue key:(NSString *)sKey;



/**
 读取保存的信息

 @param sKey 键
 @return 值
 */
+ (NSString *)readKeychainValue:(NSString *)sKey;




/**
 删除保存的信息

 @param sKey 键
 */
+ (void)deleteKeychainValue:(NSString *)sKey;


@end

NS_ASSUME_NONNULL_END
