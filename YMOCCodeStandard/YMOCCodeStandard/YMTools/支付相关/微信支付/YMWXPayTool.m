//
//  YMWXPayTool.m
//  微信支付
//
//  Created by iOS on 2018/11/21.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "YMWXPayTool.h"
#import <YYModel.h>

@implementation YMWXPayTool

#pragma mark - 微信支付判断是否安装微信
+ (void)ymWXPayWithParameterDict:(NSDictionary *)paramDict {
    if (![WXApi isWXAppInstalled]) {
        [self showAlertWithTitle:@"支付失败！" message:@"抱歉！您未安装微信"];
        return;
    } else {
        [self ymWXPayNetworkWithParmaDict:paramDict];
    }
}

#pragma mark 请求网络
+ (void)ymWXPayNetworkWithParmaDict:(NSDictionary *)parmaDict {
    
    // 网络请求
//    [[NetWorkingTool shareManager] postHttpWithURL:@"" Parameter:parmaDict Success:^(NSURLSessionDataTask *operation, id responseObject) {
//
//        YMWXPayModel *model = [YMWXPayModel yy_modelWithJSON:responseObject];
//        [self ymWXPayWithModel:model];
//    } Failure:^(BOOL isHaveNetwork, NSError *error) {
//
//    }];
}

#pragma mark 唤起微信
+ (void)ymWXPayWithModel:(YMWXPayModel *)model {
    
    NSDictionary *order = [model yy_modelToJSONObject];
    PayReq *req = [PayReq yy_modelWithJSON:order];
    if ([WXApi sendReq:req]) { //发送请求到微信，等待微信返回onResp
        NSLog(@"调起微信成功...");
    } else {
        [self showAlertWithTitle:@"支付失败！" message:@"抱歉！调起微信失败"];
    }
}

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    });
}

@end




/** 微信支付模型 */
@implementation YMWXPayModel


@end
