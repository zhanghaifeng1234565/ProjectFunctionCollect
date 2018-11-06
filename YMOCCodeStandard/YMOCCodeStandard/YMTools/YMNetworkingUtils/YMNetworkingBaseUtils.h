//
//  YMNetworkingBaseUtils.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/9/17.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, YMNetworkingBaseUtilsRequestMethod) {
    /** 默认 POST 请求 */
    YMNetworkingBaseUtilsRequestMethodPOST = 0,
    /** GET 请求 */
    YMNetworkingBaseUtilsRequestMethodGET = 1,
};

/** 成功 */
typedef void(^YMNetworkingBaseUtilsSuccessBlock)(id result);
/** 失败 */
typedef void(^YMNetworkingBaseUtilsFailureBlock)(NSError *error);

/** 网络请求工具基类 */
@interface YMNetworkingBaseUtils : NSObject

/** 网络请求成功回调 */
@property (nonatomic, copy) YMNetworkingBaseUtilsSuccessBlock ymNetworkingBaseUtilsSuccessBlock;
/** 网络请求失败回调 */
@property (nonatomic, copy) YMNetworkingBaseUtilsFailureBlock ymNetworkingBaseUtilsFailureBlock;

/**
 单例全局持有

 @return self
 */
+ (instancetype)shareManager;

/**
 通用网络请求接口参数加密
 
 @param resquestMethod 请求方式
 @param suffixUrl 请求链接
 @param dictMData 请求参数 不加密
 @param paramData 请求参数 加密
 @param success 成功回调
 @param failure 失败回调
 */
- (void)networkRequestMethod:(YMNetworkingBaseUtilsRequestMethod)resquestMethod
            requestSuffixUrl:(NSString *)suffixUrl
                 requestDict:(NSMutableDictionary *)dictMData
            requestParamData:(NSString *)paramData
              requestSuccess:(YMNetworkingBaseUtilsSuccessBlock)success
              requestFailure:(YMNetworkingBaseUtilsFailureBlock)failure;

/**
 通用网络请求接口参数加密 数组形式上传图片 仅支持 POST
 
 @param suffixUrl 请求 url 后缀
 @param dictMData 请求参数 不加密
 @param paramData 请求参数加密
 @param imageArr 图片数组
 @param imageKey 图片上传 key 如果为空 默认 thumb 上传头像传入 avatar
 @param success 成功回调
 @param failure 失败回调
 */
- (void)networkRequestSuffixUrl:(NSString *)suffixUrl
                 requestDict:(NSMutableDictionary *)dictMData
            requestParamData:(NSString *)paramData
        uploadImageWithArray:(NSArray *)imageArr
                       imageKey:(NSString *)imageKey
              requestSuccess:(YMNetworkingBaseUtilsSuccessBlock)success
              requestFailure:(YMNetworkingBaseUtilsFailureBlock)failure;

/**
 通用网络请求接口参数加密 字典形式上传图片 仅支持 POST

 @param suffixUrl 请求 url 后缀
 @param dictMData 请求参数 不加密
 @param paramData 请求参数加密
 @param imageDict 图片字典
 @param success 成功回调
 @param failure 失败回调
 */
- (void)networkRequestSuffixUrl:(NSString *)suffixUrl
                    requestDict:(NSMutableDictionary *)dictMData
               requestParamData:(NSString *)paramData
           uploadImageWithImageDict:(NSDictionary *)imageDict
                 requestSuccess:(YMNetworkingBaseUtilsSuccessBlock)success
                 requestFailure:(YMNetworkingBaseUtilsFailureBlock)failure;

/**
 通用网络请求接口参数不加密

 @param requestMethod 请求方式
 @param suffixUrl 请求链接
 @param dictMData 请求参数 不加密
 @param success 成功回调
 @param failure 失败回调
 */
- (void)networkRequestMethod:(YMNetworkingBaseUtilsRequestMethod)requestMethod
            requestSuffixUrl:(NSString *)suffixUrl
                 requestDict:(NSMutableDictionary *)dictMData
              requestSuccess:(YMNetworkingBaseUtilsSuccessBlock)success
              requestFailure:(YMNetworkingBaseUtilsFailureBlock)failure;

@end

