//
//  YMOrganizationSearchTableViewCell.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/10/30.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMOrganizationSearchTableViewCell.h"

#import "YMOrganizationModel.h"

@interface YMOrganizationSearchTableViewCell ()

/** 选中按钮 */
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
/** 标题 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation YMOrganizationSearchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"YMOrganizationSearchTableViewCell" owner:nil options:nil] firstObject];
    }
    return self;
}

#pragma mark -- 数据源模型
- (void)setModel:(YMOrganizationStaffModel *)model {
    _model = model;
    
    self.titleLabel.text = [NSString stringWithFormat:@"%@", model.name];
    
    if ([model.isSelect isEqualToString:@"1"]) {
        [self.selectBtn setImage:[UIImage imageNamed:@"forward_resumes_blue_btn"] forState:UIControlStateNormal];
    } else if ([model.isSelect isEqualToString:@"2"]) {
        [self.selectBtn setImage:[UIImage imageNamed:@"forward_resumes_unselect_gray_btn"] forState:UIControlStateNormal];
    } else {
        [self.selectBtn setImage:[UIImage imageNamed:@"forward_resumes_gray_btn"] forState:UIControlStateNormal];
    }
}

#pragma mark -- 选中按钮点击调用
- (IBAction)selectBtnClick:(UIButton *)sender {
    if ([_model.isSelect isEqualToString:@"1"]) {
        _model.isSelect = @"0";
    } else if ([_model.isSelect isEqualToString:@"2"]) {
        _model.isSelect = @"2";
    } else {
        _model.isSelect = @"1";
    }
    
    // refreshType 搜索视图刷新
    NSDictionary *dict = @{@"YMOrganizationGeneralPurposeModel" : _model, @"refreshType" : @"3", @"SEARCHNSINDEXPATH" : self.indexPath};
    // MARK: 状态改变发送通知刷新列表
    [[NSNotificationCenter defaultCenter] postNotificationName:@"YMORGAIZATIONNOTI" object:nil userInfo:dict];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
