//
//  YMAdaptiveHeightTextView.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/26.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "YMAdaptiveHeightTextView.h"

@interface YMAdaptiveHeightTextView ()
<UITextViewDelegate>

@end

@implementation YMAdaptiveHeightTextView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.delegate = self;
}

- (instancetype)init {
    if (self = [super init]) {
        self.delegate = self;
    }
    return self;
}

#pragma mark - - textViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    
    CGFloat charCount = _maxFontCount ? _maxFontCount : MAXFLOAT;
    if (textView.text.length > 0) {
        // 该判断用于联想输入
        if (textView.text.length > charCount) {
            textView.text = [NSString subStringWith:textView.text ToIndex:charCount];
        }
    }
    
    CGSize sizeThatShouldFitTheContent = [textView sizeThatFits:CGSizeMake(textView.frame.size.width, MAXFLOAT)];
    CGRect rect = textView.frame;
    rect.size.height = sizeThatShouldFitTheContent.height;
    textView.frame = rect;
    [textView scrollRangeToVisible:NSMakeRange(0, 0)];
    
    if (self.textViewHeightChange) {
        self.textViewHeightChange(self);
    }
}


#pragma mark - - setter
- (void)setMaxFontCount:(CGFloat)maxFontCount {
    _maxFontCount = maxFontCount;
}
@end
