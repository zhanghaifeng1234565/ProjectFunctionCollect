//
//  YMLoadingView.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/9/17.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMLoadingView.h"

/** loading 宽度 */
static const CGFloat kActiveViewWidth = 70;
/** loading 高度 */
static const CGFloat kActiveViewHeight = 70;
/** clickLoadView 宽度 */
static const CGFloat kClickLoadViewWidth = 200;
/** clickLoadView 高度 */
static const CGFloat kClickLoadViewHeight = 160;

@implementation YMLoadingView {
    /** loadingImage */
    UIImageView *_activeView;
    /** clickImage */
    UIImageView *_clickLoadView;
}

#pragma mark -- init
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark -- 创建视图
- (void)initView {
    self.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i <= 24; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"page_loading%zd", i]];
        [refreshingImages addObject:image];
    }
    UIImage *image = [UIImage animatedImageWithImages:refreshingImages duration:1.0f];
    
    _activeView = [[UIImageView alloc]init];
    _activeView.backgroundColor = [UIColor clearColor];
    _activeView.image = image;
    _activeView.frame = CGRectMake((self.width - kActiveViewWidth) /2, (self.height - kActiveViewHeight) / 2 , kActiveViewWidth, kActiveViewHeight);
    [self addSubview:_activeView];
    [_activeView startAnimating];
    
    _clickLoadView = [[UIImageView alloc] initWithFrame:CGRectMake((self.width - kClickLoadViewWidth) / 2, (self.height - kClickLoadViewHeight) / 2 - 50, kClickLoadViewWidth, kClickLoadViewHeight)];
    _clickLoadView.image = [UIImage imageNamed:@"no_network"];
    [self addSubview:_clickLoadView];
    _clickLoadView.hidden = YES;
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _clickLoadView.bottom + 30, self.width, 18)];
    _titleLabel.text = @"咦？咋木有网了呢~";
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor colorWithHexString:@"999999"];
    _titleLabel.font = [UIFont systemFontOfSize:17];
    [self addSubview:_titleLabel];
    _titleLabel.hidden = YES;
    
    _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _titleLabel.bottom + 8, self.width, 14)];
    _contentLabel.text = @"请检查您的网络连接";
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    _contentLabel.textColor = [UIColor colorWithHexString:@"b2b2b2"];
    _contentLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_contentLabel];
    _contentLabel.hidden = YES;
    
    _clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _clickBtn.frame = CGRectMake(0, 0, self.width, self.height);
    [self addSubview:_clickBtn];
    _clickBtn.hidden = YES;
}

#pragma mark -- setter
- (void)setLoadFailStatus:(BOOL)loadFailStatus{
    _loadFailStatus = loadFailStatus;
    if (loadFailStatus) {
        _clickLoadView.image = [UIImage imageNamed:@"no_network"];
        _titleLabel.text = @"咦？咋木有网了呢~";
        _contentLabel.text = @"请检查您的网络连接";
    } else {
        _clickLoadView.image = [UIImage imageNamed:@"the_server"];
        _titleLabel.text = @"咦？服务器开小差了~";
        _contentLabel.text = @"请您点击屏幕重试";
    }
}

- (void)setLoadNetFail:(BOOL)loadNetFail {
    _loadNetFail = loadNetFail;
    if (_loadNetFail) {
        [_activeView stopAnimating];
        _activeView.hidden = YES;
        _titleLabel.hidden = NO;
        _contentLabel.hidden = NO;
        _clickBtn.hidden = NO;
        _clickBtn.userInteractionEnabled = YES;
        _clickLoadView.hidden = NO;
        self.userInteractionEnabled = YES;
    } else {
        [_activeView startAnimating];
        _activeView.hidden = NO;
        _titleLabel.hidden = YES;
        _contentLabel.hidden = YES;
        _clickBtn.hidden = YES;
        _clickBtn.userInteractionEnabled = NO;
        _clickLoadView.hidden = YES;
        self.userInteractionEnabled = NO;
    }
}

@end
