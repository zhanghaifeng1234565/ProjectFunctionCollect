//
//  NSString+YMTimeDate.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/9/18.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (YMTimeDate)

/**
 获取当前年 2018

 @return 当前年字符串
 */
+ (NSString *)ym_getCurrentYear;

/**
 获取当前月 09
 
 @return 当前月字符串
 */
+ (NSString *)ym_getCurrentMonth;

/**
 获取当前日 18
 
 @return 当前日字符串
 */
+ (NSString *)ym_getCurrentDay;

/**
 获取当前时 18
 
 @return 当前时字符串
 */
+ (NSString *)ym_getCurrentHour;

/**
 获取当前分 18
 
 @return 当前分字符串
 */
+ (NSString *)ym_getCurrentMinute;

/**
 获取当前秒 59
 
 @return 当前秒字符串
 */
+ (NSString *)ym_getCurrentSecond;

/**
 获取当前年月 2018年09月

 @return 当前年月字符串
 */
+ (NSString *)ym_getCurrentYearMonth;

/**
 获取当前月日 09月18日

 @return 当前月日字符串
 */
+ (NSString *)ym_getCurrentMonthDay;

/**
 获取当前年月日 2018年09月18日
 
 @return 当前年月日字符串
 */
+ (NSString *)ym_getCurrenYearMonthDay;

/**
 获取当前日期时间 2018-09-18 16:13:55

 @return 日期时间字符串
 */
+ (NSString *)ym_getCurrentDateTime;

/**
 日期转换成日期字符串 2018年09月18日

 @param date 传入要转换的日期
 @return 转换后的日期字符串
 */
+ (NSString *)ym_nsdateChangeDateStr:(NSDate *)date;

/**
 根据格式获取当前时间,年月日/星期/
 
 @param format 要转化的格式 如 yyyy-MM-dd HH:mm:ss EEEE 【2018-09-18 17:53:59 星期二】
 @return 当前日期
 */
+ (NSString*)ym_getCurrentDateTimesWithFormat:(NSString *)format;

/**
 将某个时间转化成 时间戳 可根据需要自由组合

 @param formatTime 要格式格式化的时间 2018-09-18 16:45:59 或 2018年09月18日 16时45分59秒
 @param format 时间的格式 yyyy-MM-dd HH:mm:ss 或 yyyy年MM月dd日 HH时mm分ss秒
 @return 时间对应的时间戳【非毫秒】
 */
+ (NSString *)ym_timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;

#pragma mark - 将某个时间戳转化成 时间
/**
 将某个时间戳转化成 时间 可自由输出

 @param timestamp 要转换的时间戳【非毫秒】
 @param format 转换的格式 yyyy-MM-dd HH:mm:ss 或 yyyy年MM月dd日 HH时mm分ss秒
 @return 转换后的时间 2018-09-18 16:45:59 或 2018年09月18日 16时45分59秒
 */
+ (NSString *)ym_timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format;

/**
 传入毫秒【15890000】转成字符串 2018-09-18 16:45:59

 @param time 要转换的时间戳
 @return 时间格式
 */
+ (NSString *)ym_getShowDateWithTime:(NSString *)time;

/**
 这一年的这个月有多少天

 @param year 哪一年
 @param month 那个月 不超过 12
 @return 天数
 */
+ (NSInteger)ym_isAllDayWithYear:(NSInteger)year month:(NSInteger)month;

#pragma mark -- 获取当前后几天日期 周日
/**
 获取当前后几天日期 周日

 @param dayCount 后几天
 @return 周几数组
 */
+ (NSMutableArray *)ym_getCurrentDateLaterDate:(int)dayCount;

/**
 获取未来几天日期

 @param dayCount 后几天
 @return 09-16 数组
 */
+ (NSMutableArray *)ym_getDateDurationWithLaterDate:(int)dayCount;

/**
 获取未来几天 年月日

 @param dayCount 后几天
 @return 2018-09-18 数组
 */
+ (NSMutableArray *)ym_getDateDurationYearMD:(int)dayCount;
@end

NS_ASSUME_NONNULL_END
