//
//  YMLoadingViewNetworkUtils.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/9/17.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMLoadingViewNetworkUtils.h"

/** 屏幕宽度 */
#define YM_MAINSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
/** 屏幕高度 */
#define YM_MAINSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

/** 没有网络 */
static NSString *kNONetworkMessageStr = @"网络请求失败，请检查网络连接！";
/** 请求失败 */
static NSString *kErrorOfNetworkMessageStr = @"数据加载失败！";
/** 账号被顶 */
static NSString *kAccontBeForcedStr = @"账号在其他设备登录，是否重新登录";

@interface YMLoadingViewNetworkUtils ()

/** 加载视图 */
@property (nonatomic, strong) YMLoadingView *ymLoadingView;

/** loading 父视图 */
@property (nonatomic, strong) UIView *ymLoadingParentView;
/** 网络请求后缀 */
@property (nonatomic, copy) NSString *suffixUrl;
/** 不加密请求参数 */
@property (nonatomic, strong) NSMutableDictionary *dictMData;
/** 加密请求参数 如果为 nil 代表是 不加密 否则 代表加密 */
@property (nonatomic, copy) NSString *paramData;
/** 图片数组 */
@property (nonatomic, strong) NSArray *imageArr;
/** 图片字典 */
@property (nonatomic, strong) NSDictionary *imageDict;
/** 上传图片 key */
@property (nonatomic, copy) NSString *imageKey;

@end

@implementation YMLoadingViewNetworkUtils

+ (instancetype)shareManager {
    static id _instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

#pragma mark -- 带有 Loading 的网络工具
#pragma mark -- 请求网络参数加密
- (void)ymLoadingViewNetworkUtilsWithParentView:(UIView *)parentView
                       POSTRequestWithSuffixUrl:(NSString *)suffixUrl
                                    requestDict:(NSMutableDictionary *)dictMData
                               requestParamData:(NSString *)paramData
                                 requestSuccess:(YMLoadingViewNetworkUtilsSuccessBlcok)success
                                 requestFailure:(YMLoadingViewNetworkUtilsFailureBlcok)failure {
    self.ymLoadingParentView = parentView;
    self.suffixUrl = suffixUrl;
    self.dictMData = dictMData;
    self.paramData = paramData;
    self.imageArr = [[NSArray alloc] init];
    self.imageKey = @"";
    self.imageDict = [[NSDictionary alloc] init];
    
    _ymLoadingViewNetworkUtilsSuccessBlcok = success;
    _ymLoadingViewNetworkUtilsFailureBlcok = failure;
    
    [self requestNetSuccess:success];
}

#pragma mark -- 请求网络参数不加密
- (void)ymLoadingViewNetworkUtilsWithParentView:(UIView *)parentView
                       POSTRequestWithSuffixUrl:(NSString *)suffixUrl
                                    requestDict:(NSMutableDictionary *)dictMData
                                 requestSuccess:(YMLoadingViewNetworkUtilsSuccessBlcok)success
                                 requestFailure:(YMLoadingViewNetworkUtilsFailureBlcok)failure {
    self.ymLoadingParentView = parentView;
    self.suffixUrl = suffixUrl;
    self.dictMData = dictMData;
    self.paramData = nil;
    self.imageArr = [[NSArray alloc] init];
    self.imageKey = @"";
    self.imageDict = [[NSDictionary alloc] init];
    
    _ymLoadingViewNetworkUtilsSuccessBlcok = success;
    _ymLoadingViewNetworkUtilsFailureBlcok = failure;
    
    [self requestNetSuccess:success];
}

#pragma mark -- 上传图片 数组形式
- (void)ymLoadingViewNetworkUtilsWithParentView:(UIView *)parentView
                       POSTRequestWithSuffixUrl:(NSString *)suffixUrl
                                    requestDict:(NSMutableDictionary *)dictMData
                               requestParamData:(NSString *)paramData
                           uploadImageWithArray:(NSArray *)imageArr
                                       imageKey:(NSString *)imageKey
                                 requestSuccess:(YMLoadingViewNetworkUtilsSuccessBlcok)success
                                 requestFailure:(YMLoadingViewNetworkUtilsFailureBlcok)failure {
    self.ymLoadingParentView = parentView;
    self.suffixUrl = suffixUrl;
    self.dictMData = dictMData;
    self.paramData = paramData;
    self.imageArr = [[NSArray alloc] initWithArray:imageArr];
    self.imageKey = imageKey;
    self.imageDict = [[NSDictionary alloc] init];
    
    _ymLoadingViewNetworkUtilsSuccessBlcok = success;
    _ymLoadingViewNetworkUtilsFailureBlcok = failure;
    
    [self requestNetSuccess:success];
}

#pragma mark -- 图片字典形式上传
- (void)ymLoadingViewNetworkUtilsWithParentView:(UIView *)parentView
                       POSTRequestWithSuffixUrl:(NSString *)suffixUrl
                                    requestDict:(NSMutableDictionary *)dictMData
                               requestParamData:(NSString *)paramData
                       uploadImageWithImageDict:(NSDictionary *)imageDict
                                 requestSuccess:(YMNetworkingSecondaryPackageSuccessBlcok)success
                                 requestFailure:(YMNetworkingSecondaryPackageFailureBlcok)failure {
    self.ymLoadingParentView = parentView;
    self.suffixUrl = suffixUrl;
    self.dictMData = dictMData;
    self.paramData = paramData;
    self.imageArr = [[NSArray alloc] init];
    self.imageKey = @"";
    self.imageDict = [[NSDictionary alloc] initWithDictionary:imageDict];
    
    _ymLoadingViewNetworkUtilsSuccessBlcok = success;
    _ymLoadingViewNetworkUtilsFailureBlcok = failure;
    
    [self requestNetSuccess:success];
}

#pragma mark -- 请求网络
- (void)requestNetSuccess:(YMLoadingViewNetworkUtilsSuccessBlcok)success {
    [self.ymLoadingParentView addSubview:self.ymLoadingView];
    
    if (![YMNetworkJudgeUtils ymNetworkJudge]) {
        [YMBlackSmallAlert showAlertWithMessage:kNONetworkMessageStr time:2.0f];
        self.ymLoadingView.loadNetFail = YES;
        self.ymLoadingView.loadFailStatus = YES;
        [self.ymLoadingView.clickBtn addTarget:self action:@selector(clickRefreshData) forControlEvents:UIControlEventTouchUpInside];
        return;
    }
    
    /// MARK: 图片数组形式上传
    BOOL imageArrIsExist = self.imageArr.count > 0 ? YES : NO;
    if (imageArrIsExist == YES) {
        [YMNetworkingSecondaryPackage POSTRequestWithSuffixUrl:self.suffixUrl requestDict:self.dictMData requestParamData:self.paramData uploadImageWithArray:self.imageArr imageKey:self.imageKey requestSuccess:^(id result) {
            [self requestSuccessMethod:result success:success];
        } requestFailure:^(NSError *error) {
            [self requestFailureMethod];
        }];
        return;
    }
    
    /// MARK: 图片字典形式上传
    BOOL imageDictIsExist = self.imageDict.count > 0 ? YES : NO;
    if (imageDictIsExist == YES) {
        [YMNetworkingSecondaryPackage POSTRequestWithSuffixUrl:self.suffixUrl requestDict:self.dictMData requestParamData:self.paramData uploadImageWithImageDict:self.imageDict requestSuccess:^(id result) {
            [self requestSuccessMethod:result success:success];
        } requestFailure:^(NSError *error) {
            [self requestFailureMethod];
        }];
        return;
    }
    
    /// MARK: 此时不加密请求
    if (self.paramData == nil) {
        [YMNetworkingSecondaryPackage POSTRequestWithSuffixUrl:self.suffixUrl requestDict:self.dictMData requestSuccess:^(id result) {
            [self requestSuccessMethod:result success:success];
        } requestFailure:^(NSError *error) {
            [self requestFailureMethod];
        }];
        return;
    }
    
    /// MARK: 加密参数请求
    [YMNetworkingSecondaryPackage POSTRequestWithSuffixUrl:self.suffixUrl requestDict:self.dictMData requestParamData:self.paramData requestSuccess:^(id result) {
        [self requestSuccessMethod:result success:success];
    } requestFailure:^(NSError *error) {
        [self requestFailureMethod];
    }];
}

#pragma mark -- 重新请求方法
- (void)clickRefreshData {
    if (self.ymLoadingView.isLoadNetFail == YES) {
        self.ymLoadingView.loadNetFail = NO;
        [self requestNetSuccess:self.ymLoadingViewNetworkUtilsSuccessBlcok];
    }
}

#pragma mark -- 数据加载成功方法
- (void)requestSuccessMethod:(id)result success:(YMLoadingViewNetworkUtilsSuccessBlcok)success {
    if ([result[@"status"] integerValue] == 1) {
        [self.ymLoadingView removeFromSuperview];
        success(result);
    } else if ([result[@"status"] integerValue] == 2) {
        [YMBlackSmallAlert showAlertWithMessage:kAccontBeForcedStr time:2.0f];
    } else {
        [YMBlackSmallAlert showAlertWithMessage:[NSString stringWithFormat:@"%@", result[@"msg"]] time:2.0f];
        self.ymLoadingView.loadNetFail = YES;
        self.ymLoadingView.loadFailStatus = NO;
        [self.ymLoadingView.clickBtn addTarget:self action:@selector(clickRefreshData) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark -- 数据加载失败方法
- (void)requestFailureMethod {
    [YMBlackSmallAlert showAlertWithMessage:kErrorOfNetworkMessageStr time:2.0f];
    self.ymLoadingView.loadNetFail = YES;
    self.ymLoadingView.loadFailStatus = NO;
    [self.ymLoadingView.clickBtn addTarget:self action:@selector(clickRefreshData) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark -- lazyLoadUI
- (YMLoadingView *)ymLoadingView {
    if (_ymLoadingView == nil) {
        _ymLoadingView = [[YMLoadingView alloc] initWithFrame:CGRectMake(0, 0, YM_MAINSCREEN_WIDTH, YM_MAINSCREEN_HEIGHT)];
    }
    return _ymLoadingView;
}

#pragma mark -- getter
- (NSMutableDictionary *)dictMData {
    if (_dictMData == nil) {
        _dictMData = [[NSMutableDictionary alloc] init];
    }
    return _dictMData;
}
@end
