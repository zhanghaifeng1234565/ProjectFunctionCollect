//
//  YMFormTextViewTableViewCell.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/26.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "YMFormTextViewTableViewCell.h"

#import "YMDemoFormModel.h"

@implementation YMFormTextViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"YMFormTextViewTableViewCell" owner:nil options:nil] firstObject];
        
        self.textView.scrollEnabled = NO ;
        self.textView.maxFontCount = 50;
        self.textView.placeholder = @"请输入 textView";
        self.textView.placeholderFont = 14;
        self.textView.placeholderColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)setModel:(YMDemoFormModel *)model {
    _model = model;
    
    switch (self.indexPath.row) {
        case 2:
        {
            self.textView.text = model.textViewStr;
        }
            break;
        case 5:
        {
            self.textView.text = model.textViewStr1;
        }
            break;
        case 8:
        {
            self.textView.text = model.textViewStr2;
        }
            break;
        default:
            self.textView.text = model.textViewStr;
            break;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
