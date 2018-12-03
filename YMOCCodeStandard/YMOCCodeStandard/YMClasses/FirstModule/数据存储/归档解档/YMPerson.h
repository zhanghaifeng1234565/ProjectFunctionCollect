//
//  YMPerson.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/30.
//  Copyright © 2018 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 归档自定义对象
@interface YMPerson : NSObject
<NSCoding>

/// 姓名
@property (nonatomic, readwrite, copy) NSString *name;
/// 年龄
@property (nonatomic, readwrite, assign) NSInteger age;


/**
 通过归档保存自定义对象

 @param person 自定义对象
 @param fileName 文件名字
 */
+ (void)savePerson:(YMPerson *)person fileName:(NSString *)fileName;



/**
 获取自定义对象

 @param fileName 文件名字
 @return 自定义对象
 */
+ (YMPerson *)getPersonWithFileName:(NSString *)fileName;


/**
 清除指定目录下的文件

 @param fileName 文件名字
 */
+ (void)removeDocumentWithFileName:(NSString *)fileName;

@end

NS_ASSUME_NONNULL_END
