//
//  YMOrganizationSearchModel.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/10/30.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class YMOrganizationStaffModel;
@interface YMOrganizationSearchModel : NSObject

/** 状态 */
@property (nonatomic, copy) NSString *status;
/** msg */
@property (nonatomic, copy) NSString *msg;
/** 员工列表 */
@property (nonatomic, strong) NSArray <YMOrganizationStaffModel *> *staffList;
/** 时间 */
@property (nonatomic, copy) NSString *time;

@end

NS_ASSUME_NONNULL_END
