//
//  YMPuzzlePathMaker.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/28.
//  Copyright © 2018 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZKPuzzlePathMaker;

typedef NS_ENUM(NSInteger, YMPathMirrorAxis) {
    YMPathMirrorAxisX,  // x 轴镜像
    YMPathMirrorAxisY   // y 轴镜像
};

@interface YMPuzzlePathMaker : NSObject

/** 原始路径 */
@property (nonatomic, strong) UIBezierPath *path;

/** 移动画笔至点 */
@property (nonatomic, copy) YMPuzzlePathMaker *(^moveTo)(CGFloat x, CGFloat y);
/** 添加直线 */
@property (nonatomic, copy) YMPuzzlePathMaker *(^addLineTo)(CGFloat x, CGFloat y);
/** 添加一次贝塞尔曲线 */
@property (nonatomic, copy) YMPuzzlePathMaker *(^addQuadCurveTo)(CGFloat endX, CGFloat endY, CGFloat controlX, CGFloat controlY);
/** 添加二次贝塞尔曲线 */
@property (nonatomic, copy) YMPuzzlePathMaker *(^addCurveTo)(CGFloat endX, CGFloat endY, CGFloat controlX1, CGFloat controlY1, CGFloat controlX2, CGFloat controlY2);
/** 添加弧线 */
@property (nonatomic, copy) YMPuzzlePathMaker *(^addArcWithCenter)(CGFloat centerX, CGFloat centerY, CGFloat radius, CGFloat startAngle, CGFloat endAngle, BOOL clockwise);
@property (nonatomic, copy) YMPuzzlePathMaker *(^addArcWithPoint)(CGFloat startX, CGFloat startY, CGFloat endX, CGFloat endY, CGFloat radius, BOOL clockwise, BOOL moreThanHalf);
/** 闭合曲线 */
@property (nonatomic, copy) YMPuzzlePathMaker *(^closePath)(void);
/**
 添加正弦曲线
 
 @param A 振幅
 @param Omega 角速度
 @param Phi 相位差
 @param K 偏移量
 @param deltaX 曲线横向长度
 */
@property (nonatomic, copy) YMPuzzlePathMaker *(^addSin)(CGFloat A, CGFloat Omega, CGFloat Phi, CGFloat K, CGFloat deltaX);
/** 镜像曲线 */
@property (nonatomic, copy) YMPuzzlePathMaker *(^mirror)(YMPathMirrorAxis axis, CGFloat x, CGFloat y, CGFloat width, CGFloat height);
/** 保证图形区域中心不变以比例形式缩放路径 */
@property (nonatomic, copy) YMPuzzlePathMaker *(^scale)(CGFloat scale);
/** 保证图形区域中心不变以角度旋转路径 */
@property (nonatomic, copy) YMPuzzlePathMaker *(^rotate)(CGFloat angle);
/** 平移路径 */
@property (nonatomic, copy) YMPuzzlePathMaker *(^translate)(CGFloat offsetX, CGFloat offsetY);
/** 移动路径至原点 */
@property (nonatomic ,copy) YMPuzzlePathMaker *(^moveToOrigin)(void);

/** 快捷初始化 */
- (instancetype)initWithBezierPath:(UIBezierPath *)path NS_DESIGNATED_INITIALIZER;
+ (instancetype)makerWithBezierPath:(UIBezierPath *)path;

@end

NS_ASSUME_NONNULL_END
