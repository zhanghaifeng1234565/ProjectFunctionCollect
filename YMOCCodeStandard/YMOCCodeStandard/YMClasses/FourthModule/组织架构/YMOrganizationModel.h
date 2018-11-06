//
//  YMOrganizationModel.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/10/26.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class YMOrganizationCompanyModel;
/** 组织架构 公司 */
@interface YMOrganizationModel : NSObject

/** 状态 */
@property (nonatomic, copy) NSString *status;
/** msg */
@property (nonatomic, copy) NSString *msg;
/** 公司列表 */
@property (nonatomic, strong) NSArray <YMOrganizationCompanyModel *> *companyList;
/** 时间 */
@property (nonatomic, copy) NSString *time;

@end


@class YMOrganizationDepartmentModel;
/** 组织架构 公司 */
@interface YMOrganizationCompanyModel : NSObject

/** 公司名 */
@property (nonatomic, copy) NSString *name;
/** 公司 id */
@property (nonatomic, copy) NSString *nameId;
/** 公司 部门 */
@property (nonatomic, strong) NSArray <YMOrganizationDepartmentModel *> *departmentList;
/** 是否被选中 0 未被选中 1 被选中 2部分被选中 3 其他 */
@property (nonatomic, copy) NSString *isSelect;
/** 是否展开 0 不展开 1 展开 2 其他 */
@property (nonatomic, copy) NSString *isShow;

@end


@class YMOrganizationPostModel;
/** 组织架构 部门 */
@interface YMOrganizationDepartmentModel : NSObject

/** 部门名 */
@property (nonatomic, copy) NSString *name;
/** 部门 id */
@property (nonatomic, copy) NSString *nameId;
/** 部门 岗位 */
@property (nonatomic, strong) NSArray <YMOrganizationPostModel *> *postList;
/** 是否被选中 0 未被选中 1 被选中 2部分被选中 3 其他 */
@property (nonatomic, copy) NSString *isSelect;
/** 是否展开 0 不展开 1 展开 2 其他 */
@property (nonatomic, copy) NSString *isShow;

@end


@class YMOrganizationStaffModel;
/** 组织架构 岗位 */
@interface YMOrganizationPostModel : NSObject

/** 岗位名 */
@property (nonatomic, copy) NSString *name;
/** 岗位 id */
@property (nonatomic, copy) NSString *nameId;
/** 岗位 员工 */
@property (nonatomic, strong) NSArray <YMOrganizationStaffModel *> *staffList;
/** 是否被选中 0 未被选中 1 被选中 2部分被选中 3 其他【被选中不可修改】 */
@property (nonatomic, copy) NSString *isSelect;
/** 是否展开 0 不展开 1 展开 2 其他 */
@property (nonatomic, copy) NSString *isShow;

@end


/** 组织架构 员工 */
@interface YMOrganizationStaffModel : NSObject

/** 员工名 */
@property (nonatomic, copy) NSString *name;
/** 员工 id */
@property (nonatomic, copy) NSString *nameId;
/** 是否被选中 0 未被选中 1 被选中 2部分被选中 3 其他 */
@property (nonatomic, copy) NSString *isSelect;
/** 是否展开 0 不展开 1 展开 2 其他 */
@property (nonatomic, copy) NSString *isShow;

@end


/** 组织架构通用模型用来存放除公司以外的【部门】【岗位】【员工】通用信息将多维数组展开成二位数组 */
@interface YMOrganizationGeneralPurposeModel : NSObject

/** 名字 */
@property (nonatomic, copy) NSString *name;
/** id */
@property (nonatomic, copy) NSString *nameId;
/** 是否被选中 0 未被选中 1 被选中 2部分被选中 3 其他 */
@property (nonatomic, copy) NSString *isSelect;
/** 是否展开 0 不展开 1 展开 2 其他 */
@property (nonatomic, copy) NSString *isShow;
/** 0公司【最高层级】 1 部门 2 岗位 3 人员 */
@property (nonatomic, copy) NSString *type;
/** -1 最高层级 上一级所属 比如 iOS 属于 技术部 这里用上一级所在的 id 来标识，例如 iOS 属于 XXX 公司 - XXX 部门 - XXX 岗位 */
@property (nonatomic, copy) NSString *belong;
/** 是否是最后一层 1 是 否则不是 */
@property (nonatomic, copy) NSString *isLastLevel;

@end

NS_ASSUME_NONNULL_END
