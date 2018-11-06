//
//  YMNetworkingBaseUtils.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/9/17.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMNetworkingBaseUtils.h"
#import "AFNetworking.h"
#import "YMCommonFunc.h"

/** 网络请求 JSON 类型 */
#define RESQUEST_JSON_TYPE [NSSet setWithObjects:@"application/json",@"text/plain", @"text/json", @"text/javascript",@"text/html", nil]
/** 加密秘钥 */
#define ENCRYPTION_KEY @"1QRsTs"
/** 加密 */
#define COMMONFUNC_ENCODE_DESKEY(known, key) [YMCommonFunc encode:known withKey:key]
/** 解密 */
#define COMMONFUNC_DECODE_DESKEY(known, key) [YMCommonFunc decode:known withKey:key]
/** 加密字符串键 */
#define ENCRYPTION_STRING_PARAMDATA_KEY @"paramData"

/** 网络请求公共前缀 */
static const NSString *kAppPrefixURLStr = @"http://www.baidu.com/";
/** 网络请求默认超时时长 */
static const CGFloat kNetworkingRequestTimeOutPeriod = 20;

@implementation YMNetworkingBaseUtils

#pragma mark -- 单例
+ (instancetype)shareManager {
    static id _instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

#pragma mark -- 通用接口 参数加密
- (void)networkRequestMethod:(YMNetworkingBaseUtilsRequestMethod)resquestMethod
            requestSuffixUrl:(NSString *)suffixUrl
                 requestDict:(NSMutableDictionary *)dictMData
            requestParamData:(NSString *)paramData
              requestSuccess:(YMNetworkingBaseUtilsSuccessBlock)success
              requestFailure:(YMNetworkingBaseUtilsFailureBlock)failure {
    // 字符串加密
    NSString *paramData_encode = COMMONFUNC_ENCODE_DESKEY([self clearSpecialCharactersStr:paramData], ENCRYPTION_KEY);
    if (![paramData isEqualToString:@""]) {
        [dictMData setValue:paramData_encode forKey:ENCRYPTION_STRING_PARAMDATA_KEY];
    }
    
    // 请求 url
    NSString *requestUrl = [[kAppPrefixURLStr stringByAppendingString:suffixUrl] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    // 请求方式
    NSString *requestMethod = @"";
    switch (resquestMethod) {
        case YMNetworkingBaseUtilsRequestMethodPOST:
        {
            requestMethod = @"POST";
        }
            break;
        case YMNetworkingBaseUtilsRequestMethodGET:
        {
            requestMethod = @"GET";
        }
            break;
    }
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:requestMethod URLString:requestUrl parameters:dictMData error:nil];
    AFHTTPSessionManager *requestManager = [self NSURLSessionManagerBaseSet];
    
    NSURLSessionDataTask *tesk = [requestManager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            failure(error);
        } else {
            NSData *responseData;
            NSString *string = [[NSString alloc] initWithData:responseObject encoding: NSUTF8StringEncoding];
            NSLog(@"string=%@", string);
            if (![paramData isEqualToString:@""]) {
                responseData = [COMMONFUNC_DECODE_DESKEY(string, ENCRYPTION_KEY) dataUsingEncoding:NSUTF8StringEncoding];
            } else {
                responseData = responseObject;
            }
            id result = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
            success(result);
        }
    }];
    [tesk resume];
}

#pragma mark -- 加密接口 图片数组形式上传 只支持 POST
- (void)networkRequestSuffixUrl:(NSString *)suffixUrl
                    requestDict:(NSMutableDictionary *)dictMData
               requestParamData:(NSString *)paramData
           uploadImageWithArray:(NSArray *)imageArr
                       imageKey:(NSString *)imageKey
                 requestSuccess:(YMNetworkingBaseUtilsSuccessBlock)success
                 requestFailure:(YMNetworkingBaseUtilsFailureBlock)failure {
    
    // 字符串加密
    NSString *paramData_encode = COMMONFUNC_ENCODE_DESKEY([self clearSpecialCharactersStr:paramData], ENCRYPTION_KEY);
    if (![paramData isEqualToString:@""]) {
        [dictMData setValue:paramData_encode forKey:ENCRYPTION_STRING_PARAMDATA_KEY];
    }
    
    if ([imageKey isEqualToString:@""]) {
        imageKey = @"thumb";
    }
    
    // 请求 url
    NSString *requestUrl = [[kAppPrefixURLStr stringByAppendingString:suffixUrl] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *requestManager = [self NSURLSessionManagerBaseSet];
    
    [requestManager POST:requestUrl parameters:dictMData constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (imageArr.count > 0) {
            int num = 0;
            for (NSData *img_data in imageArr) {
                num++;
                // 上传文件
                [formData appendPartWithFileData:img_data name:[NSString stringWithFormat:@"%@%d", imageKey, num] fileName:[NSString stringWithFormat:@"%@%d.jpg", imageKey ,num] mimeType:@"image/jpg"];
            }
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSData *responseData;
        NSString *string = [[NSString alloc] initWithData:responseObject encoding: NSUTF8StringEncoding];
        NSLog(@"string=%@", string);
        if (![paramData isEqualToString:@""]) {
            responseData = [COMMONFUNC_DECODE_DESKEY(string, ENCRYPTION_KEY) dataUsingEncoding:NSUTF8StringEncoding];
        } else {
            responseData = responseObject;
        }
        id result = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
        success(result);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

#pragma mark -- 字典形式上传图片 只支持 POST
- (void)networkRequestSuffixUrl:(NSString *)suffixUrl
                    requestDict:(NSMutableDictionary *)dictMData
               requestParamData:(NSString *)paramData
       uploadImageWithImageDict:(NSDictionary *)imageDict
                 requestSuccess:(YMNetworkingBaseUtilsSuccessBlock)success
                 requestFailure:(YMNetworkingBaseUtilsFailureBlock)failure {
    // 字符串加密
    NSString *paramData_encode = COMMONFUNC_ENCODE_DESKEY([self clearSpecialCharactersStr:paramData], ENCRYPTION_KEY);
    if (![paramData isEqualToString:@""]) {
        [dictMData setValue:paramData_encode forKey:ENCRYPTION_STRING_PARAMDATA_KEY];
    }
    
    // 请求 url
    NSString *requestUrl = [[kAppPrefixURLStr stringByAppendingString:suffixUrl] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *requestManager = [self NSURLSessionManagerBaseSet];
    
    [requestManager POST:requestUrl parameters:dictMData constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (imageDict.count>0) {
            for (NSString *keys in imageDict) {
                // 上传文件
                [formData appendPartWithFileData:[imageDict objectForKey:keys] name:keys fileName:[NSString stringWithFormat:@"%@.jpg",keys] mimeType:@"image/jpg"];
            }
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSData *responseData;
        NSString *string = [[NSString alloc] initWithData:responseObject encoding: NSUTF8StringEncoding];
        NSLog(@"string=%@", string);
        if (![paramData isEqualToString:@""]) {
            responseData = [COMMONFUNC_DECODE_DESKEY(string, ENCRYPTION_KEY) dataUsingEncoding:NSUTF8StringEncoding];
        } else {
            responseData = responseObject;
        }
        id result = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
        success(result);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

#pragma mark -- 通用接口 --  参数不加密
- (void)networkRequestMethod:(YMNetworkingBaseUtilsRequestMethod)requestMethod
            requestSuffixUrl:(NSString *)suffixUrl
                 requestDict:(NSMutableDictionary *)dictMData
              requestSuccess:(YMNetworkingBaseUtilsSuccessBlock)success
              requestFailure:(YMNetworkingBaseUtilsFailureBlock)failure {
    
    AFHTTPSessionManager *manager = [self NSURLSessionManagerNOEncodeSet];
    NSString *requestUrl = [[kAppPrefixURLStr stringByAppendingString:suffixUrl] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    switch (requestMethod) {
        case YMNetworkingBaseUtilsRequestMethodPOST:
        {
            [self postRequest:dictMData failure:failure manager:manager resquestUrl:requestUrl success:success];
        }
            break;
        case YMNetworkingBaseUtilsRequestMethodGET:
        {
            [self getRequest:dictMData failure:failure manager:manager resquestUrl:requestUrl success:success];
        }
            break;
    }
}

#pragma mark -- NSURLSessionManager 加密设置
- (AFHTTPSessionManager *)NSURLSessionManagerBaseSet {
    AFHTTPSessionManager *requestManager = [AFHTTPSessionManager manager];
    requestManager.requestSerializer = [AFJSONRequestSerializer serializer];
    //默认网络请求时间
    requestManager.requestSerializer.timeoutInterval = kNetworkingRequestTimeOutPeriod;
    //申明返回的结果是json类型
    requestManager.responseSerializer = [AFJSONResponseSerializer serializer];
    requestManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    requestManager.responseSerializer.acceptableContentTypes = RESQUEST_JSON_TYPE;
    return requestManager;
}

#pragma mark -- NSURLSessionManager 不加密设置
- (AFHTTPSessionManager *)NSURLSessionManagerNOEncodeSet {
    AFHTTPSessionManager *requestManager = [AFHTTPSessionManager manager];
    requestManager.requestSerializer.timeoutInterval = kNetworkingRequestTimeOutPeriod; //默认网络请求时间
    requestManager.responseSerializer = [AFJSONResponseSerializer serializer]; //申明返回的结果是json类型
    requestManager.responseSerializer.acceptableContentTypes = RESQUEST_JSON_TYPE;
    return requestManager;
}

#pragma mark -- POST 请求
- (NSURLSessionDataTask * _Nullable)postRequest:(NSMutableDictionary *)dictMData failure:(YMNetworkingBaseUtilsFailureBlock)failure manager:(AFHTTPSessionManager *)manager resquestUrl:(NSString *)requestUrl success:(YMNetworkingBaseUtilsSuccessBlock)success {
    return [manager POST:requestUrl parameters:dictMData progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

#pragma mark -- GET 请求
- (NSURLSessionDataTask * _Nullable)getRequest:(NSMutableDictionary *)dictMData failure:(YMNetworkingBaseUtilsFailureBlock)failure manager:(AFHTTPSessionManager *)manager resquestUrl:(NSString *)requestUrl success:(YMNetworkingBaseUtilsSuccessBlock)success {
    return [manager GET:requestUrl parameters:dictMData progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

#pragma mark -- 去除特殊字符
- (NSString *)clearSpecialCharactersStr:(NSString *)specialChar {
    return [[[specialChar stringByReplacingOccurrencesOfString:@"\"" withString:@"”"] stringByReplacingOccurrencesOfString:@";" withString:@"；" ] stringByReplacingOccurrencesOfString:@"'" withString:@"‘"];
}
@end
