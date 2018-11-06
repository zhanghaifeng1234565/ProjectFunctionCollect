//
//  YMNetworkingSecondaryPackage.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/9/17.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMNetworkingSecondaryPackage.h"
#import "YMNetworkingBaseUtils.h"

/** 网络请求服务器时间键 */
#define NET_SERVER_TIME_KEY  @"timepoor"

@implementation YMNetworkingSecondaryPackage
#pragma mark -- POST 请求
#pragma mark -- 通用网络请求接口 参数加密
+ (void)POSTRequestWithSuffixUrl:(NSString *)suffixUrl
                     requestDict:(NSMutableDictionary *)dictMData
                requestParamData:(NSString *)paramData
                  requestSuccess:(YMNetworkingSecondaryPackageSuccessBlcok)success
                  requestFailure:(YMNetworkingSecondaryPackageFailureBlcok)failure {
    
    NSString *paramD = [self getServerTimeAndEncodeParamData:paramData];
    [[YMNetworkingBaseUtils shareManager] networkRequestMethod:YMNetworkingBaseUtilsRequestMethodPOST requestSuffixUrl:suffixUrl requestDict:dictMData requestParamData:paramD requestSuccess:^(id result) {
        success(result);
    } requestFailure:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark -- POST 上传数组形式上传图片
+ (void)POSTRequestWithSuffixUrl:(NSString *)suffixUrl
                     requestDict:(NSMutableDictionary *)dictMData
                requestParamData:(NSString *)paramData
            uploadImageWithArray:(NSArray *)imageArr
                        imageKey:(NSString *)imageKey
                  requestSuccess:(YMNetworkingSecondaryPackageSuccessBlcok)success
                  requestFailure:(YMNetworkingSecondaryPackageFailureBlcok)failure {
    
    NSString *paramD = [self getServerTimeAndEncodeParamData:paramData];
    [[YMNetworkingBaseUtils shareManager] networkRequestSuffixUrl:suffixUrl requestDict:dictMData requestParamData:paramD uploadImageWithArray:imageArr imageKey:imageKey requestSuccess:^(id result) {
        success(result);
    } requestFailure:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark -- POST 上传图片字典形式
+ (void)POSTRequestWithSuffixUrl:(NSString *)suffixUrl
                     requestDict:(NSMutableDictionary *)dictMData
                requestParamData:(NSString *)paramData
        uploadImageWithImageDict:(NSDictionary *)imageDict
                  requestSuccess:(YMNetworkingSecondaryPackageSuccessBlcok)success
                  requestFailure:(YMNetworkingSecondaryPackageFailureBlcok)failure {
    
    NSString *paramD = [self getServerTimeAndEncodeParamData:paramData];
    [[YMNetworkingBaseUtils shareManager] networkRequestSuffixUrl:suffixUrl requestDict:dictMData requestParamData:paramD uploadImageWithImageDict:imageDict requestSuccess:^(id result) {
        success(result);
    } requestFailure:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark -- 获取服务器时间差以及加密字符串
+ (NSString *)getServerTimeAndEncodeParamData:(NSString *)paramData {
    NSInteger nowTime = [[YMNetworkingSecondaryPackage getNowTime] integerValue];
    NSInteger serverTime = [[[NSUserDefaults standardUserDefaults] objectForKey:NET_SERVER_TIME_KEY] integerValue];
    NSString *timeDifference = [NSString stringWithFormat:@"%zd", nowTime - serverTime + nowTime];
    
    NSString *paramD;
    if (![paramData isEqualToString:@""]) {
        paramD = [NSString stringWithFormat:@"%@,%@,%@,%@", timeDifference, USER_ID, USER_AUTH, paramData];
    } else {
        paramD = [NSString stringWithFormat:@"%@,%@,%@", timeDifference, USER_ID, USER_AUTH];
    }
    return paramD;
}

#pragma mark -- 通用网络请求接口 参数不加密
+ (void)POSTRequestWithSuffixUrl:(NSString *)suffixUrl
                     requestDict:(NSMutableDictionary *)dictMData
                  requestSuccess:(YMNetworkingSecondaryPackageSuccessBlcok)success
                  requestFailure:(YMNetworkingSecondaryPackageFailureBlcok)failure {
    [[YMNetworkingBaseUtils shareManager] networkRequestMethod:YMNetworkingBaseUtilsRequestMethodPOST requestSuffixUrl:suffixUrl requestDict:dictMData requestSuccess:^(id result) {
        success(result);
    } requestFailure:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark -- GET 请求
#pragma mark -- 通用网络请求接口 参数加密
+ (void)GETRequestWithSuffixUrl:(NSString *)suffixUrl
                     requestDict:(NSMutableDictionary *)dictMData
                requestParamData:(NSString *)paramData
                  requestSuccess:(YMNetworkingSecondaryPackageSuccessBlcok)success
                  requestFailure:(YMNetworkingSecondaryPackageFailureBlcok)failure {
    
    NSInteger nowTime = [[YMNetworkingSecondaryPackage getNowTime] integerValue];
    NSInteger serverTime = [[[NSUserDefaults standardUserDefaults] objectForKey:NET_SERVER_TIME_KEY] integerValue];
    NSString *timeDifference = [NSString stringWithFormat:@"%zd", nowTime-serverTime+nowTime];
    
    NSString *paramD;
    if (![paramData isEqualToString:@""]) {
        paramD = [NSString stringWithFormat:@"%@,%@,%@,%@", timeDifference, USER_ID, USER_AUTH, paramData];
    } else {
        paramD = [NSString stringWithFormat:@"%@,%@,%@", timeDifference, USER_ID, USER_AUTH];
    }
    
    [[YMNetworkingBaseUtils shareManager] networkRequestMethod:YMNetworkingBaseUtilsRequestMethodGET requestSuffixUrl:suffixUrl requestDict:dictMData requestParamData:paramD requestSuccess:^(id result) {
        success(result);
    } requestFailure:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark -- 通用网络请求接口 参数不加密
+ (void)GETRequestWithSuffixUrl:(NSString *)suffixUrl
                    requestDict:(NSMutableDictionary *)dictMData
                 requestSuccess:(YMNetworkingSecondaryPackageSuccessBlcok)success
                 requestFailure:(YMNetworkingSecondaryPackageFailureBlcok)failure {
    [[YMNetworkingBaseUtils shareManager] networkRequestMethod:YMNetworkingBaseUtilsRequestMethodGET requestSuffixUrl:suffixUrl requestDict:dictMData requestSuccess:^(id result) {
        success(result);
    } requestFailure:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark -- 获取当前时间
+ (NSString *)getNowTime {
    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%0.f", a];
    return timeString;
}

@end
