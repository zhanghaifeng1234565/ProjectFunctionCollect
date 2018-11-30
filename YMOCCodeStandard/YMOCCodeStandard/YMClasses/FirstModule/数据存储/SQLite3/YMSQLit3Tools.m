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

+ (void)openSQLite3 {
    if (db != nil) {
        NSLog(@"数据库已打开");
        return;
    }
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"person.sqlite"];
    
    int result = sqlite3_open(filePath.UTF8String, &db);
    if (result == SQLITE_OK) {
        NSLog(@"数据库打开成功");
    } else {
        NSLog(@"数据库打开失败");
    }
}

+ (void)createTable {
    NSString *sqlite = [NSString stringWithFormat:@"create table if not exists t_person(id integer primary key autoincrement, name text not null, age integer)"];
    
    // 用来记录错误信息
    char error = NULL;
    
    // 执行 sqlit 语句
    int result = sqlite3_exec(db, sqlite.UTF8String, nil, nil, &error);
    
    if (result == SQLITE_OK) {
        NSLog(@"创建表格成功");
    } else {
        NSLog(@"创建表格失败");
    }
}

@end
