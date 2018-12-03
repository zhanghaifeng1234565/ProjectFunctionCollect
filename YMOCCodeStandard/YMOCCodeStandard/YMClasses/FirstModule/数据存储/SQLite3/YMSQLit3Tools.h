//
//  YMSQLit3Tools.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/30.
//  Copyright © 2018 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YMSQLit3Tools : NSObject

/**
 单例
 
 @return self
 */
+ (instancetype)shareManager;



/**
 打开数据库

 @param sqName 数据库名字
 @param success 成功回调
 */
- (void)openSQLite3WithName:(NSString *)sqName success:(void(^)(void))success;



/**
 创建表格

 @param tableName 表名 eg: @"t_person"
 @param param 参数 eg: @"name text not null, age integer"
 @param success 成功回调
 */
- (void)createTable:(NSString *)tableName param:(NSString *)param success:(void(^)(void))success;



/**
 插入数据

 @param tableName 表名
 @param paramNames 参数数据参数名字 eg: @"name, age"
 @param vaules 插入数据值 eg: @"张三, 16"
 @param success 成功回调
 */
- (void)insertTable:(NSString *)tableName paramNames:(NSString *)paramNames vaules:(NSString *)vaules success:(void(^)(void))success;


/**
 删除数据

 @param tableName 表名
 @param condition 删除条件 eg: @"number = '0'"
 @param success 成功回调
 */
- (void)deleteTable:(NSString *)tableName condition:(NSString *)condition success:(void(^)(void))success;


/**
 更新数据

 @param tableName 表名
 @param condition 条件 eg: @"name = 'zhangsan', age = '17'";
 @param success 成功回调
 */
- (void)updataTable:(NSString *)tableName condition:(NSString *)condition where:(NSString *)where success:(void(^)(void))success;


/**
 查询数据

 @param tableName 表名
 @param paramNames 查询参数 eg: @"id,name,age"
 @param condition 查询条件 eg: @"age<20";
 @param success 成功回调
 */
- (void)selectTable:(NSString *)tableName paramNames:(NSString *)paramNames condition:(NSString *)condition success:(void(^)(id result))success;


/**
 关闭数据库
 */
- (void)closeSqlite;

@end

NS_ASSUME_NONNULL_END
