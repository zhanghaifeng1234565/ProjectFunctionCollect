//
//  YMUniversalSingleSelectModel.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/13.
//  Copyright © 2018 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class YMUniversalSingleDataModel;
@interface YMUniversalSingleSelectModel : NSObject

@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, strong) NSArray <YMUniversalSingleDataModel *> *list;
@property (nonatomic, copy) NSString *msg;

@end


/** 数组模型 */
@interface YMUniversalSingleDataModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *titleId;
@property (nonatomic, copy) NSString *select;

@end

NS_ASSUME_NONNULL_END
