//
//  YMDataSaveSingleton.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/9/13.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMDataSaveSingleton.h"

@implementation YMDataSaveSingleton

static YMDataSaveSingleton *_instance = nil;
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

#pragma mark -- getter
- (NSMutableArray *)idMArr {
    if (_idMArr == nil) {
        _idMArr = [[NSMutableArray alloc] init];
    }
    return _idMArr;
}
@end
