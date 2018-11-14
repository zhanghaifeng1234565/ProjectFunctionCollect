//
//  YMBasePickerView.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/12.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "YMBasePickerView.h"
#import "YMPickerToolBarView.h"

@interface YMBasePickerView ()

/** 透明视图 */
@property (nonatomic, strong) UIControl *alphaView;
/** 内容视图 */
@property (nonatomic, strong, readwrite) UIView *contentView;
/** 工具栏 */
@property (nonatomic, strong) YMPickerToolBarView *toolBarView;

/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 左侧按钮标签 */
@property (nonatomic, copy) NSString *leftBtnTitle;
/** 右侧按钮标签 */
@property (nonatomic, copy) NSString *rightBtnTitle;

@end

@implementation YMBasePickerView

#pragma mark - - init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // MARK: 加载视图
        [self loadSubviews];
        // MARK: 配置视图
        [self configProprty];
        // MARK: 需要的时候布局
        [self layoutIfNeeded];
        // MARK: 按钮点击调用
        [self buttonClickMethod];
        // MARK: 加载数据
        [self loadData];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame delegate:(id<YMBasePickerViewDelegate>)delegate title:(NSString *)title leftBtnTitle:(NSString *)leftBtnTitle rightBtnTitle:(NSString *)rightBtnTitle {
    if (self = [super initWithFrame:frame]) {
        self.title = title;
        self.leftBtnTitle = leftBtnTitle;
        self.rightBtnTitle = rightBtnTitle;
        
        // MARK: 加载视图
        [self loadSubviews];
        // MARK: 配置视图
        [self configProprty];
        // MARK: 需要的时候布局
        [self layoutIfNeeded];
        // MARK: 按钮点击调用
        [self buttonClickMethod];
        // MARK: 加载数据
        [self loadData];
        
        self.delegate = delegate;
    }
    return self;
}

#pragma mark - - 加载视图
- (void)loadSubviews {
    [self addSubview:self.alphaView];
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.toolBarView];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

#pragma mark - - 配置属性
- (void)configProprty {
    // MARK: self
    self.hidden = YES;
    
    // MARK: 透明视图
    self.alphaView.backgroundColor = [UIColor blackColor];
    self.alphaView.alpha = 0.5f;
    [self.alphaView addTarget:self action:@selector(alphaViewAction) forControlEvents:UIControlEventTouchUpInside];
    
    // MARK: 内容视图
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    // MARK: 工具栏
    self.toolBarView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    if (self.title &&
        ![self.title isEqualToString:@""]) {
        self.toolBarView.titleLabel.text = self.title;
    }
    
    if (self.leftBtnTitle &&
        ![self.leftBtnTitle isEqualToString:@""]) {
        [self.toolBarView.leftBtn setTitle:self.leftBtnTitle forState:UIControlStateNormal];
    }
    
    if (self.rightBtnTitle &&
        ![self.rightBtnTitle isEqualToString:@""]) {
        [self.toolBarView.rightBtn setTitle:self.rightBtnTitle forState:UIControlStateNormal];
    }
}

#pragma mark - - 布局视图
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.alphaView.frame = CGRectMake(0, 0, self.width, self.height);
    self.contentView.frame = CGRectMake(0, self.height, self.width, kContentViewHeight);
    self.toolBarView.frame = CGRectMake(0, 0, self.contentView.width, kToolBarViewHeight);
}

#pragma mark - - 透明视图点击调用
- (void)alphaViewAction {
    NSLog(@"我是透明视图，我被点击了");
    [self hide];
}

#pragma mark  按钮点击调用
- (void)buttonClickMethod {
    __weak typeof(&*self) ws = self;
    // 工具栏左侧按钮点击调用
    self.toolBarView.leftBtnClickBlock = ^(UIButton * _Nonnull sender) {
        if ([ws.delegate respondsToSelector:@selector(actionWithButton:)]) {
            [ws.delegate actionWithButton:sender];
        }
        [ws hide];
    };
    
    // 工具栏右侧按钮点击调用
    self.toolBarView.rightBtnClickBlcok = ^(UIButton * _Nonnull sender) {
        if ([ws.delegate respondsToSelector:@selector(actionWithButton:)]) {
            [ws.delegate actionWithButton:sender];
        }
        [ws hide];
    };
}

#pragma mark - - 加载数据
- (void)loadData {
    
}

#pragma mark - - 显示
- (void)show {
    self.contentView.top = self.height;
    self.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.top = self.height - kContentViewHeight;
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark  隐藏
- (void)hide {
    self.hidden = YES;
}

#pragma mark - - lazyLoadUI
- (UIControl *)alphaView {
    if (_alphaView == nil) {
        _alphaView = [[UIControl alloc] init];
    }
    return _alphaView;
}

- (UIView *)contentView {
    if (_contentView == nil) {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}

- (YMPickerToolBarView *)toolBarView {
    if (_toolBarView == nil) {
        _toolBarView = [[YMPickerToolBarView alloc] init];
    }
    return _toolBarView;
}


#pragma mark - - lazyLoadData

@end
