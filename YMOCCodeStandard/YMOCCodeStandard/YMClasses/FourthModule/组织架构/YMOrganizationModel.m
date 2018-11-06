//
//  YMOrganizationModel.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/10/26.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMOrganizationModel.h"

/** 组织架构 */
@implementation YMOrganizationModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"companyList" : @"YMOrganizationCompanyModel"};
}
@end


/** 组织架构 公司 */
@implementation YMOrganizationCompanyModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"departmentList" : @"YMOrganizationDepartmentModel"};
}
@end


/** 组织架构 部门 */
@implementation YMOrganizationDepartmentModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"postList" : @"YMOrganizationPostModel"};
}
@end


/** 组织架构 岗位 */
@implementation YMOrganizationPostModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"staffList" : @"YMOrganizationStaffModel"};
}
@end


/** 组织架构 员工 */
@implementation YMOrganizationStaffModel

@end


/** 组织架构通用模型用来存放除公司以外的【部门】【岗位】【员工】通用信息将多维数组展开成二位数组 */
@implementation YMOrganizationGeneralPurposeModel

@end
