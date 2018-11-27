//
//  NSString+YMImage.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/6.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "NSString+YMImage.h"

@implementation NSString (YMImage)

#pragma mark -- 判断图片格式
+ (NSString *)ym_contentTypeForImageData:(NSData *)data {
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return @"jpeg";
        case 0x89:
            return @"png";
        case 0x47:
            return @"gif";
        case 0x49:
        case 0x4D:
            return @"tiff";
        case 0x52:
            if ([data length] < 12) {
                return nil;
            }
            NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
                return @"webp";
            }
            return nil;
    }
    return nil;
}

@end
