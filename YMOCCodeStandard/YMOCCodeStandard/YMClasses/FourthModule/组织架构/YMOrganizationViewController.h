//
//  YMOrganizationViewController.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/10/29.
//  Copyright © 2018年 iOS. All rights reserved.
//
/**
 // 单选
 YMOrganizationViewController *vc = [[YMOrganizationViewController alloc] init];
 vc.singleSelect = YES;
 [self.navigationController pushViewController:vc animated:YES];
 
 
 // 多选
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
 */

#import "YMBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

/** 组织架构这里拿公司比例【可以替换成其他，但逻辑上目前只支持四级【含】以下】 */
@interface YMOrganizationViewController : YMBaseViewController

/** 外界传入的员工状态数组 */
@property (nonatomic, strong) NSMutableArray *staffMArr;

/** 是否是单选默认是多选 NO  单选 YES */
@property (nonatomic, assign, getter=isSingleSelect) BOOL singleSelect;
@end

NS_ASSUME_NONNULL_END
