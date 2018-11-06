//
//  CommonFunc.h
//  MyDes
//
//  Created by biaohang on 14-4-14.
//  Copyright (c) 2014年 biaohang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define __BASE64( text )        [CommonFunc base64StringFromText:text]
#define __TEXT( base64 )        [CommonFunc textFromBase64String:base64]

@interface CommonFunc : NSObject


/******************************************************************************
 函数名称 : +(NSString *)encode:(NSString *)known
 函数描述 : 将文本进行base64和DES加密后,将加密结果在与@"encode"进行拼接
 输入参数 : (NSString *)known 需要加密的文本
 输出参数 :  N/A
 返回参数 : (NSString *)文本进行base64和DES加密后,将加密结果在与@"encode"进行拼接的字符串
 备注信息 : 详见函数内部
 ******************************************************************************/
+(NSString *)encode:(NSString *)known withKey:(NSString *)key;

/******************************************************************************
 函数名称 : +(NSString *)decode:(NSString *)ciphertext
 函数描述 : 检测参数是否是密文(以 "encode"开头),如果是返回解密后的结果,如果不是密文返回传入的原参数
 输入参数 : (NSString *)ciphertext    待解密的文本
 输出参数 : N/A
 返回参数 : (NSString *)   如果参数是密文返回解密后的base64格式字符串,如果参数不是密文返回原来的参数
 备注信息 :
 ******************************************************************************/
+(NSString *)decode:(NSString *)ciphertext withKey:(NSString *)key;


/******************************************************************************
 函数名称 : +(NSData *)encodeData:(NSString *)known;
 函数描述 : 将文本进行base64和DES加密后,将加密结果在与@"encode"进行拼接 ,最后返回NSData 编码格式为:utf-8
 输入参数 : (NSString *)known 需要加密的文本
 输出参数 :  N/A
 返回参数 : +(NSData *)  将加密后的文本转成NSdata最后返回NSData 编码格式为:utf-8
 备注信息 : 详见函数内部
 ******************************************************************************/
+(NSData *)encodeData:(NSString *)known withKey:(NSString *)key;

/******************************************************************************
 函数名称 : +(NSString *)decodeData:(NSData *)cipherData;
 函数描述 : 先将参数转化为NSString(编码格式为utf-8),在检测是否是密文(以 "encode"开头),如果是返回解密后的结果,如果不是密文返回NDdata转成的NSstring
        
 输入参数 : (NSData *)cipherData 带解密的NSdata
 输出参数 : N/A
 返回参数 : (NSString *)   如果参数是密文返回解密后的base64格式字符串,如果不是密文返回NDdata转成的NSstring
 备注信息 :
 ******************************************************************************/
+(NSString *)decodeData:(NSData *)cipherData withKey:(NSString *)key;



/******************************************************************************
 函数名称 : + (NSString *)base64StringFromText:(NSString *)text
 函数描述 : 将文本转换为base64格式字符串
 输入参数 : (NSString *)text    文本
 输出参数 : N/A
 返回参数 : (NSString *)    base64格式字符串
 备注信息 :
 ******************************************************************************/
+ (NSString *)base64StringFromText:(NSString *)text withKey:(NSString *)key;

/******************************************************************************
 函数名称 : + (NSString *)textFromBase64String:(NSString *)base64
 函数描述 : 将base64格式字符串转换为文本
 输入参数 : (NSString *)base64  base64格式字符串
 输出参数 : N/A
 返回参数 : (NSString *)    文本
 备注信息 :
 ******************************************************************************/
+ (NSString *)textFromBase64String:(NSString *)base64 withKey:(NSString *)key;

@end
