//
//  YMActiveAlertView.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/10/23.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMActiveAlertView.h"
#import "YMWKWebView.h"

#define kContentViewWidth  (290 * MainScreenWidth_Scale)
#define kContentViewHeight (500 * MainScreenHeight_Scale)

@interface YMActiveAlertView ()

/** 透明视图 */
@property (nonatomic, strong) UIControl *alphaView;
/** 内容视图 */
@property (nonatomic, strong) UIControl *contentView;
/** 活动页是 web */
@property (nonatomic, strong) YMWKWebView *wkWebView;

@end

@implementation YMActiveAlertView

#pragma mark -- dealloc
- (void)dealloc {
    NSLog(@"dealloc -- %@", [self class]);
}

#pragma mark -- init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // MARK: 加载视图
        [self loadSubviews];
        // MARK: 配置视图
        [self configSubviews];
        // MARK: 布局视图
        [self layoutSubviews];
    }
    return self;
}

#pragma mark -- 加载视图
- (void)loadSubviews {
    [self addSubview:self.alphaView];
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.wkWebView];
}

#pragma mark -- 配置视图
- (void)configSubviews {
    self.alphaView.backgroundColor = [UIColor blackColor];
    self.alphaView.alpha = 0.3;
    [self.alphaView addTarget:self action:@selector(hiddenAlert) forControlEvents:UIControlEventTouchUpInside];
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.cornerRadius = 6.0f;
    [self.contentView addTarget:self action:@selector(keyboardHidden) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark -- 布局视图
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.alphaView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.contentView.frame = CGRectMake((self.frame.size.width - kContentViewWidth) / 2, (self.frame.size.height - kContentViewHeight) / 2, kContentViewWidth, kContentViewHeight);
}

#pragma mark -- 展示
- (void)showAlertInParsentView:(UIView *)parsentView {
    for (UIView *view in parsentView.subviews) {
        if ([view isKindOfClass:[self class]]) {
            [view removeFromSuperview];
        }
    }
    
    self.contentView.alpha = 0;
    self.contentView.transform = CGAffineTransformScale(self.contentView.transform, 0.1, 0.1);
    [UIView animateWithDuration:0.2 animations:^{
        self.contentView.transform = CGAffineTransformIdentity;
        self.contentView.alpha = 1;
    }];
    [parsentView addSubview:self];
}

#pragma mark -- 隐藏
- (void)hiddenAlert {
    [self removeFromSuperview];
}

#pragma mark -- 键盘隐藏
- (void)keyboardHidden {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

#pragma mark -- lazyLoadUI
- (UIControl *)alphaView {
    if (_alphaView == nil) {
        _alphaView = [[UIControl alloc] init];
    }
    return _alphaView;
}

- (UIControl *)contentView {
    if (_contentView == nil) {
        _contentView = [[UIControl alloc] init];
    }
    return _contentView;
}

- (YMWKWebView *)wkWebView {
    if (_wkWebView==nil) {
        _wkWebView = [[YMWKWebView alloc] initWithFrame:CGRectMake(0, 0, kContentViewWidth, kContentViewHeight)];
        _wkWebView.wkWebView.scrollView.showsHorizontalScrollIndicator = NO;
        _wkWebView.wkWebView.scrollView.showsVerticalScrollIndicator = NO;
        _wkWebView.webViewUrl = @"https://www.baidu.com";
        _wkWebView.webViewBarTintColor = @"03abff";
    }
    return _wkWebView;
}
@end
