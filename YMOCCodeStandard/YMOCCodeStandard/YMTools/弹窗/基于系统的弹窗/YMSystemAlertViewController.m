//
//  YMSystemAlertViewController.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/10/23.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMSystemAlertViewController.h"

@implementation YMSystemAlertViewController

#pragma mark --
+ (void)ymSystemAlertVC:(UINavigationController *)nav title:(NSString *)title message:(NSString *)message type:(UIAlertControllerStyle)type sureBlock:(void (^)(UIAlertAction * _Nonnull))sureBlock cancelBlock:(void (^)(UIAlertAction * _Nonnull))cancelBlock {
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:type];
    
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"sure" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        sureBlock(action);
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        cancelBlock(action);
    }];
    
    /* title */
    NSMutableAttributedString *alertTitleStr = [[NSMutableAttributedString alloc] initWithString:title];
    [alertTitleStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, 2)];
    [alertTitleStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 2)];
    [alertVc setValue:alertTitleStr forKey:@"attributedTitle"];
    
    /* message */
    NSMutableAttributedString *alertMessageStr = [[NSMutableAttributedString alloc] initWithString:message];
    [alertMessageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0, 3)];
    [alertMessageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(3, 2)];
    [alertMessageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(5, 2)];
    [alertMessageStr addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(0, 3)];
    [alertMessageStr addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(3, 2)];
    [alertMessageStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5, 2)];
    [alertVc setValue:alertMessageStr forKey:@"attributedMessage"];
    
    /* 取消按钮的颜色 */
    [cancel setValue:[UIColor redColor] forKey:@"_titleTextColor"];
    /* 确定按钮的颜色 */
    [sure setValue:[UIColor magentaColor] forKey:@"_titleTextColor"];
    
    [alertVc addAction:cancel];
    [alertVc addAction:sure];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [nav presentViewController:alertVc animated:YES completion:nil];
    });
}

+ (void)ymSystemSavePictureAlertVC:(UINavigationController *)nav title:(NSString *)title message:(NSString *)message type:(UIAlertControllerStyle)type sureBlock:(void (^)(UIAlertAction * _Nonnull))sureBlock cancelBlock:(void (^)(UIAlertAction * _Nonnull))cancelBlock {
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:type];
    
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        sureBlock(action);
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        cancelBlock(action);
    }];
    
    /* title */
    NSMutableAttributedString *alertTitleStr = [[NSMutableAttributedString alloc] initWithString:title];
    [alertTitleStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, 2)];
    [alertTitleStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 2)];
    [alertVc setValue:alertTitleStr forKey:@"attributedTitle"];
    
    /* message */
    NSMutableAttributedString *alertMessageStr = [[NSMutableAttributedString alloc] initWithString:message];
    [alertMessageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0, 3)];
    [alertMessageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(3, 2)];
    [alertMessageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(5, 2)];
    [alertMessageStr addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(0, 3)];
    [alertMessageStr addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(3, 2)];
    [alertMessageStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5, 2)];
    [alertVc setValue:alertMessageStr forKey:@"attributedMessage"];
    
    /* 取消按钮的颜色 */
    [cancel setValue:[UIColor redColor] forKey:@"_titleTextColor"];
    /* 确定按钮的颜色 */
    [sure setValue:[UIColor magentaColor] forKey:@"_titleTextColor"];
    
    [alertVc addAction:cancel];
    [alertVc addAction:sure];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [nav presentViewController:alertVc animated:YES completion:nil];
    });
}
@end
