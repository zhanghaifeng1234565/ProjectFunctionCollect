//
//  YMBaseTableViewCell.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/10/23.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMBaseTableViewCell.h"

@interface YMBaseTableViewCell ()

/** 分割线 */
@property (nonatomic, strong) UILabel *spLine;

@end

@implementation YMBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

#pragma mark -- init
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.spLine];
    }
    return self;
}

#pragma mark -- 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    self.spLine.frame = CGRectMake(15, self.height - 0.5, self.width - 15, 0.5);
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    if (highlighted) {
        self.backgroundColor = [UIColor colorWithHexString:@"f0f0f0"];
    } else {
        self.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

#pragma mark -- lazyLoadUI
- (UILabel *)spLine {
    if (_spLine == nil) {
        _spLine = [[UILabel alloc] init];
        _spLine.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
    }
    return _spLine;
}

@end
