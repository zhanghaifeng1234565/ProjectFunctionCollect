//
//  YMOrganizationViewModel.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/10/30.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class YMOrganizationModel, YMOrganizationGeneralPurposeModel;

/** 用来处理网络请求以及相关的数据处理 */
@interface YMOrganizationViewModel : NSObject


/**
 请求组织架构数据

 @param view loading 展示的位置【在哪个视图上】
 @param success 成功回调
 */
+ (void)obtainOrganizationDataOnTheView:(UIView *)view success:(void(^)(id result))success;


/**
 对模型进行 所有员工标识是否被选中

 @param staffMArr 外界传入的员工数组
 @param model 被处理的模型
 */
+ (void)dealStaffSelectStatusMArr:(NSMutableArray *)staffMArr model:(YMOrganizationModel *)model;


/**
 对模型进行 所有员工标识是否被选中

 @param staffMArr 外界传入的员工模型数组
 @param model 被处理的模型
 */
+ (void)dealStaffSelectStatusModelMArr:(NSMutableArray *)staffMArr model:(YMOrganizationModel *)model;


/**
 获取所有员工被选中数组【状态为 1 可修改的被选中 2 不可修改的被选中】

 @param model 数据模型
 @return 所有员工
 */
+ (NSMutableArray *)obtainSelectStaffModel:(YMOrganizationModel *)model;


/**
 获取员工被选中数组【状态为 1 可修改的被选中】

 @param model 数据模型
 @return 所有员工
 */
+ (NSMutableArray *)obtainSelectStaffOnlyChangeModel:(YMOrganizationModel *)model;


/**
 创建一个员工模型模拟点击员工选中按钮来更新列表选中效果。

 @param model 被处理的模型
 */
+ (void)createChangeModel:(YMOrganizationModel *)model;


/**
 根据修改后的模型返回展开成二位数组数据

 @param model 修改后的模型数据
 @return 新的数据数组
 */
+ (NSMutableArray *)updateDataWithModel:(YMOrganizationModel *)model;


/**
 是否全选

 @param type 1 全选 否则不是全选
 @param model 要处理的数据模型
 */
+ (void)isAllCompanySelectWithType:(NSString *)type model:(YMOrganizationModel *)model;


/**
 是否某个公司全选

 @param type 1 全选 否则不是全选
 @param section 是哪个公司
 @param model 要处理的模型
 */
+ (void)isCompanySelectWithType:(NSString *)type section:(int)section model:(YMOrganizationModel *)model;


/**
 显示选中部门

 @param generalModel 重排后的模型
 @param model 要处理的数据模型
 */
+ (void)showDepartment:(YMOrganizationGeneralPurposeModel *)generalModel model:(YMOrganizationModel *)model;


/**
 显示选中岗位

 @param generalModel 重排后的模型
 @param model 要处理的数据模型
 */
+ (void)showPost:(YMOrganizationGeneralPurposeModel *)generalModel model:(YMOrganizationModel *)model;


/**
 点击选择部门设置选中

 @param generalModel 重排后的模型
 @param model 要处理的数据模型
 */
+ (void)selectDepartment:(YMOrganizationGeneralPurposeModel *)generalModel model:(YMOrganizationModel *)model;


/**
 点击选中岗位

 @param generalModel 重排后的模型
 @param model 要处理的数据模型
 */
+ (void)selectPost:(YMOrganizationGeneralPurposeModel *)generalModel model:(YMOrganizationModel *)model;


/**
 点击选中员工

 @param generalModel 重排后的模型
 @param model 要处理的数据模型
 */
+ (void)selectStaff:(YMOrganizationGeneralPurposeModel *)generalModel model:(YMOrganizationModel *)model;


/**
 单选员工

 @param generalModel 重排后的模型
 @param model 要处理的数据模型
 */
+ (void)singleSelectStaff:(YMOrganizationGeneralPurposeModel *)generalModel model:(YMOrganizationModel *)model;


/**
 获取搜索相关

 @param view 所在视图
 @param success 成功回调
 */
+ (void)obtainOrganizationSearchDataOnTheView:(UIView *)view success:(void(^)(id result))success;
@end

NS_ASSUME_NONNULL_END
