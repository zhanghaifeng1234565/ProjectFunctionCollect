//
//  YMFMDBTools.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/12/4.
//  Copyright © 2018 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YMFMDBTools : NSObject

/**
 单例
 
 @return self
 */
+ (instancetype)shareManager;


/**
 打开数据库

 @param fileName 文件名
 @param success 成功回调
 */
- (void)openFMDBWithName:(NSString *)fileName success:(void(^)(void))success;


/**
 创建表格

 @param tableName 表名
 @param param 参数
 @param success 成功回调
 */
- (void)createTableWithName:(NSString *)tableName param:(NSString *)param success:(void(^)(void))success;

@end

NS_ASSUME_NONNULL_END
