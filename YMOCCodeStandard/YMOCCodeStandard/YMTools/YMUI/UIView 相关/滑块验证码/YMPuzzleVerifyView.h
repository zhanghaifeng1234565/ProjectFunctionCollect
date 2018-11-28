//
//  YMPuzzleVerifyView.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/28.
//  Copyright © 2018 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class YMPuzzleVerifyView;
typedef NS_ENUM(NSInteger, YMPuzzleVerifyStyle) {
    YMPuzzleVerifyStyleClassic,   // 默认
    YMPuzzleVerifyStyleSquare,    // 矩形
    YMPuzzleVerifyStyleCircle,    // 圆形
    YMPuzzleVerifyStyleCustom     // 自定义
};

@interface YMPuzzleVerifyView : UIView

/** 验证码图片 */
@property (nonatomic, strong) UIImage *image;
/** 布局区域距父视图的内边距（默认 UIEdgeInsetsZero） */
@property (nonatomic, assign) UIEdgeInsets containerInsert;
/** 验证容差值，意思是滑块与空白部分重合偏差在该值范围内即视为验证成功（默认 5.f）*/
@property (nonatomic, assign) CGFloat tolerance;
/** 横向平移百分比值（0.f ~ 1.f） */
@property (nonatomic, assign) CGFloat translation;

/** 是否通过验证 */
@property (nonatomic, readonly, assign) BOOL isVerified;
/** 是否可用 */
@property (nonatomic, assign, getter=isEnable) BOOL enable;

/** 滑块风格（具体指滑块的形状） */
@property (nonatomic, assign) YMPuzzleVerifyStyle style;
/** 滑块的大小（默认 40.f）*/
@property (nonatomic, assign) CGSize puzzleSize;
/** 自定义滑块形状（仅当 style == YMVerifyPuzzleStyleCustom 时有效）*/
@property (nonatomic, strong) UIBezierPath *puzzlePath;

/** 指定初始化 */
- (instancetype)initWithFrame:(CGRect)frame style:(YMPuzzleVerifyStyle)style NS_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

/** 刷新验证码 */
- (void)refresh;
/**
 检查验证结果
 
 @param result 结果回调
 @param animated 是否显示动画
 */
- (void)checkVerificationResults:(nullable void (^)(BOOL isVerified))result animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
