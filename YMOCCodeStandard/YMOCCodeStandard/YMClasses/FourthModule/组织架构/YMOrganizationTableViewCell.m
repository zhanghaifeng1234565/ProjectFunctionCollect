//
//  YMOrganizationTableViewCell.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/10/26.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMOrganizationTableViewCell.h"

#import "YMOrganizationModel.h"

static CGFloat kSelectBtnLeftMargin = 13 + 15;

@interface YMOrganizationTableViewCell ()

/** 背景视图 */
@property (weak, nonatomic) IBOutlet UIView *bgView;
/** 选中按钮 */
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
/** 标题 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/** 标题左侧间距 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelLeftMarginCon;
/** 分割线左侧间距 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *spLineLeftMarginCon;
/** 展示按钮 */
@property (weak, nonatomic) IBOutlet UIButton *showBtn;
/** 公司数据模型 */
@property (nonatomic, strong) YMOrganizationGeneralPurposeModel *model;
/** 所在索引 */
@property (nonatomic, strong) NSIndexPath *indexP;

@end

@implementation YMOrganizationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

#pragma mark - - init
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"YMOrganizationTableViewCell" owner:nil options:nil] firstObject];
    }
    return self;
}

#pragma mark -- 设置数据
- (void)setDataWithModel:(YMOrganizationGeneralPurposeModel *)model indexPath:(NSIndexPath *)indexP {
    _model = model;
    _indexP = indexP;
    
    self.titleLabel.text = [NSString stringWithFormat:@"%@ -- %@", model.name, model.type];
    
    if ([model.isLastLevel isEqualToString:@"1"]) { // 是最后一级隐藏展示按钮
        self.showBtn.hidden = YES;
    } else { // 不是最后一级显示展示按钮
        self.showBtn.hidden = NO;
    }
    
    if (self.isSingleSelect == YES) {
        self.selectBtn.hidden = YES;
        if ([model.type isEqualToString:@"1"]) {
            self.titleLabelLeftMarginCon.constant = 30;
            self.spLineLeftMarginCon.constant = 30;
        } else if ([model.type isEqualToString:@"2"]) {
            self.titleLabelLeftMarginCon.constant = 45;
            self.spLineLeftMarginCon.constant = 45;
        } else if ([model.type isEqualToString:@"3"]) {
            self.titleLabelLeftMarginCon.constant = 60 + kSelectBtnLeftMargin;
            self.spLineLeftMarginCon.constant = 60 + kSelectBtnLeftMargin;
            self.selectBtn.hidden = NO;
        } else {
            self.titleLabelLeftMarginCon.constant = 30;
            self.spLineLeftMarginCon.constant = 30;
        }
    } else {
        self.selectBtn.hidden = NO;
        if ([model.type isEqualToString:@"1"]) {
            self.titleLabelLeftMarginCon.constant = 30 + kSelectBtnLeftMargin;
            self.spLineLeftMarginCon.constant = 30 + kSelectBtnLeftMargin;
        } else if ([model.type isEqualToString:@"2"]) {
            self.titleLabelLeftMarginCon.constant = 45 + kSelectBtnLeftMargin;
            self.spLineLeftMarginCon.constant = 45 + kSelectBtnLeftMargin;
        } else if ([model.type isEqualToString:@"3"]) {
            self.titleLabelLeftMarginCon.constant = 60 + kSelectBtnLeftMargin;
            self.spLineLeftMarginCon.constant = 60 + kSelectBtnLeftMargin;
        } else {
            self.titleLabelLeftMarginCon.constant = 30 + kSelectBtnLeftMargin;
            self.spLineLeftMarginCon.constant = 30 + kSelectBtnLeftMargin;
        }
    }
    
    self.selectBtn.userInteractionEnabled = YES;
    if ([model.isSelect isEqualToString:@"1"]) {
        [self.selectBtn setImage:[UIImage imageNamed:@"forward_resumes_blue_btn"] forState:UIControlStateNormal];
    } else if ([model.isSelect isEqualToString:@"2"]) {
        self.selectBtn.userInteractionEnabled = NO;
        [self.selectBtn setImage:[UIImage imageNamed:@"forward_resumes_unselect_gray_btn"] forState:UIControlStateNormal];
    } else if ([model.isSelect isEqualToString:@"3"]) {
        [self.selectBtn setImage:[UIImage imageNamed:@"forward_resumes_part_select_btn"] forState:UIControlStateNormal];
    } else {
        [self.selectBtn setImage:[UIImage imageNamed:@"forward_resumes_gray_btn"] forState:UIControlStateNormal];
    }
    
    if ([model.isShow isEqualToString:@"1"]) {
        [self.showBtn setImage:[UIImage imageNamed:@"staff_list_arrow_b"] forState:UIControlStateNormal];
    } else {
        [self.showBtn setImage:[UIImage imageNamed:@"staff_list_arrow_a"] forState:UIControlStateNormal];
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
    
    NSDictionary *dict = @{@"YMOrganizationGeneralPurposeModel" : _model, @"refreshType" : @"1", @"NSINDEXPATH" : _indexP};
    // MARK: 状态改变发送通知刷新列表
    [[NSNotificationCenter defaultCenter] postNotificationName:@"YMORGAIZATIONNOTI" object:nil userInfo:dict];
}

#pragma mark - - 展开按钮点击调用
- (IBAction)showBtnClick:(UIButton *)sender {
    if ([_model.isShow isEqualToString:@"1"]) {
        _model.isShow = @"0";
    } else {
        _model.isShow = @"1";
    }
    
    NSDictionary *dict = @{@"YMOrganizationGeneralPurposeModel" : _model, @"refreshType" : @"2"};
    // MARK: 状态改变发送通知刷新列表
    [[NSNotificationCenter defaultCenter] postNotificationName:@"YMORGAIZATIONNOTI" object:nil userInfo:dict];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    if (highlighted) {
        self.bgView.backgroundColor = [UIColor colorWithHexString:@"f0f0f0"];
    } else {
        self.bgView.backgroundColor = [UIColor whiteColor];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
