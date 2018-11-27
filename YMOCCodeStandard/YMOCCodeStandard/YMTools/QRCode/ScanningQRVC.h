//
//  ScanningQRVC.h
//  OA
//
//  Created by iOS开发 on 2018/11/21.
//  Copyright © 2018年 iOS开发. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScanningQRVC : UIViewController

@property (nonatomic, copy) void(^scanningSuccess)(NSString *QRCodeStr);

/** 是否是 push */
@property (nonatomic, assign, getter=isPush) BOOL push;

@end

NS_ASSUME_NONNULL_END
