//
//  YMStarControlView.h
//  YMDoctorClient
//
//  Created by iOS on 2018/7/6.
//  Copyright © 2018年 iOS. All rights reserved.
//
/*
 
 YMStarControlView *starView = [[YMStarControlView alloc] initWithFrame:CGRectMake((MainScreenWidth - 80) / 2, self.codeLabel.bottom + 30, 80, 15) delegate:self touchMoveIsEnable:YES fullStarName:@"yellow_star" emptyStarName:@"gray_star" maxScore:5 sartMargin:2]
 [self.contentView addSubview:starView];
 [starView setScore:3];
 
 - (void)starRatingView:(YMStarControlView *)view score:(CGFloat)score{
 NSLog(@"score = %f",score);
 }
 
 */
#import <UIKit/UIKit.h>

@class YMStarControlView;
@protocol YMStarControlViewDelegate <NSObject>

@optional
/**
 *  代理方法
 *
 *  @param view  星星视图
 *  @param score 当前分值
 */
-(void)starRatingView:(YMStarControlView *)view score:(CGFloat)score;

@end
@interface YMStarControlView : UIView

/**
 重写父类的init方法

 @param frame 星星控件的frame
 @param starRatingViewDelegate 代理
 @param enable 滑动评分是否可用
 @param fullStarName 星星颜色满色
 @param emptyStarName 星星颜色空色
 @param maxScore 最大星星数量
 @param starMargin 星星间距
 @return 自己
 */
- (instancetype)initWithFrame:(CGRect)frame delegate:(id)starRatingViewDelegate touchMoveIsEnable:(BOOL)enable fullStarName:(NSString *)fullStarName emptyStarName:(NSString *)emptyStarName maxScore:(CGFloat)maxScore sartMargin:(CGFloat)starMargin;

@property (nonatomic, weak) id <YMStarControlViewDelegate> delegate;

/** 是否可以滑动评分  YES:可以  NO:不可以 */
@property (nonatomic, assign) BOOL enable;
/** 设置分值 */
@property (nonatomic,assign) CGFloat score;
@end
