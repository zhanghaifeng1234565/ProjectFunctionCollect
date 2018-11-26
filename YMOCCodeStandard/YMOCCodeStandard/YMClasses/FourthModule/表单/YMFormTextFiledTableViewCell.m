//
//  YMFormTextFiledTableViewCell.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/26.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "YMFormTextFiledTableViewCell.h"

#import "YMDemoFormModel.h"

@implementation YMFormTextFiledTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"YMFormTextFiledTableViewCell" owner:nil options:nil] firstObject];
        
        self.textField.attributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:@"请输入 textField" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14], NSForegroundColorAttributeName : [UIColor lightGrayColor]}];
        self.textField.maxFontCount = 20;
    }
    return self;
}

- (void)setModel:(YMDemoFormModel *)model {
    _model = model;
    
    switch (self.indexPath.row) {
        case 1:
        {
            self.textField.text = model.textFiedStr;
        }
            break;
        case 4:
        {
            self.textField.text = model.textFiedStr1;
        }
            break;
        case 7:
        {
            self.textField.text = model.textFiedStr2;
        }
            break;
        default:
            self.textField.text = model.textFiedStr;
            break;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
