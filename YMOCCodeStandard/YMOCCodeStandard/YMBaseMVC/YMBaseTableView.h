//
//  YMBaseTableView.h
//  YMOAManageSystem
//
//  Created by iOS on 2018/11/19.
//  Copyright © 2018 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, YMBaseTableViewEmptyDataStyle) {
    YMBaseTableViewEmptyDataStyleDefault = 0,
    YMBaseTableViewEmptyDataStyleXXX = 1,
};
@interface YMBaseTableView : UITableView

/** 数据源数组 */
@property (nonatomic, strong) NSMutableArray *dataMarr;
/** 没有数据是样式 */
@property (nonatomic, assign) YMBaseTableViewEmptyDataStyle emptyDataStyle;
/** 没有数据按钮点击回调 */
@property (nonatomic, copy) void (^noDataBtnBlock)(UIButton *sender);

@end


/** 没有数据视图 */
@interface YMBaseTableViewEmptyView : UIView

/** 没有数据是样式 */
@property (nonatomic, assign) YMBaseTableViewEmptyDataStyle emptyDataStyle;
/** 没有数据按钮点击回调 */
@property (nonatomic, copy) void (^noDataBtnBlock)(UIButton *sender);

@end

NS_ASSUME_NONNULL_END
