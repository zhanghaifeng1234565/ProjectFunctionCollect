//
//  YMCountryPickerView.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/14.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "YMBasePickerView.h"

NS_ASSUME_NONNULL_BEGIN

@interface YMCountryPickerView : YMBasePickerView

/** 结果字典 */
@property (nonatomic, strong) NSDictionary *resultDict;
/** block 存在时候回调 */
@property (nonatomic, copy) void(^resultBlock)(NSDictionary *dict);

@end

NS_ASSUME_NONNULL_END
