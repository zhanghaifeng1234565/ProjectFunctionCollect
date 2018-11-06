//
//  YMOrganizationSearchTableViewCell.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/10/30.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class YMOrganizationStaffModel;
@interface YMOrganizationSearchTableViewCell : UITableViewCell

/** 是否是单选默认是多选 NO  单选 YES */
@property (nonatomic, assign, getter=isSingleSelect) BOOL singleSelect;

/** 当前索引 */
@property (nonatomic, strong) NSIndexPath *indexPath;
/** 设置数据源 */
@property (nonatomic, strong) YMOrganizationStaffModel *model;
@end

NS_ASSUME_NONNULL_END
