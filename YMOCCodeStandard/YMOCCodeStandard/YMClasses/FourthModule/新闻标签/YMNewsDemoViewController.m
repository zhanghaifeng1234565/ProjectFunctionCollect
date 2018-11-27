//
//  YMNewsDemoViewController.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/27.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "YMNewsDemoViewController.h"

#import "YMSegmentViewController.h"
#import "YMDemoFormViewController.h"

@interface YMNewsDemoViewController ()

@end

@implementation YMNewsDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - - 加载子视图
- (void)loadSubviews {
    [super loadSubviews];
    
    [self loadSubviewsControllerVc];
}

#pragma mark -- 加载子控制器
- (void)loadSubviewsControllerVc {
    NSMutableArray *vcMArr = @[].mutableCopy;
   
    for (int i = 0; i < 6; i++) {
        YMDemoFormViewController *vc = [[YMDemoFormViewController alloc] init];
        vc.title = [NSString stringWithFormat:@"表单-%d", i + 1];
        [vcMArr addObject:vc];
    }
    
    YMSegmentViewController *segmentVc = [[YMSegmentViewController alloc] initWithVcMarr:vcMArr];
    segmentVc.tagHeight = 44.0f;
    segmentVc.sliderWidth = 60;
    segmentVc.sliderBackColor = [UIColor colorWithHexString:@"03abff"];
    segmentVc.btnNormolColor = [UIColor colorWithHexString:@"35465f"];
    segmentVc.btnSlectColor = [UIColor colorWithHexString:@"03abff"];
    segmentVc.titleScrollviewBackColor = [UIColor whiteColor];
    [self addChildViewController:segmentVc];
    [self.view addSubview:segmentVc.view];
    segmentVc.view.frame = CGRectMake(0, 0, MainScreenWidth, MainScreenHeight);
    [segmentVc.view layoutIfNeeded];
}

@end
