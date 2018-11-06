//
//  YMDataSaveSingleton.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/9/13.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMDataSaveSingleton : NSObject

/**
 单例

 @return self
 */
+ (instancetype)shareManager;

/** 姓名 */
@property (nonatomic, copy) NSString *nameStr;
/** 年龄 */
@property (nonatomic, copy) NSString *ageStr;
/** 身高 */
@property (nonatomic, copy) NSString *heightStr;
/** id 数组 */
@property (nonatomic, strong) NSMutableArray *idMArr;

@end
