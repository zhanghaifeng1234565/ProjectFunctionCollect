//
//  YMLimitTextField.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/26.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "YMLimitTextField.h"

@interface YMLimitTextField ()
<UITextFieldDelegate>

@end

@implementation YMLimitTextField

#pragma mark - - 销毁
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

#pragma mark - - init
- (instancetype)init {
    if (self = [super init]) {
        [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

#pragma mark - - textFieldDidChange
- (void)textFieldDidChange:(YMLimitTextField *)textField {
    
    CGFloat charCount = _maxFontCount ? _maxFontCount : MAXFLOAT;
    NSString *toBeString = textField.text;
    
    //获取高亮部分
    UITextRange *selectedRange = [textField markedTextRange];
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    if (!position || !selectedRange) {
        if (toBeString.length > charCount) {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:charCount];
            if (rangeIndex.length == 1) {
                textField.text = [toBeString substringToIndex:charCount];
            } else {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, charCount)];
                textField.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
    
    if (self.textFieldChange) {
        self.textFieldChange(textField);
    }
}

#pragma mark - - setter
- (void)setMaxFontCount:(CGFloat)maxFontCount {
    _maxFontCount = maxFontCount;
}

@end
