//
//  NSString+HelpeTools.h
//  YMUICommonlyUsedTools
//
//  Created by iOS on 2018/5/25.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (HelpeTools)

/**
 汉字首字母，转成一窜拼音
 
 @param chinaesString 汉字字符串
 
 @return 拼音字符串
 */
+ (NSString *)chinaesExchangeToFirstPingyin:(NSString *)chinaesString;

/**
 截取URL中的参数
 
 @param urlStr URL
 @return 字典形式的参数
 */
+ (NSMutableDictionary *)getURLParameters:(NSString *)urlStr;


/**
 *
 *   BOOL 判断0-9的纯数字字符串
 *
 *  @return Yes为0-9数字，no 不是
 */
-(BOOL)isNumber;

/**
 *判断由数字和26个英文字母或下划线组成的字符串
 *
 */
- (BOOL)isNumAndword;

/**
 *  判断是否为正确的邮箱
 *
 *  @return 返回YES为正确的邮箱，NO为不是邮箱
 */
- (BOOL)isValidateEmail;

/**
 *  判断是否为正确的手机号
 *
 *  @return 返回YES为手机号，NO为不是手机号
 */
- (BOOL)checkTel;

/**  判断是否是纯中文   */
- (BOOL)isChinese;

/**
 *  清空字符串中的空白字符
 *
 *  @return 清空空白字符串之后的字符串
 */
- (NSString *)trimString;

/**
 *  是否空字符串
 *
 *  @return 如果字符串为nil或者长度为0返回YES
 */
- (BOOL)isEmptyString;

/**
 *  返回沙盒中的文件路径
 *
 *  @return 返回当前字符串对应在沙盒中的完整文件路径
 */
+ (NSString *)stringWithDocumentsPath:(NSString *)path;

/**
 *  写入系统偏好
 *
 *  @param key 写入键值
 */
- (void)saveToNSDefaultsWithKey:(NSString *)key;


/**
 一串字符在固定宽度下，正常显示所需要的高度
 
 @param string 字符串
 @param width 宽度
 @param font 大小
 @return 高度
 */
+ (CGFloat)autoHeightWithString:(NSString *)string
                          Width:(CGFloat)width
                           Font:(NSInteger)font;

/**
 一串字符在一行中正常显示所需要的宽度
 
 @param string 字符串
 @param font 大小
 @return 宽度
 */
+ (CGFloat)autoWidthWithString:(NSString *)string
                          Font:(NSInteger)font;

//下划线文字
+ (NSAttributedString *)makeDeleteLine:(NSString *)string;

//返回带换行符的字符串
+ (NSString *)StringHaveNextLine:(NSArray *)array;



/** 将JSON串转化为字典或者数组 */
+ (id)toArrayOrNSDictionary:(NSData *)jsonData;

/**
 *     dic 转json字符串
 */
+(NSString *)NSdictionaryTurnJson:(NSMutableDictionary *)dic;

/**
 *      json 转dic字符串
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

//过滤特殊字符
+ (NSString*)RemoveSpecialCharacter: (NSString *)str;
/*
 *获取汉字拼音的首字母, 返回的字母是大写形式, 例如: @"俺妹", 返回 @"A".
 *如果字符串开头不是汉字, 而是字母, 则直接返回该字母, 例如: @"b彩票", 返回 @"B".
 *如果字符串开头不是汉字和字母, 则直接返回 @"#", 例如: @"&哈哈", 返回 @"#".
 *字符串开头有特殊字符(空格,换行)不影响判定, 例如@"       a啦啦啦", 返回 @"A".
 */
- (NSString *)getFirstLetter;

/**
 *  NSArray 转 Json
 */
+ (NSString *)NSArrayTurnJson:(NSMutableArray *)arr;

/**获取当前时间*/
+ (NSString *)currentDate;

+ (NSString *)getCurrenYear;

+ (NSString *)getCurrenTime;

+ (NSString *)getCurrenNumTime;
/**  时间字符串转nsdate  时间字符串格式 yyyy 年 MM 月 dd 日 */
+ (NSDate *)getCurrenTimeDate:(NSString *)cuuerntime;

/**  转nsdate 时间字符串 时间字符串格式 yyyy 年 MM 月 dd 日 */
+ (NSString *)nsdateChangeTime:(NSDate *)date;
/**  毫秒转时间   */
+ (NSString *)getShowDateWithTime:(NSString *)time;

/**  是否是网址  */
- (BOOL)isHttpsUrl;

/**是否有网*/
+ (Boolean)haveNet;

/** 是否是第一次使用这个版本*/
+ (BOOL)isNewFeature;
/**获取AppVersion*/
+ (NSString*)getAppVersion;

/**获取AppName*/
+ (NSString*)getAppName;

/**  返回富文本 */

/**
 返回富文本
 
 @param originalString     原始的字符串
 @param substringWithRange 需要加属性的range
 @param color              颜色
 @param Font               字体大小
 
 @return NSMutableAttributedString
 */
+ (NSMutableAttributedString *)exchangeStringToAttributedString:(NSString *)originalString AndRange:(NSRange)substringWithRange AndLabelColor:(UIColor *)color AndTextFont:(NSInteger)Font;

/**
 处理末尾是表情符号的 bug

 @param string  要处理的字符串
 @param index 要处理的位置
 @return 处理后的字符串
 */
+ (NSString *)subStringWith:(NSString *)string ToIndex:(NSInteger)index;

/**
 任意时间转化为时间戳

 @param formatTime 要转的时间
 @param format 时间的格式 (@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
 @return 时间戳
 */
+ (NSString *)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;

/**
 任意时间戳转化成时间格式

 @param timestamp 要转化的时间戳
 @param format 要转化的格式 （@"YYYY-MM-dd hh:mm:ss"）----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
 @return 时间格式
 */
+ (NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format;


/**
 输入金额转成199,888.00

 @param string 要转换金额的字符串
 @return 转换后的字符串
 */
+ (NSString *)formatDecimalNumber:(NSString *)string;
@end
