//
//  YMTimerPickerView.h
//  YMDoctorClient
//
//  Created by iOS on 2018/7/30.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMBasePickerView.h"

@interface YMTimerPickerView : YMBasePickerView

/** 结果字典 */
@property (nonatomic, strong) NSDictionary *resultDict;
/** block 存在时候回调 */
@property (nonatomic, copy) void(^resultBlock)(NSDictionary *dict);

@property (nonatomic, strong) NSString *year;
@property (nonatomic, strong) NSString *month;
@property (nonatomic, strong) NSString *day;
@property (nonatomic, strong) NSString *hour;
@property (nonatomic, strong) NSString *minute;

@end
