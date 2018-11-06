//
//  YMLoadingViewNetworkUtils.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/9/17.
//  Copyright © 2018年 iOS. All rights reserved.
//
/**
 // 仅仅是模拟参数，具体根据实际情况而定，这里的示例会请求失败
 
 NSMutableDictionary *dictM = [[NSMutableDictionary alloc] init];
 [dictM setValue:@"action" forKey:@"action"];
 
 [[YMLoadingViewNetworkUtils shareManager] ymLoadingViewNetworkUtilsWithParentView:self.view POSTRequestWithSuffixUrl:homeSuffix requestDict:dictM requestSuccess:^(id result) {
 NSLog(@"result===%@", result);
 YMHomeModel *model = [YMHomeModel mj_objectWithKeyValues:result];
 self.model = model;
 } requestFailure:^(NSError *error) {
 
 }];
 */

#import <UIKit/UIKit.h>

/** 成功 */
typedef void(^YMLoadingViewNetworkUtilsSuccessBlcok)(id result);
/** 失败 */
typedef void(^YMLoadingViewNetworkUtilsFailureBlcok)(NSError *error);

@interface YMLoadingViewNetworkUtils : NSObject

/** 成功回调 */
@property (nonatomic, copy) YMLoadingViewNetworkUtilsSuccessBlcok ymLoadingViewNetworkUtilsSuccessBlcok;
/** 失败回调 */
@property (nonatomic, copy) YMLoadingViewNetworkUtilsFailureBlcok ymLoadingViewNetworkUtilsFailureBlcok;

/**
 单例

 @return self
 */
+ (instancetype)shareManager;

/**
 带有 loadingView 的网络请求 参数加密

 @param parentView 要覆盖的视图
 @param suffixUrl 网络请求后缀
 @param dictMData 参数不加密
 @param paramData 参数加密
 @param success 成功回调
 @param failure 失败回调
 */
- (void)ymLoadingViewNetworkUtilsWithParentView:(UIView *)parentView
                       POSTRequestWithSuffixUrl:(NSString *)suffixUrl
                                    requestDict:(NSMutableDictionary *)dictMData
                               requestParamData:(NSString *)paramData
                                 requestSuccess:(YMLoadingViewNetworkUtilsSuccessBlcok)success
                                 requestFailure:(YMLoadingViewNetworkUtilsFailureBlcok)failure;

/**
 带有 loadingView 的网络请求 数组形式上传图片
 
 @param suffixUrl 请求 url 后缀
 @param dictMData 请求参数 不加密
 @param paramData 请求参数加密
 @param imageArr 图片数组
 @param imageKey 图片上传 key 如果为空 默认 thumb 上传头像传入 avatar
 @param success 成功回调
 @param failure 失败回调
 */
- (void)ymLoadingViewNetworkUtilsWithParentView:(UIView *)parentView
                       POSTRequestWithSuffixUrl:(NSString *)suffixUrl
                                    requestDict:(NSMutableDictionary *)dictMData
                               requestParamData:(NSString *)paramData
                           uploadImageWithArray:(NSArray *)imageArr
                                       imageKey:(NSString *)imageKey
                                 requestSuccess:(YMLoadingViewNetworkUtilsSuccessBlcok)success
                                 requestFailure:(YMLoadingViewNetworkUtilsFailureBlcok)failure;

/**
 带有 loadingView 的网络请求 字典形式上传图片
 
 @param suffixUrl 请求 url 后缀
 @param dictMData 请求参数 不加密
 @param paramData 请求参数加密
 @param imageDict 图片字典
 @param success 成功回调
 @param failure 失败回调
 */
- (void)ymLoadingViewNetworkUtilsWithParentView:(UIView *)parentView
                       POSTRequestWithSuffixUrl:(NSString *)suffixUrl
                                    requestDict:(NSMutableDictionary *)dictMData
                               requestParamData:(NSString *)paramData
                       uploadImageWithImageDict:(NSDictionary *)imageDict
                                 requestSuccess:(YMNetworkingSecondaryPackageSuccessBlcok)success
                                 requestFailure:(YMNetworkingSecondaryPackageFailureBlcok)failure;

/**
 带有 loadingView 的网络请求 参数不加密
 
 @param parentView 要覆盖的视图
 @param suffixUrl 网络请求后缀
 @param dictMData 参数不加密
 @param success 成功回调
 @param failure 失败回调
 */
- (void)ymLoadingViewNetworkUtilsWithParentView:(UIView *)parentView
                       POSTRequestWithSuffixUrl:(NSString *)suffixUrl
                                    requestDict:(NSMutableDictionary *)dictMData
                                 requestSuccess:(YMLoadingViewNetworkUtilsSuccessBlcok)success
                                 requestFailure:(YMLoadingViewNetworkUtilsFailureBlcok)failure;
@end
