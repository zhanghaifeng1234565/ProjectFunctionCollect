//
//  YMCountryModel.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/14.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "YMCountryModel.h"

@implementation YMCountryModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"province" : @"YMProvinceModel"};
}
@end


/** 省 */
@implementation YMProvinceModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"city" : @"YMCityModel"};
}
@end


/** 市 */
@implementation YMCityModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"county" : @"YMCountyModel"};
}
@end


/** 区 */
@implementation YMCountyModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"township" : @"YMTownshipModel"};
}
@end


/** 乡镇 */
@implementation YMTownshipModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"village" : @"YMVillageModel"};
}
@end


/** 村/居委会 */
@implementation YMVillageModel

@end
