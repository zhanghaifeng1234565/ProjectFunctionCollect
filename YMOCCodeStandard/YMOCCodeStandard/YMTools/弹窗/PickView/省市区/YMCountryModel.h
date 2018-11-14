//
//  YMCountryModel.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/14.
//  Copyright © 2018 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@class YMProvinceModel;
/** 国家数据模型 */
@interface YMCountryModel : NSObject

/** 请求状态 */
@property (nonatomic, copy) NSString *status;
/** 时间 */
@property (nonatomic, copy) NSString *time;
/** msg */
@property (nonatomic, copy) NSString *msg;
/** 省 */
@property (nonatomic, copy) NSArray <YMProvinceModel *> *province;

@end


@class YMCityModel;
/** 省 */
@interface YMProvinceModel : NSObject

/** 名字 */
@property (nonatomic, copy) NSString *name;
/** id */
@property (nonatomic, copy) NSString *nameId;
/** 市 */
@property (nonatomic, copy) NSArray <YMCityModel *> *city;

@end


@class YMCountyModel;
/** 市 */
@interface YMCityModel : NSObject

/** 名字 */
@property (nonatomic, copy) NSString *name;
/** id */
@property (nonatomic, copy) NSString *nameId;
/** 县区 */
@property (nonatomic, copy) NSArray <YMCountyModel *> *county;

@end


@class YMAreaModel;
/** 区 */
@interface YMCountyModel : NSObject

/** 名字 */
@property (nonatomic, copy) NSString *name;
/** id */
@property (nonatomic, copy) NSString *nameId;
/** 乡镇 */
@property (nonatomic, copy) NSArray <YMAreaModel *> *Area;

@end


@class YMVillageModel;
/** 乡镇 */
@interface YMAreaModel : NSObject

/** 名字 */
@property (nonatomic, copy) NSString *name;
/** id */
@property (nonatomic, copy) NSString *nameId;
/** 村 */
@property (nonatomic, copy) NSArray <YMVillageModel *> *village;

@end


/** 村/居委会 */
@interface YMVillageModel : NSObject

/** 名字 */
@property (nonatomic, copy) NSString *name;
/** id */
@property (nonatomic, copy) NSString *nameId;
/** 分类 */
@property (nonatomic, copy) NSString *categoryId;

@end


NS_ASSUME_NONNULL_END
