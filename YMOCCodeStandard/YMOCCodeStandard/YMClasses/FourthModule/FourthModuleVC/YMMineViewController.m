//
//  YMMineViewController.m
//  YMDoctorClient
//
//  Created by iOS on 2018/6/14.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMMineViewController.h"
#import "YMOrganizationViewController.h"


@interface YMMineViewController ()

/** 组织架构多选 */
@property (nonatomic, strong) UIButton *organizationBtn;
/** 组织架构单选 */
@property (nonatomic, strong) UIButton *organizationSingleBtn;

@end

@implementation YMMineViewController

#pragma mark -- lifeStyle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.organizationBtn];
    [self.view addSubview:self.organizationSingleBtn];
}

#pragma mark -- 组织架构多选按钮点击调用
- (void)organizationBtnClick {
    // 获取外界传来的员工状态数组
    NSMutableArray *staffMArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < 15; i++) {
        NSMutableDictionary *staffMDict = [[NSMutableDictionary alloc] init];
        [staffMDict setObject:[NSString stringWithFormat:@"张%d", i + 1] forKey:@"name"];
        [staffMDict setObject:[NSString stringWithFormat:@"%d", i + 1] forKey:@"nameId"];
        [staffMDict setObject:[NSString stringWithFormat:@"%d", arc4random_uniform(3)] forKey:@"isSelect"];
        [staffMDict setObject:@"0" forKey:@"isShow"];
        [staffMArr addObject:staffMDict];
    }
    YMOrganizationViewController *vc = [[YMOrganizationViewController alloc] init];
    vc.singleSelect = NO;
    vc.staffMArr = [[NSMutableArray alloc] initWithArray:staffMArr];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -- 组织架构单选按钮点击调用
- (void)organizationSingleBtnClick {
    YMOrganizationViewController *vc = [[YMOrganizationViewController alloc] init];
    vc.singleSelect = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -- lazyLoadUI
- (UIButton *)organizationBtn {
    if (_organizationBtn == nil) {
        _organizationBtn = [[UIButton alloc] initWithFrame:CGRectMake((MainScreenWidth - 200) / 2, 200, 200, 40)];
        [_organizationBtn setTitle:@"组织架构【多选】" forState:UIControlStateNormal];
        [_organizationBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_organizationBtn setBackgroundColor:[UIColor magentaColor]];
        _organizationBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        _organizationBtn.layer.masksToBounds = YES;
        _organizationBtn.layer.cornerRadius = 3.0f;
        [_organizationBtn addTarget:self action:@selector(organizationBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _organizationBtn;
}

- (UIButton *)organizationSingleBtn {
    if (_organizationSingleBtn == nil) {
        _organizationSingleBtn = [[UIButton alloc] initWithFrame:CGRectMake((MainScreenWidth - 200) / 2, self.organizationBtn.bottom + 30, 200, 40)];
        [_organizationSingleBtn setTitle:@"组织架构【单选】" forState:UIControlStateNormal];
        [_organizationSingleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_organizationSingleBtn setBackgroundColor:[UIColor magentaColor]];
        _organizationSingleBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        _organizationSingleBtn.layer.masksToBounds = YES;
        _organizationSingleBtn.layer.cornerRadius = 3.0f;
        [_organizationSingleBtn addTarget:self action:@selector(organizationSingleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _organizationSingleBtn;
}

@end
