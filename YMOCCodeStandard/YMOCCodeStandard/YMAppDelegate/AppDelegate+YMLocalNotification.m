//
//  AppDelegate+YMLocalNotification.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/27.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "AppDelegate+YMLocalNotification.h"

@implementation AppDelegate (YMLocalNotification)

- (void)registerUserNotification {
    //创建本地通知
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 设置通知的类型可以为弹窗提示,声音提示,应用图标数字提示
        UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
        // 授权通知
        [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
    }
}

- (void)sendNotification {
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.alertBody = @"本地通知";
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
    localNotification.alertAction = @"解锁滑动";
    localNotification.applicationIconBadgeNumber = 1;
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.userInfo = @{@"key" : @"value"};
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    // 立即发送
    // [[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];
}

#pragma mark - 取消通知
- (void)cancelLocalNotification {
    // 获取所有本地通知数组
//    NSArray *localNotifications = [UIApplication sharedApplication].scheduledLocalNotifications;
}

// 本地通知回调
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    // 前台
    if (application.applicationState == UIApplicationStateActive) {
        return;
    }
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"token" message:@"111" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:action];
    [self.window.rootViewController presentViewController:alertVC animated:YES completion:nil];
}


#pragma mark - registerPushKit
- (void)registerPushKit {
    // 创建PushKit
    PKPushRegistry *pushRegistry = [[PKPushRegistry alloc]  initWithQueue:dispatch_get_main_queue()];
    pushRegistry.delegate = self;
    pushRegistry.desiredPushTypes = [NSSet setWithObject:PKPushTypeVoIP];
    
    // 本地推送
    [self registerUserNotification];
}

#pragma mark - pushKitDelegate
- (void)pushRegistry:(PKPushRegistry *)registry didUpdatePushCredentials:(PKPushCredentials *)credentials forType:(NSString *)type {
    NSString *str = [NSString stringWithFormat:@"%@",credentials.token];
    NSString *tokenStr = [[[str stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    //上传token处理
    NSLog(@"%@", tokenStr);
}

- (void)pushRegistry:(PKPushRegistry *)registry didReceiveIncomingPushWithPayload:(PKPushPayload *)payload forType:(NSString *)type {
//    NSDictionary *alert = [payload.dictionaryPayload[@"aps"] objectForKey:@"alert"];
    // 激活APP
    [self sendNotification];
}

@end
