//
//  YMOrganizationSectionHeaderView.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/10/26.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class YMOrganizationCompanyModel;
/** 组织架构组头 */
@interface YMOrganizationSectionHeaderView : UITableViewHeaderFooterView

/** 是否是单选默认是多选 NO  单选 YES */
@property (nonatomic, assign, getter=isSingleSelect) BOOL singleSelect;

/**
 根据模型设置数据

 @param model 公司模型
 @param section 所在组
 */
- (void)setDataWithModel:(YMOrganizationCompanyModel *)model section:(NSInteger)section;
@end

NS_ASSUME_NONNULL_END
