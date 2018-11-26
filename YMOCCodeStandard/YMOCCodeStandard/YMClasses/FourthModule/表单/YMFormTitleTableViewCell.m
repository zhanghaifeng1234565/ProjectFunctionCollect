//
//  YMFormTitleTableViewCell.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/26.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "YMFormTitleTableViewCell.h"

#import "YMDemoFormModel.h"

@implementation YMFormTitleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"YMFormTitleTableViewCell" owner:nil options:nil] firstObject];
    }
    return self;
}

- (void)setModel:(YMDemoFormModel *)model {
    _model = model;
    
    switch (self.indexPath.row) {
        case 0:
        {
            self.titleLabel.text = model.titleStr;
        }
            break;
        case 3:
        {
            self.titleLabel.text = model.titleStr1;
        }
            break;
        case 6:
        {
            self.titleLabel.text = model.titleStr2;
        }
            break;
        case 9:
        {
            self.titleLabel.text = model.titleStr3;
        }
            break;
        default:
            self.titleLabel.text = model.titleStr;
            break;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
