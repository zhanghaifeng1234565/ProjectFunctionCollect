//
//  YMFMDBTools.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/12/4.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "YMFMDBTools.h"

@implementation YMFMDBTools

static YMFMDBTools *_instance = nil;
static FMDatabase *db;
#pragma mark -- 单例
+ (instancetype)shareManager {
    static dispatch_once_t onceToke;
    dispatch_once(&onceToke, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

#pragma mark - - 打开数据库
- (void)openFMDBWithName:(NSString *)fileName success:(void (^)(void))success {
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:fileName];
    
    // 创建对应路径下的数据库
    db = [FMDatabase databaseWithPath:filePath];
    // 对数据库进行增、删、改、查的时候，需要判断数据库是否打开，如果 open 失败，可能是权限或者资源不足，数据库操作完成通常使用 close 关闭数据库。
    [db open];
    if (![db open]) {
        NSLog(@"数据库打开失败");
    } else {
        success();
    }
}

#pragma mark - - 创建表格
- (void)createTableWithName:(NSString *)tableName param:(NSString *)param success:(void (^)(void))success {
    
    NSString *sql = [NSString stringWithFormat:@"create table if not exist %@ ('itemid' integer premary key autoincrement, %@)", tableName, param];
    // 执行更新操作此处 database 直接操作，不考虑多线程问题，用 FMDatabaseQueue 每次数据库操作之后都会返回 bool 数值，YES，表示 success，NO，表示 fail，可以通过 @see lastError @see lastErrorCode @see lastErrorMessage
    BOOL result = [db executeUpdate:sql];
    if (result) {
        success();
    } else {
        NSLog(@"创建表格失败");
    }
    [db close];
}

@end
