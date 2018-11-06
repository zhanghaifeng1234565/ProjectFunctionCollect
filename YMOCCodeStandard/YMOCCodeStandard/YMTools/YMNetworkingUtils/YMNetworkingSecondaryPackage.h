//
//  YMNetworkingSecondaryPackage.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/9/17.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 成功 */
typedef void(^YMNetworkingSecondaryPackageSuccessBlcok)(id result);
/** 失败 */
typedef void(^YMNetworkingSecondaryPackageFailureBlcok)(NSError *error);

/** 网络工具的二次封装 */
@interface YMNetworkingSecondaryPackage : NSObject

/** 请求成功回调 */
@property (nonatomic, copy) YMNetworkingSecondaryPackageSuccessBlcok ymNetworkingSecondaryPackageSuccessBlcok;
/** 请求失败回调 */
@property (nonatomic, copy) YMNetworkingSecondaryPackageFailureBlcok ymNetworkingSecondaryPackageFailureBlcok;


#pragma mark --  POST 请求

/**
 POST 请求 参数加密
 
 @param suffixUrl 请求 url 后缀
 @param dictMData 请求参数 不加密
 @param paramData 请求参数 加密
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)POSTRequestWithSuffixUrl:(NSString *)suffixUrl
                     requestDict:(NSMutableDictionary *)dictMData
                requestParamData:(NSString *)paramData
                  requestSuccess:(YMNetworkingSecondaryPackageSuccessBlcok)success
                  requestFailure:(YMNetworkingSecondaryPackageFailureBlcok)failure;

/**
 通用网络请求接口参数加密 数组形式上传图片 仅支持 POST
 只关心传入的参数内部封装好是否含有时间戳

 @param suffixUrl 请求 url 后缀
 @param dictMData 请求参数 不加密
 @param paramData 请求参数加密
 @param imageArr 图片数组
 @param imageKey 图片上传 key 如果为空 默认 thumb 上传头像传入 avatar
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)POSTRequestWithSuffixUrl:(NSString *)suffixUrl
                    requestDict:(NSMutableDictionary *)dictMData
               requestParamData:(NSString *)paramData
           uploadImageWithArray:(NSArray *)imageArr
                        imageKey:(NSString *)imageKey
                 requestSuccess:(YMNetworkingSecondaryPackageSuccessBlcok)success
                 requestFailure:(YMNetworkingSecondaryPackageFailureBlcok)failure;

/**
 通用网络请求接口参数加密 字典形式上传图片 仅支持 POST
 只关心传入的参数内部封装好是否含有时间戳
 
 @param suffixUrl 请求 url 后缀
 @param dictMData 请求参数 不加密
 @param paramData 请求参数加密
 @param imageDict 图片字典
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)POSTRequestWithSuffixUrl:(NSString *)suffixUrl
                    requestDict:(NSMutableDictionary *)dictMData
               requestParamData:(NSString *)paramData
       uploadImageWithImageDict:(NSDictionary *)imageDict
                 requestSuccess:(YMNetworkingSecondaryPackageSuccessBlcok)success
                 requestFailure:(YMNetworkingSecondaryPackageFailureBlcok)failure;

/**
 POST 请求 参数不加密

 @param suffixUrl 请求 url 后缀
 @param dictMData 请求参数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)POSTRequestWithSuffixUrl:(NSString *)suffixUrl
                     requestDict:(NSMutableDictionary *)dictMData
                  requestSuccess:(YMNetworkingSecondaryPackageSuccessBlcok)success
                  requestFailure:(YMNetworkingSecondaryPackageFailureBlcok)failure;

#pragma mark --  GET 请求

/**
 GET 请求 参数加密

 @param suffixUrl 请求 url 后缀
 @param dictMData 请求参数 不加密
 @param paramData 请求参数 加密
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)GETRequestWithSuffixUrl:(NSString *)suffixUrl
                    requestDict:(NSMutableDictionary *)dictMData
               requestParamData:(NSString *)paramData
                 requestSuccess:(YMNetworkingSecondaryPackageSuccessBlcok)success
                 requestFailure:(YMNetworkingSecondaryPackageFailureBlcok)failure;

/**
 GET 请求 参数不加密
 
 @param suffixUrl 请求 url 后缀
 @param dictMData 请求参数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)GETRequestWithSuffixUrl:(NSString *)suffixUrl
                     requestDict:(NSMutableDictionary *)dictMData
                  requestSuccess:(YMNetworkingSecondaryPackageSuccessBlcok)success
                  requestFailure:(YMNetworkingSecondaryPackageFailureBlcok)failure;
@end
