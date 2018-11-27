//
//  NSString+YMTimeDate.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/9/18.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "NSString+YMTimeDate.h"

@implementation NSString (YMTimeDate)

#pragma mark -- 获取当前年 2018
+ (NSString *)ym_getCurrentYear {
    NSDateFormatter * formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy"];
    return [formatter stringFromDate:[NSDate date]];
}

#pragma mark -- 获取当前月 09
+ (NSString *)ym_getCurrentMonth {
    NSDateFormatter * formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"MM"];
    return [formatter stringFromDate:[NSDate date]];
}

#pragma mark -- 获取当前日 18
+ (NSString *)ym_getCurrentDay {
    NSDateFormatter * formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"dd"];
    return [formatter stringFromDate:[NSDate date]];
}

#pragma mark -- 获取当前时 16
+ (NSString *)ym_getCurrentHour {
    NSDateFormatter * formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"HH"];
    return [formatter stringFromDate:[NSDate date]];
}

#pragma mark -- 获取当前分 26
+ (NSString *)ym_getCurrentMinute {
    NSDateFormatter * formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"mm"];
    return [formatter stringFromDate:[NSDate date]];
}

#pragma mark -- 获取当前秒 26
+ (NSString *)ym_getCurrentSecond {
    NSDateFormatter * formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"ss"];
    return [formatter stringFromDate:[NSDate date]];
}

#pragma mark -- 获取当前年月 2018年09月
+ (NSString *)ym_getCurrentYearMonth {
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy年MM月"];
    return [formatter stringFromDate:[NSDate date]];
}

#pragma mark -- 获取当前年月 09月18日
+ (NSString *)ym_getCurrentMonthDay {
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"MM月dd日"];
    return [formatter stringFromDate:[NSDate date]];
}

#pragma mark -- 获取当前日期 2018年09月18日
+ (NSString *)ym_getCurrenYearMonthDay {
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    return [formatter stringFromDate:[NSDate date]];
}

#pragma mark -- 获取当前日期时间 2018-09-18 16:13:55
+ (NSString *)ym_getCurrentDateTime {
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter stringFromDate:[NSDate date]];
}

#pragma  mark 根据格式获取当前时间,年月日/星期/
+ (NSString*)ym_getCurrentDateTimesWithFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSDate *datenow = [NSDate date];
    NSString *currentTime = [formatter stringFromDate:datenow];
    return currentTime;
}

#pragma mark - 将某个时间转化成 时间戳
+ (NSString *)ym_timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    
    NSDate* date = [formatter dateFromString:formatTime];
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    
    return [NSString stringWithFormat:@"%ld", timeSp];
}

#pragma mark - 将某个时间戳转化成 时间
+ (NSString *)ym_timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return confromTimespStr;
}

#pragma mark -- 传入毫秒【15890000】转成字符串 2018-09-18 16:45:59
+ (NSString *)ym_getShowDateWithTime:(NSString *)time {
    
    NSDate *timeDate = [[NSDate alloc]initWithTimeIntervalSince1970:[time longLongValue]/1000.0];
    
    /**
     初始化并定义Formatter
     
     :returns: NSDate
     */
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    /**
     *  使用Formatter格式化时间（传入时间和当前时间）为NSString
     */
    NSString *timeStr = [dateFormatter stringFromDate:timeDate];
    NSString *nowDateStr = [dateFormatter stringFromDate:[NSDate date]];
    
    /**
     *  判断前四位是不是本年，不是本年直接返回完整时间
     */
    if ([[timeStr substringWithRange:NSMakeRange(0, 4)] rangeOfString:[nowDateStr substringWithRange:NSMakeRange(0, 4)]].location == NSNotFound) {
        return timeStr;
    } else {
        /**
         *  判断是不是本天，是本天返回HH:mm,不是返回MM-dd HH:mm
         */
        if ([[timeStr substringWithRange:NSMakeRange(5, 5)] rangeOfString:[nowDateStr substringWithRange:NSMakeRange(5, 5)]].location != NSNotFound) {
            return [timeStr substringWithRange:NSMakeRange(11, 5)];
        } else {
            return [timeStr substringWithRange:NSMakeRange(5, 11)];
        }
    }
}

#pragma mark -- NSDate 日期转换成日期字符串 2018年09月18日
+ (NSString *)ym_nsdateChangeDateStr:(NSDate *)date {
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy年MM月dd日"];
    return [formater stringFromDate:date];
}

#pragma mark - 这一年的这个月有多少天
+ (NSInteger)ym_isAllDayWithYear:(NSInteger)year month:(NSInteger)month {
    int day=0;
    switch(month){
        case 1:
            day += 31;
        case 2:{
            if(((year%4==0)&&(year%100!=0))||(year%400==0)){
                day+=29;
            }
            else{
                day+=28;
            }
        }
        case 3:
            day += 31;
        case 4:
            day += 30;
        case 5:
            day += 31;
        case 6:
            day += 30;
        case 7:
            day += 31;
        case 8:
            day += 31;
        case 9:
            day += 30;
        case 10:
            day += 31;
        case 11:
            day += 30;
        case 12:
            day += 31;
            break;
        default:
            break;
    }
    return day;
}

#pragma mark -- 获取当前后几天日期 周日
+ (NSMutableArray *)ym_getCurrentDateLaterDate:(int)dayCount {
    NSMutableArray *dayMArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < dayCount; i++) {
        //从现在开始的24小时
        NSTimeInterval secondsPerDay = i * 24 * 60 * 60;
        NSDate *curDate = [NSDate dateWithTimeIntervalSinceNow:secondsPerDay];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM-dd"];
        
        NSDateFormatter *weekFormatter = [[NSDateFormatter alloc] init];
        [weekFormatter setDateFormat:@"EEEE"];//星期几 @"HH:mm 'on' EEEE MMMM d"];
        NSString *theWeek = [weekFormatter stringFromDate:curDate];
        
        //转换英文为中文
        NSString *chinaStr;
        if(theWeek){
            if ([theWeek isEqualToString:@"Monday"]||[theWeek isEqualToString:@"星期一"]) {
                chinaStr = @"周一";
            } else if ([theWeek isEqualToString:@"Tuesday"]||[theWeek isEqualToString:@"星期二"]){
                chinaStr = @"周二";
            } else if ([theWeek isEqualToString:@"Wednesday"]||[theWeek isEqualToString:@"星期三"]){
                chinaStr = @"周三";
            } else if ([theWeek isEqualToString:@"Thursday"]||[theWeek isEqualToString:@"星期四"]){
                chinaStr = @"周四";
            } else if ([theWeek isEqualToString:@"Friday"]||[theWeek isEqualToString:@"星期五"]){
                chinaStr = @"周五";
            } else if ([theWeek isEqualToString:@"Saturday"]||[theWeek isEqualToString:@"星期六"]){
                chinaStr = @"周六";
            } else if ([theWeek isEqualToString:@"Sunday"]||[theWeek isEqualToString:@"星期日"]){
                chinaStr = @"周日";
            }
        }
        
        //组合时间
        NSString *strTime = [NSString stringWithFormat:@"%@", chinaStr];
        [dayMArr addObject:strTime];
    }
    return dayMArr.copy;
}

#pragma  mark 获取未来几天日期
+ (NSMutableArray *)ym_getDateDurationWithLaterDate:(int)dayCount {
    NSArray *_array;
    NSInteger _day = 0;
    NSInteger _month = 0;
    NSInteger _year = 0;
    
    NSString *currentDate = [NSString ym_getCurrentDateTimesWithFormat:@"yyyy-MM-dd"];
    
    //年月日
    _array = [currentDate componentsSeparatedByString:@"-"];
    _day = [[_array lastObject] integerValue];
    _month = [_array[1] integerValue];
    _year = [[_array firstObject] integerValue];
    
    NSMutableArray *dateMarr = [[NSMutableArray alloc] init];
    for (int i = 0; i < dayCount; i ++) {
        //取出当月的天数
        NSInteger day = [NSString ym_isAllDayWithYear:_year month:_month] - [NSString ym_isAllDayWithYear:_year month:_month+1];
        if (_day > day) {
            _day = 1;
            _month ++;
            _year = _month > 12 ? _year += 1 : _year;
            _month = _month > 12 ? 1 : _month;
        }
        NSString * string;
        string = [NSString stringWithFormat:@"%02ld-%02ld", _month, _day++];
        [dateMarr addObject:string];
    }
    return dateMarr.copy;
}

#pragma  mark 获取未来几天 年月日
+ (NSMutableArray *)ym_getDateDurationYearMD:(int)dayCount {
    NSArray *_array;
    NSInteger _day = 0;
    NSInteger _month = 0;
    NSInteger _year = 0;
    
    NSString *currentDate = [NSString ym_getCurrentDateTimesWithFormat:@"yyyy-MM-dd"];
    
    //年月日
    _array = [currentDate componentsSeparatedByString:@"-"];
    _day = [[_array lastObject] integerValue];
    _month = [_array[1] integerValue];
    _year = [[_array firstObject] integerValue];
    
    NSMutableArray *dateMarr = [[NSMutableArray alloc] init];
    for (int i = 0; i < 7; i ++) {
        //取出当月的天数
        NSInteger day = [NSString ym_isAllDayWithYear:_year month:_month] - [NSString ym_isAllDayWithYear:_year month:_month+1];
        if (_day > day) {
            _day = 1;
            _month ++;
            _year = _month > 12 ? _year += 1 : _year;
            _month = _month > 12 ? 1 : _month;
            
        }
        NSString * string;
        
        string = [NSString stringWithFormat:@"%ld-%02ld-%02ld", _year, _month, _day++];
        
        [dateMarr addObject:string];
    }
    return dateMarr.copy;
}
@end
