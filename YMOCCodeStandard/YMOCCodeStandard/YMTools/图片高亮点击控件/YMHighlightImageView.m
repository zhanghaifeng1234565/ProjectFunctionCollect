//
//  YMHighlightImageView.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/8.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "YMHighlightImageView.h"

@interface YMHighlightImageView ()

/** 高亮不透明视图 */
@property (nonatomic, strong) UIView *alphaView;

@end

@implementation YMHighlightImageView

#pragma mark - - init
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.alphaView];
    }
    return self;
}

#pragma mark - - 布局视图
- (void)layoutSubviews {
    [super layoutSubviews];
    self.alphaView.frame = CGRectMake(0, 0, self.width, self.height);
}

#pragma mark - - touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.alphaView.hidden = NO;
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    self.alphaView.hidden = YES;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.alphaView.hidden = YES;
}

#pragma mark - - lazyLoadUI
- (UIView *)alphaView {
    if (_alphaView == nil) {
        _alphaView = [[UIView alloc] init];
        _alphaView.backgroundColor = [UIColor blackColor];
        _alphaView.alpha = 0.4;
        _alphaView.hidden = YES;
        _alphaView.userInteractionEnabled = NO;
    }
    return _alphaView;
}

@end
