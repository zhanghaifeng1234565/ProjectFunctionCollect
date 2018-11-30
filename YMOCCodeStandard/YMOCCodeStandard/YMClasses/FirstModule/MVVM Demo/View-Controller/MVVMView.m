//
//  MVVMView.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/30.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "MVVMView.h"

#import "MVVMViewModel.h"

@interface MVVMView ()

/// 输入框
@property (nonatomic, readwrite, strong) YMLimitTextField *textField;
/// 展示 label
@property (nonatomic, readwrite, strong) UILabel *showLabel;
/// 上传数据按钮
@property (nonatomic, readwrite, strong) UIButton *upLoadButton;


/// 静态字符串初始值为 showLable.text
@property (nonatomic, readwrite, copy) NSString *staticStr;

@end

@implementation MVVMView

#pragma mark - - init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // MARK: 加载视图
        [self ymLoadSubviews];
        // MARK: 配置视图
        [self ymConfigSubviews];
    }
    return self;
}

#pragma mark - - 加载视图
- (void)ymLoadSubviews {
    [self addSubview:self.textField];
    [self addSubview:self.showLabel];
    [self addSubview:self.upLoadButton];
}

#pragma mark - -
- (void)ymConfigSubviews {
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    // MARK: textField
    __weak typeof(&*self) wsSelf = self;
    self.textField.textFieldChange = ^(YMLimitTextField * _Nonnull textField) {
        NSLog(@"%@", textField.text);
        __strong typeof(&*wsSelf) self = wsSelf;
        self.showLabel.text = [NSString stringWithFormat:@"%@ - %@", self.staticStr, textField.text];
        
        self.viewModel.model.textFieldStr = textField.text;
        self.viewModel.model.labelStr = self.showLabel.text;
        [self layoutSubviews];
    };
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [UITextField ym_view:self.textField backgroundColor:[UIColor whiteColor] cornerRadius:3.0f borderWidth:0.5f borderColor:[UIColor magentaColor]];
    [UITextField ym_textField:self.textField placeHolder:@"mvvm textField" placeHolderColor:[UIColor magentaColor] fontSize:14];
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 45)];
    [UITextField ym_textField:self.textField leftView:leftView];
    
    // MARK: label
    [UILabel ym_label:self.showLabel fontSize:15 textColor:[UIColor colorWithHexString:@"333333"]];
    self.showLabel.textAlignment = NSTextAlignmentCenter;
    
    // MARK: button
    [UIButton ym_button:self.upLoadButton title:@"上传" fontSize:15 titleColor:[UIColor magentaColor]];
    [UIButton ym_view:self.upLoadButton backgroundColor:[UIColor whiteColor] cornerRadius:3.0f borderWidth:0.5f borderColor:[UIColor magentaColor]];
    [self.upLoadButton addTarget:self action:@selector(upLoadButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.upLoadButton.ym_timeInterval = 2.0f;
}

#pragma mark - - 布局视图
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.textField.frame = CGRectMake(15, 15, self.frame.size.width - 30, 45);
    
    CGFloat labelHeight = [UILabel ym_getHeightWithString:self.showLabel.text fontSize:17 lineSpace:0 maxWidth:self.width - 30];
    self.showLabel.frame = CGRectMake(15, self.textField.bottom + 30, self.frame.size.width - 30, labelHeight);
    self.upLoadButton.frame = CGRectMake(15, self.showLabel.bottom + 15, self.width - 30, 45);
    self.height = self.upLoadButton.bottom + 30;
}

#pragma mark - - 设置数据
- (void)setViewModel:(MVVMViewModel *)viewModel {
    _viewModel = viewModel;
    
    self.textField.text = viewModel.model.textFieldStr;
    self.showLabel.text = viewModel.model.labelStr;
    self.staticStr = viewModel.model.labelStr;
}

#pragma mark - - 上传按钮点击调用
- (void)upLoadButtonClick {
    [self.viewModel upLoadData];
}

#pragma mark - - lazyLoadUI
- (YMLimitTextField *)textField {
    if (_textField == nil) {
        _textField = [[YMLimitTextField alloc] init];
    }
    return _textField;
}

- (UILabel *)showLabel {
    if (_showLabel == nil) {
        _showLabel = [[UILabel alloc] init];
    }
    return _showLabel;
}

- (UIButton *)upLoadButton {
    if (_upLoadButton == nil) {
        _upLoadButton = [[UIButton alloc] init];
    }
    return _upLoadButton;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
