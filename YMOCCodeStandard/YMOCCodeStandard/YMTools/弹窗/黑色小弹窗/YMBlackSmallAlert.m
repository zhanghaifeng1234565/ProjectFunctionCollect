//
//  YMBlackSmallAlert.m
//  YMUICommonlyUsedTools
//
//  Created by iOS on 2018/5/24.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMBlackSmallAlert.h"

@implementation YMBlackSmallAlert
#pragma mark -- 黑色小弹窗
+ (void)showAlertWithMessage:(NSString *)message time:(NSTimeInterval)time {    
    for (UIView *view in [[UIApplication sharedApplication].keyWindow subviews]) {
        if (view.tag == 10000) {
            return;
        }
    }
    
    UILabel *messageLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 120,  MainScreenWidth, 45)];
    messageLable.numberOfLines = 0;
    
    CGRect size = [message boundingRectWithSize:CGSizeMake(MainScreenWidth - 60, MainScreenHeight)options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil];
    if (size.size.height < 40) {
        size.size.height = 40;
    }
    
    messageLable.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - size.size.width -  40) /2, ([UIScreen mainScreen].bounds.size.height - size.size.height) / 2, size.size.width + 40, size.size.height);
    if (MainScreenWidth == 480) {
        messageLable.top = 180;
    }
    [messageLable setTag:10000];
    
    messageLable.backgroundColor = [UIColor grayColor];
    [messageLable setTextAlignment:NSTextAlignmentCenter];
    [messageLable setTextColor:[UIColor whiteColor]];
    [messageLable setText:message];
    messageLable.layer.cornerRadius = 7;
    messageLable.clipsToBounds = YES;
    [messageLable setAdjustsFontSizeToFitWidth:YES];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication].keyWindow addSubview:messageLable];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)( 0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:time animations:^{
            messageLable.transform = CGAffineTransformMakeScale(0.5, 0.5);
            messageLable.alpha = 0;
        } completion:^(BOOL finished) {
            [messageLable removeFromSuperview];
        }];
    });
}
@end
