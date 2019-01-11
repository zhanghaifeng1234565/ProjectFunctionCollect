//
//  ImageIOCollectionViewCell.m
//  YMOCCodeStandard
//
//  Created by iOS on 2019/1/11.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "ImageIOCollectionViewCell.h"

@interface ImageIOCollectionViewCell ()

/// 分割线
@property (nonatomic, readwrite, strong) UIView *spLineView;

@end

@implementation ImageIOCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self loadSubviews];
    [self configSubviews];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self loadSubviews];
        [self configSubviews];
    }
    return self;
}

#pragma mark - - 加载视图
- (void)loadSubviews {
    [self.contentView addSubview:self.imageV];
    [self.contentView addSubview:self.spLineView];
}

#pragma mark - - 配置视图
- (void)configSubviews {
    self.spLineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

#pragma mark - - 布局
- (void)layoutSubviews {
    self.imageV.frame = CGRectMake(0, 0, self.width, self.height);
    self.spLineView.frame = CGRectMake(0, self.height - 0.5, self.width, 0.5);
}

#pragma mark - - lazyLoadUI
- (YMHighlightImageView *)imageV {
    if (_imageV == nil) {
        _imageV = [[YMHighlightImageView alloc] init];
    }
    return _imageV;
}

- (UIView *)spLineView {
    if (_spLineView == nil) {
        _spLineView = [[UIView alloc] init];
    }
    return _spLineView;
}

@end
