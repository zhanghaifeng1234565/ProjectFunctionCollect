//
//  YMSQLite3Person.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/12/3.
//  Copyright © 2018 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YMSQLite3Person : NSObject

@property (nonatomic, readwrite, copy) NSString *itemid;
@property (nonatomic, readwrite, copy) NSString *name;
@property (nonatomic, readwrite, copy) NSString *age;
@property (nonatomic, readwrite, copy) NSString *height;
@property (nonatomic, readwrite, copy) NSString *weight;
@property (nonatomic, readwrite, assign, getter=isDeleteData) BOOL delete_data;

@end

NS_ASSUME_NONNULL_END
