//
//  YMSliderVerifyAlertView.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/28.
//  Copyright © 2018 iOS. All rights reserved.
//
/*
 
 YMSliderVerifyAlertView *verifyView = [[YMSliderVerifyAlertView alloc] initWithMaximumVerifyNumber:3 results:^(YMSliderVerifyState state) {
 NSLog(@"%zd", state);
 }];
 [verifyView show];
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, YMSliderVerifyState) {
    /** 未验证（弹出验证码弹窗后，用户未进行验证，直接点击关闭按钮）） */
    YMSliderVerifyStateNot,
    /** 验证失败（达到验证失败次数上限） */
    YMSliderVerifyStateFail,
    /** 验证成功（在允许的最大验证失败次数内，通过验证） */
    YMSliderVerifyStateSuccess,
    /** 未完成验证（未达到允许的最大验证失败次数，点击了关闭按钮） */
    YMSliderVerifyStateIncomplete,
};

typedef void(^YMSliderVerificationResults)(YMSliderVerifyState state);

@interface YMSliderVerifyAlertView : UIView

/** 验证状态 */
@property (nonatomic, readonly) YMSliderVerifyState state;
/** 最大验证次数（默认 1，最小值 1） */
@property (nonatomic) NSUInteger maximumVerifyNumber;
/** 验证结果回调 */
@property (nullable, nonatomic, copy) YMSliderVerificationResults results;

/**
 指定初始化
 
 @param maxNumber 最大验证次数
 @param results 验证结果回调
 @return 实例对象
 */
- (instancetype)initWithMaximumVerifyNumber:(NSUInteger)maxNumber results:(nullable YMSliderVerificationResults)results NS_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

/** 弹出 */
- (void)show;

@end

NS_ASSUME_NONNULL_END
