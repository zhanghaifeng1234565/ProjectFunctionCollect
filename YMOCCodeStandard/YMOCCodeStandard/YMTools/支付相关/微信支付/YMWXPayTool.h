//
//  YMWXPayTool.h
//  微信支付
//
//  Created by iOS on 2018/11/21.
//  Copyright © 2018 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WXApi.h>
#import <WXApiObject.h>

NS_ASSUME_NONNULL_BEGIN

@interface YMWXPayTool : NSObject

/**
 微信支付

 @param paramDict 请求参数
 */
+ (void)ymWXPayWithParameterDict:(NSDictionary *)paramDict;

@end

/** 微信支付模型 */
@interface YMWXPayModel : NSObject

//由用户微信号和AppID组成的唯一标识，用于校验微信用户
@property (nonatomic, copy) NSString *openID;
// 商家id，在注册的时候给的
@property (nonatomic, copy) NSString *partnerId;
// 预支付订单这个是后台跟微信服务器交互后，微信服务器传给你们服务器的，你们服务器再传给你
@property (nonatomic, copy) NSString *prepayId;
// 根据财付通文档填写的数据和签名
@property (nonatomic, copy) NSString *package;
// 随机编码，为了防止重复的，在后台生成
@property (nonatomic, copy) NSString *nonceStr;
// 这个是时间戳，也是在后台生成的，为了验证支付的
@property (nonatomic, copy) NSString *timeStamp;
// 这个签名也是后台做的
@property (nonatomic, copy) NSString *sign;

@end

NS_ASSUME_NONNULL_END
