//
//  YMMiddleMenuTableViewCell.m
//  OAManagementSystem
//
//  Created by iOS on 2018/5/8.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMMiddleMenuTableViewCell.h"

@implementation YMMiddleMenuTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"YMMiddleMenuTableViewCell" owner:nil options:nil] lastObject];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    if (highlighted) {
        self.backgroundColor = [UIColor colorWithHexString:@"f0f0f0"];
    } else {
        self.backgroundColor = [UIColor whiteColor];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
