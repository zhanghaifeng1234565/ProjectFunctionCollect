//
//  YMOrganizationSectionHeaderView.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/10/26.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMOrganizationSectionHeaderView.h"

#import "YMOrganizationModel.h"

@interface YMOrganizationSectionHeaderView ()

/** 是否展开按钮 */
@property (nonatomic, strong) UIButton *selectBtn;
/** 标题 */
@property (nonatomic, strong) UILabel *titleLabel;
/** 是否展开按钮 */
@property (nonatomic, strong) UIButton *showBtn;
/** 分割线 */
@property (nonatomic, strong) UILabel *sepLine;
/** 公司数据模型 */
@property (nonatomic, strong) YMOrganizationCompanyModel *model;
/** 所在的组 */
@property (nonatomic, assign) NSInteger section;

@end

@implementation YMOrganizationSectionHeaderView

#pragma mark -- init
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        // MARK: 加载视图
        [self loadSubviews];
        // MARK: 配置视图
        [self configSubviews];
        // MARK: 布局视图
        [self layoutSubviews];
    }
    return self;
}

#pragma mark - - 加载视图
- (void)loadSubviews {
    [self addSubview:self.selectBtn];
    [self addSubview:self.titleLabel];
    [self addSubview:self.showBtn];
    [self addSubview:self.sepLine];
}

#pragma mark - - 配置视图
- (void)configSubviews {
    // MARK: 全选按钮
    [self.selectBtn setImage:[UIImage imageNamed:@"forward_resumes_gray_btn"] forState:UIControlStateNormal];
    [self.selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // MARK: 标题
    self.titleLabel.text = @"- -";
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    
    // MARK: 按钮
    [self.showBtn setImage:[UIImage imageNamed:@"staff_list_arrow_a"] forState:UIControlStateNormal];
    [self.showBtn addTarget:self action:@selector(showBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // MARK: 分割线
    self.sepLine.backgroundColor = [UIColor colorWithHexString:@"DDDDDD"];
}

#pragma mark - - 布局视图
- (void)layoutSubviews {
    [super layoutSubviews];

    self.showBtn.frame = CGRectMake(self.width - 46, (self.height - 30) / 2, 46, 30);
    if (self.isSingleSelect == YES) {
        self.selectBtn.frame = CGRectMake(0, self.showBtn.center.y - 15, 15, 30);
    } else {
        self.selectBtn.frame = CGRectMake(0, self.showBtn.center.y - 15, 43, 30);
    }
    self.titleLabel.frame = CGRectMake(self.selectBtn.right, self.showBtn.center.y - 15, self.width - self.showBtn.width - 30 - 10, 30);
    self.sepLine.frame = CGRectMake(self.selectBtn.right, self.height - 0.5, self.width - 15, 0.5);
}

#pragma mark -- 设置数据
- (void)setDataWithModel:(YMOrganizationCompanyModel *)model section:(NSInteger)section {
    _model = model;
    _section = section;
    
    self.titleLabel.text = model.name;
    
    if (model.departmentList.count > 0) { // 如果有下一级系那是展示按钮
        self.showBtn.hidden = NO;
    } else { // 如果没有下一级隐藏展示按钮
        self.showBtn.hidden = YES;
    }
    
    if (self.isSingleSelect == YES) {
        self.selectBtn.hidden = YES;
    } else {
        self.selectBtn.hidden = NO;
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

#pragma mark - - 全选按钮点击调用
- (void)selectBtnClick:(UIButton *)sender {
    if ([_model.isSelect isEqualToString:@"1"]) {
        _model.isSelect = @"0";
    } else if ([_model.isSelect isEqualToString:@"2"]) {
        _model.isSelect = @"2";
    } else {
        _model.isSelect = @"1";
    }
    
    // refreshType 刷新类型 如果是选中 1 进行操作
    NSDictionary *selectSectionDict = @{@"YMOrganizationCompanyModel" : _model, @"section" : @(_section), @"refreshType" : @"1"};
    // MARK: 状态改变发送通知刷新列表
    [[NSNotificationCenter defaultCenter] postNotificationName:@"YMORGAIZATIONNOTI" object:nil userInfo:selectSectionDict];
}

#pragma mark -- 展开按钮点击调用
- (void)showBtnClick:(UIButton *)sender {
    if ([_model.isShow isEqualToString:@"1"]) {
        _model.isShow = @"0";
    } else {
        _model.isShow = @"1";
    }
    
    // refreshType 刷新类型 如果是展示 2 不进行操作
    NSDictionary *selectSectionDict = @{@"YMOrganizationCompanyModel" : _model, @"section" : @(_section), @"refreshType" : @"2"};
    // MARK: 状态改变发送通知刷新列表
    [[NSNotificationCenter defaultCenter] postNotificationName:@"YMORGAIZATIONNOTI" object:nil userInfo:selectSectionDict];
}

#pragma mark - - lazyLoadUI
- (UIButton *)selectBtn {
    if (_selectBtn == nil) {
        _selectBtn = [[UIButton alloc] init];
    }
    return _selectBtn;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        
    }
    return _titleLabel;
}

- (UIButton *)showBtn {
    if (_showBtn == nil) {
        _showBtn = [[UIButton alloc] init];
    }
    return _showBtn;
}

- (UILabel *)sepLine {
    if (_sepLine == nil) {
        _sepLine = [[UILabel alloc] init];
    }
    return _sepLine;
}

@end
