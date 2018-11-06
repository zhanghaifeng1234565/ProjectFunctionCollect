//
//  YMUITextField.m
//  YMUICommonlyUsedTools
//
//  Created by iOS on 2018/5/11.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMUITextField.h"

@implementation YMUITextField

- (void)deleteBackward {
    [super deleteBackward];
    if ([self.ym_delegate respondsToSelector:@selector(ymTextFieldDeleteBackward:)]) {
        [self.ym_delegate ymTextFieldDeleteBackward:self];
    }
}


@end
