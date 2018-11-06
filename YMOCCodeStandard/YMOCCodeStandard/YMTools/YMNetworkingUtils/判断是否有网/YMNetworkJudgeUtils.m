//
//  YMNetworkJudgeUtils.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/9/17.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMNetworkJudgeUtils.h"

@implementation YMNetworkJudgeUtils

#pragma mark -- 网络判断
+ (BOOL)ymNetworkJudge {
    static BOOL isHaveNetwork = YES;
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager]
     setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
         if (!(status == AFNetworkReachabilityStatusReachableViaWWAN
               || status == AFNetworkReachabilityStatusReachableViaWiFi)) {
             isHaveNetwork = NO;
         } else {
             isHaveNetwork = YES;
         }
     }];
    return isHaveNetwork;
}
@end
