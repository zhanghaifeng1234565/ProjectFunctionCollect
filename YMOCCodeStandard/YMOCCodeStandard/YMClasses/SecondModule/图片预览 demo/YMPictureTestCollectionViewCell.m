//
//  YMPictureTestCollectionViewCell.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/5.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMPictureTestCollectionViewCell.h"

@interface YMPictureTestCollectionViewCell ()

/** 高亮不透明视图 */
@property (nonatomic, strong) UIView *alphaView;

@end

@implementation YMPictureTestCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

#pragma mark - - init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"YMPictureTestCollectionViewCell" owner:nil options:nil] firstObject];
        self.imageV.layer.masksToBounds = YES;
        self.imageV.layer.cornerRadius = 3.0f;
        [self.contentView addSubview:self.alphaView];
    }
    return self;
}

#pragma mark - - 布局视图
- (void)layoutSubviews {
    [super layoutSubviews];
    self.alphaView.frame = CGRectMake(0, 0, self.width, self.height);
}

#pragma mark - - highlight
- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    if (highlighted == YES) {
        self.alphaView.hidden = NO;
    } else {
        self.alphaView.hidden = YES;
    }
}

#pragma mark - - lazyLoadUI
- (UIView *)alphaView {
    if (_alphaView == nil) {
        _alphaView = [[UIView alloc] init];
        _alphaView.backgroundColor = [UIColor blackColor];
        _alphaView.alpha = 0.4;
        _alphaView.hidden = YES;
    }
    return _alphaView;
}

@end
