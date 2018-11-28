//
//  YMQRViewController.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/16.
//  Copyright © 2018 iOS. All rights reserved.
//

/*
 * 毛玻璃效果 iOS 8.0 以后使用 UIVisualEffectView
 
 UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
 UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
 effectView.frame = CGRectMake(0, 0, self.view.frame.size.width * 0.5, self.view.frame.size.height);
 [self.view addSubview:effectView];
 
 */

#import "YMBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

/** 二维码图片 */
@interface YMQRViewController : YMBaseViewController

@end

NS_ASSUME_NONNULL_END
