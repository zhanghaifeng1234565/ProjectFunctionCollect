//
//  YMSQLit3Tools.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/30.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "YMSQLit3Tools.h"
#import <sqlite3.h>

static sqlite3 *db;
@implementation YMSQLit3Tools

static YMSQLit3Tools *_instance = nil;
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
- (void)openSQLite3WithName:(NSString *)sqName success:(void (^)(void))success {
    if (db != nil) {
        NSLog(@"数据库已打开");
        success();
        return;
    }
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:sqName];
    NSLog(@"filePath == %@", filePath);
    
    int result = sqlite3_open(filePath.UTF8String, &db);
    if (result == SQLITE_OK) {
        NSLog(@"数据库打开成功");
        success();
    } else {
        NSLog(@"数据库打开失败");
    }
}

#pragma mark - - 建表
- (void)createTable:(NSString *)tableName param:(NSString *)param success:(void (^)(void))success {
    NSString *sqlite = [NSString stringWithFormat:@"create table if not exists '%@'('id' integer primary key autoincrement not null, %@)", tableName, param];
    
    // 用来记录错误信息
    char *error = NULL;
    
    // 执行 sqlit 语句
    int result = sqlite3_exec(db, sqlite.UTF8String, nil, nil, &error);
    
    if (result == SQLITE_OK) {
        NSLog(@"创建表格成功");
        success();
    } else {
        NSLog(@"创表失败---%s----%s---%d", error, __FILE__, __LINE__);
    }
}

#pragma mark - - 插入数据
- (void)insertTable:(NSString *)tableName paramNames:(NSString *)paramNames vaules:(NSString *)vaules success:(void (^)(void))success {
    
     NSString *sql = [NSString stringWithFormat:@"insert into %@ (%@) values (%@)", tableName, paramNames, vaules];
    //2.执行SQL语句
    char *errmsg = NULL;
    sqlite3_exec(db, sql.UTF8String, NULL, NULL, &errmsg);
    if (errmsg) {
        NSLog(@"%s", errmsg);
    } else {
        NSLog(@"插入数据成功");
        success();
    }
}

#pragma mark - - 删除语句
- (void)deleteTable:(NSString *)tableName condition:(NSString *)condition success:(void (^)(void))success {
    //1.准备sqlite语句
    NSString *sqlite = [NSString stringWithFormat:@"delete from %@ where %@", tableName, condition];
    //2.执行sqlite语句
    char *error = NULL;//执行sqlite语句失败的时候,会把失败的原因存储到里面
    int result = sqlite3_exec(db, [sqlite UTF8String], nil, nil, &error);
    if (result == SQLITE_OK) {
        NSLog(@"删除数据成功");
        success();
    } else {
        NSLog(@"删除数据失败%s",error);
    }
}

#pragma mark - - 更新数据
- (void)updataTable:(NSString *)tableName condition:(NSString *)condition where:(NSString *)where success:(void (^)(void))success {
    //1.sqlite语句
    NSString *sqlite = [NSString stringWithFormat:@"update %@ set %@ where %@", tableName, condition, where];
    //2.执行sqlite语句
    NSLog(@"updata sqlite == %@", sqlite);
    char *error = NULL;//执行sqlite语句失败的时候,会把失败的原因存储到里面
    int result = sqlite3_exec(db, [sqlite UTF8String], nil, nil, &error);
    if (result == SQLITE_OK) {
        NSLog(@"修改数据成功");
        success();
    } else {
        NSLog(@"修改数据失败");
    }
}

#pragma mark - - 查询语句
- (void)selectTable:(NSString *)tableName paramNames:(NSString *)paramNames condition:(NSString *)condition success:(void (^)(id _Nonnull))success {
    
    NSString *sql = [NSString stringWithFormat:@"SELECT %@ FROM %@ WHERE %@", paramNames, tableName, condition];
    
    sqlite3_stmt *stmt = NULL;
    //进行查询前的准备工作
    if (sqlite3_prepare_v2(db, sql.UTF8String, -1, &stmt, NULL) == SQLITE_OK) {//SQL语句没有问题
        NSLog(@"查询语句没有问题");
        //每调用一次sqlite3_step函数，stmt就会指向下一条记录
        while (sqlite3_step(stmt) == SQLITE_ROW) {//找到一条记录
            //取出数据
            //(1)取出第0列字段的值（int类型的值）
            int ID = sqlite3_column_int(stmt, 0);
            //(2)取出第1列字段的值（text类型的值）
            const unsigned char *name = sqlite3_column_text(stmt, 1);
            //(3)取出第2列字段的值（int类型的值）
            int age = sqlite3_column_int(stmt, 2);
            // 身高
            float height = sqlite3_column_double(stmt, 3);
            // 体重
            float weight = sqlite3_column_double(stmt, 4);
            NSString *result = [NSString stringWithFormat:@"%d %@ %d %f %f", ID, [NSString stringWithUTF8String:name], age, height, weight];
            NSLog(@"%@", result);
            success(result);
        }
    } else {
       NSLog(@"查询语句有问题");
    }
    
    sqlite3_finalize(stmt);
}


#pragma mark - 4.关闭数据库
- (void)closeSqlite {
    
    int result = sqlite3_close(db);
    if (result == SQLITE_OK) {
        NSLog(@"数据库关闭成功");
    } else {
        NSLog(@"数据库关闭失败");
    }
}

@end
