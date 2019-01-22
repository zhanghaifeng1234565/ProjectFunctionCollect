//
//  AVMetadataItem+THAdditions.m
//  YMOCCodeStandard
//
//  Created by iOS on 2019/1/22.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "AVMetadataItem+THAdditions.h"

@implementation AVMetadataItem (THAdditions)

- (NSString *)ym_keyString {
    if ([self.key isKindOfClass:[NSString class]]) {
        return (NSString *)self.key;
    } else if ([self.key isKindOfClass:[NSNumber class]]) {
        UInt32 keyValue = [(NSNumber *)self.key unsignedIntValue];
        
        size_t length = sizeof(UInt32);
        if ((keyValue >> 24) == 0) {
            --length;
        }
        
        if ((keyValue >> 16) == 0) {
            --length;
        }
        
        if ((keyValue >> 8) == 0) {
            --length;
        }
        
        if ((keyValue >> 0) == 0) {
            --length;
        }
        
        long address = (unsigned long)&keyValue;
        address += (sizeof(UInt32) - length);
        
        char cstring[length];
        strncpy(cstring, (char *)address, length);
        cstring[length] = '\0';
        
        if (cstring[0] == '\x49') {
            cstring[0] = '@';
        }
        
        return [NSString stringWithCString:(char *)cstring  encoding:NSUTF8StringEncoding];
    } else {
        return @"<<unknown>>";
    }
}

@end
