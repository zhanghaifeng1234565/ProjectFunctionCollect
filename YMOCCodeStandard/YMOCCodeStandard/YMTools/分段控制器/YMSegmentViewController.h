//
//  YMSegmentViewController.h
//  YMDoctorClient
//
//  Created by iOS on 2018/6/28.
//  Copyright © 2018年 iOS. All rights reserved.
//
/**
 #pragma mark -- 加载子控制器
 - (void)loadSubviewsControllerVc
 {
 YMMostPopulaMonthListViewController *monthVc = [[YMMostPopulaMonthListViewController alloc] init];
 monthVc.title = @"最受欢迎(月榜)";
 YMMostPopulaTotalListViewController *totalVc = [[YMMostPopulaTotalListViewController alloc] init];
 totalVc.title = @"最受欢迎(总榜)";
 [self.vcMArr addObject:monthVc];
 [self.vcMArr addObject:totalVc];
 
 YMSegmentViewController *segmentVc = [[YMSegmentViewController alloc] initWithVcMarr:self.vcMArr];
 segmentVc.tagHeight = 44.0f;
 segmentVc.sliderWidth = 60;
 segmentVc.sliderBackColor = [UIColor colorWithHexString:@"03abff"];
 segmentVc.btnNormolColor = [UIColor colorWithHexString:@"35465f"];
 segmentVc.btnSlectColor = [UIColor colorWithHexString:@"03abff"];
 segmentVc.titleScrollviewBackColor = [UIColor whiteColor];
 [self addChildViewController:segmentVc];
 [self.view addSubview:segmentVc.view];
 [segmentVc.view layoutIfNeeded];
 }
 #pragma mark -- getter
 - (NSMutableArray *)vcMArr
 {
 if (_vcMArr == nil) {
 _vcMArr = [[NSMutableArray alloc] init];
 }
 return _vcMArr;
 }
 */
#import <UIKit/UIKit.h>

@interface YMSegmentViewController : UIViewController

/** 标题滚动视图 */
@property (strong, nonatomic) UIScrollView *titleScrollView;
/** 内容滚动视图 */
@property (strong, nonatomic) UIScrollView *contentScrollView;

/** 滚动标题高度 不传默认为 48 */
@property (assign, nonatomic) CGFloat tagHeight;
/**   btn。即标签 未选中正常颜色 不传默认黑色 */
@property (nonatomic, copy) UIColor *btnNormolColor;
/**  btn 即标签 选中时颜色 不传默认红色  */
@property (nonatomic, copy) UIColor *btnSlectColor;
/** 滚动标题文字大小 不传默认为 15 */
@property (nonatomic, assign) CGFloat btnFont;
/** 滚动标题按钮间距 不传默认为 15 */
@property (nonatomic, assign) CGFloat btnTitleMargin;

/** 默认滚到的子控制器 contenoffset 不传默认为 0 */
@property (assign, nonatomic) NSInteger scrollViewIndex;
/**  定义滑块背景色  默认绿 */
@property (nonatomic, copy) UIColor *sliderBackColor;
/**  定义标题栏背景色   */
@property (nonatomic, copy) UIColor *titleScrollviewBackColor;
/** 默认滚到的子控制器 contenoffset 不传默认为  和文字等宽 */
@property (assign, nonatomic) CGFloat sliderWidth;

/** 创建控制器的构造方法 */
- (instancetype)initWithVcMarr:(NSMutableArray *)vcMarr;
@end
