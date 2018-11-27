//
//  AppDelegate+YMLocalNotification.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/27.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "AppDelegate.h"
#import <PushKit/PushKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (YMLocalNotification)
<PKPushRegistryDelegate>

//- (void)registerUserNotification;
//- (void)sendNotification;
- (void)registerPushKit;

@end

NS_ASSUME_NONNULL_END
