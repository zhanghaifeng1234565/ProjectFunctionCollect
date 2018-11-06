//
//  YMOrganizationSearchTableView.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/10/30.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YMOrganizationSearchTableView : UIView

/** tableView 点击回调 */
@property (nonatomic, copy) void(^tapGestBlock)(void);

/** 搜索结果列表 */
@property (nonatomic, strong) UITableView *tableView;
/** 搜索结果数据 */
@property (nonatomic, strong) NSMutableArray *data;

/** 是否是单选默认是多选 NO  单选 YES */
@property (nonatomic, assign, getter=isSingleSelect) BOOL singleSelect;

@end

NS_ASSUME_NONNULL_END
