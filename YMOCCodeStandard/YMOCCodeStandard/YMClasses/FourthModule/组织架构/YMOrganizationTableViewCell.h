//
//  YMOrganizationTableViewCell.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/10/26.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class YMOrganizationGeneralPurposeModel;
@interface YMOrganizationTableViewCell : UITableViewCell

/** 是否是单选默认是多选 NO  单选 YES */
@property (nonatomic, assign, getter=isSingleSelect) BOOL singleSelect;

/**
 设置数据

 @param model 数据模型
 @param indexP 索引
 */
- (void)setDataWithModel:(YMOrganizationGeneralPurposeModel *)model indexPath:(NSIndexPath *)indexP;
@end

NS_ASSUME_NONNULL_END
