//
//  YMMBProgressHUD.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/10/23.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMMBProgressHUD.h"
#import "MBProgressHUD.h"

@implementation YMMBProgressHUD

#pragma mark -- 黑色小弹窗
+ (void)ymShowBlackAlert:(UIView *)parentView text:(NSString *)text afterDelay:(NSTimeInterval)afterDelay {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:parentView animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.label.textColor = [UIColor whiteColor];
    hud.label.text = text;
    hud.label.numberOfLines = 0;
    [hud hideAnimated:YES afterDelay:afterDelay];
}

#pragma mark -- 显示加载视图菊花
+ (void)ymShowLoadingAlert:(UIView *)parentView {
    [MBProgressHUD showHUDAddedTo:parentView animated:YES];
}

#pragma mark -- 隐藏加载视图
+ (void)ymHideLoadingAlert:(UIView *)parentView {
    [MBProgressHUD hideHUDForView:parentView animated:YES];
}

#pragma mark -- 自定义 loading
+ (void)ymShowCustomLoadingAlert:(UIView *)parentView text:(NSString *)text {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:parentView animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    
    NSMutableArray *imageMarr = [[NSMutableArray alloc] init];
    for (int i = 1; i < 25; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"page_loading%d", i]];
        [imageMarr addObject:image];
    }
    
    UIImage *loadingImage = [UIImage animatedImageWithImages:imageMarr duration:1];
    UIImageView *loadingImageV = [[UIImageView alloc] init];
    loadingImageV.image = loadingImage;
    [loadingImageV startAnimating];
    
    // loading 后的背景视图去掉颜色
    if ([text isEqualToString:@""]) {
        [YMMBProgressHUD recursiveObtainView:hud];
    } else {
        hud.bezelView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    hud.customView = loadingImageV;
    hud.label.text = text;
}

#pragma mark -- 递归获取所有子视图去掉颜色【去不掉颜色的就直接移除掉】
+ (void)recursiveObtainView:(UIView *)view {
    for (UIView *sub in view.subviews) {
        sub.backgroundColor = [UIColor clearColor];
        if ([sub isKindOfClass:[UIVisualEffectView class]]) {
            [sub removeFromSuperview];
        }
        [self recursiveObtainView:sub];
    }
}
@end
