//
//  YMFMDBPerson.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/12/4.
//  Copyright © 2018 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YMFMDBPerson : NSObject

/// ID
@property (nonatomic, readwrite, assign) int itemid;
/// 名字
@property (nonatomic, readwrite, copy) NSString *name;
/// 电话号
@property (nonatomic, readwrite, copy) NSString *phone;
/// 分数
@property (nonatomic, readwrite, assign) int score;

@end

NS_ASSUME_NONNULL_END
