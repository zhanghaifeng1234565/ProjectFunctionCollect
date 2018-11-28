//
//  YMSliderVerifyAlertView.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/28.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "YMSliderVerifyAlertView.h"
#import "YMPuzzleVerifyView.h"

@interface YMSlider : UISlider

@end

@implementation YMSlider

- (CGRect)trackRectForBounds:(CGRect)bounds {
    bounds = [super trackRectForBounds:bounds];
    return CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, 8.f);
}

@end

@interface YMSliderVerifyAlertView ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) YMSlider *slider;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIButton *refreshButton;
@property (nonatomic, strong) UIImageView *resultImageView;
@property (nonatomic, strong) YMPuzzleVerifyView *puzzleView;
@property (nonatomic, assign) NSInteger remainingVerifyNumber; // 剩余验证次数
@property (nonatomic, assign) BOOL isVerified; // 用于标记是否验证成功

@end

@implementation YMSliderVerifyAlertView

#pragma mark -- Init
- (instancetype)init {
    return [self initWithMaximumVerifyNumber:1 results:nil];
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithMaximumVerifyNumber:1 results:nil];
}

- (instancetype)initWithMaximumVerifyNumber:(NSUInteger)maxNumber results:(nullable YMSliderVerificationResults)results {
    if (self = [super initWithFrame:CGRectZero]) {
        
        self.alpha = 0.f;
        self.results = results;
        self.maximumVerifyNumber = maxNumber;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        
        [self setupContentView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    return [super initWithCoder:aDecoder];
}

- (void)setupContentView {
    [self addSubview:({
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.masksToBounds = YES;
        _contentView.layer.cornerRadius = 12.f;
        _contentView;
    })];
    
    [_contentView addSubview:({
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setTitle:@"关闭" forState:UIControlStateNormal];
        [_closeButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(closeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _closeButton;
    })];
    
    [_contentView addSubview:({
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:18.f];
        _titleLabel.text = @"拖动下方滑块完成拼图";
        _titleLabel;
    })];
    
    
    [_contentView addSubview:({
        _puzzleView = [[YMPuzzleVerifyView alloc] init];
        _puzzleView.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.00];
        _puzzleView.image = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%zd.jpg", (NSInteger)(1 + (arc4random() % 5))]]];
        _puzzleView;
    })];
    
    [_contentView addSubview:({
        _slider = [[YMSlider alloc] init];
        // [UIColor colorWithRed:0.47 green:0.81 blue:0.60 alpha:1.00]
        _slider.minimumTrackTintColor = [UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1.00];
        _slider.maximumTrackTintColor = [UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1.00];
        [_slider setThumbImage:[UIImage imageNamed:@"ic_拖块"] forState:UIControlStateNormal];
        [_slider addTarget:self action:@selector(sliderValueDidChange:) forControlEvents:UIControlEventValueChanged];
        [_slider addObserver:self forKeyPath:@"tracking" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
        _slider;
    })];
    
    [_contentView addSubview:({
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.numberOfLines = 0;
        _messageLabel.font = [UIFont systemFontOfSize:14.f];
        _messageLabel.textColor = [UIColor colorWithRed:0.93 green:0.35 blue:0.29 alpha:1.00];
        _messageLabel;
    })];
    
    [_contentView addSubview:({
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.font = [UIFont boldSystemFontOfSize:18.f];
        _tipLabel.text = @"安全验证";
        _tipLabel;
    })];
    
    [_contentView addSubview:({
        _refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_refreshButton setTitle:@"刷新" forState:UIControlStateNormal];
        [_refreshButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_refreshButton addTarget:self action:@selector(refreshButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _refreshButton;
    })];
    
    [_puzzleView addSubview:({
        _resultImageView = [[UIImageView alloc] init];
        _resultImageView.hidden = YES;
        _resultImageView;
    })];
    
    [self updateLayout:NO]; // 更新布局
}

#pragma mark -- Override
- (void)updateLayout:(BOOL)animated {
    CGFloat margin = 16.f;
    CGFloat contentViewW = 303.f;
    CGFloat safeWidth = contentViewW - margin * 2;
    
    CGFloat messageLabelH = [_messageLabel sizeThatFits:CGSizeMake(safeWidth, MAXFLOAT)].height;
    CGFloat contentViewH = (messageLabelH > 0.f) ? (322.f + messageLabelH) : 329.f;
    CGFloat contentViewX = (CGRectGetWidth(self.bounds) - contentViewW) * 0.5;
    CGFloat contentViewY = (CGRectGetHeight(self.bounds) - contentViewH) * 0.5;
    
    if (animated) {
        [UIView animateWithDuration:0.2 animations:^{
            self->_contentView.frame = CGRectMake(contentViewX, contentViewY, contentViewW, contentViewH);
        }];
    } else {
        _contentView.frame = CGRectMake(contentViewX, contentViewY, contentViewW, contentViewH);
    }
    
    CGFloat closeButtonW = 40.f;
    CGFloat closeButtonX = safeWidth + margin - closeButtonW;
    _closeButton.frame = CGRectMake(closeButtonX, margin, closeButtonW, closeButtonW);
    
    CGFloat titleLabelW = CGRectGetMaxX(_closeButton.frame) - margin * 2;
    _titleLabel.frame = CGRectMake(margin, margin, titleLabelW, closeButtonW);
    
    CGFloat puzzleViewY = CGRectGetMaxY(_titleLabel.frame) + margin;
    _puzzleView.frame = CGRectMake(margin, puzzleViewY, safeWidth, 150.f);
    
    CGFloat sliderY = CGRectGetMaxY(_puzzleView.frame) + 25.f;
    _slider.frame = CGRectMake(margin, sliderY, safeWidth, 8.f);
    
    CGFloat messageLabelY = CGRectGetMaxY(_slider.frame) + 25.f;
    _messageLabel.frame = CGRectMake(margin, messageLabelY, safeWidth, messageLabelH);
    
    CGFloat refreshButtonX = CGRectGetWidth(_contentView.frame) - margin - 40.f;
    CGFloat refreshButtonY = contentViewH - 49.f;
    _refreshButton.frame = CGRectMake(refreshButtonX, refreshButtonY, 40.f, 20.f);
    
    CGFloat tipLabelW = safeWidth - 34.f;
    _tipLabel.frame = CGRectMake(margin, refreshButtonY, tipLabelW, 25.f);
    
    CGFloat resultImageViewX = (safeWidth - 48.f) * 0.5;
    CGFloat resultImageViewY = (CGRectGetHeight(_puzzleView.frame) - 48.f) * 0.5;
    _resultImageView.frame = CGRectMake(resultImageViewX, resultImageViewY, 48.f, 48.f);
}

+ (BOOL)accessInstanceVariablesDirectly {
    return NO; // 返回NO时，外部不能通过KVC赋值
}

#pragma mark -- Public Methods
- (void)show {
    _contentView.transform = CGAffineTransformMakeScale(0.5, 0.5);
    [[UIApplication sharedApplication].delegate.window addSubview:self];
    
    [UIView animateKeyframesWithDuration:0.2 delay:0.f options:(UIViewKeyframeAnimationOptionLayoutSubviews |UIViewKeyframeAnimationOptionCalculationModeCubic) animations:^{
        self.alpha = 1.f;
        self->_contentView.transform = CGAffineTransformIdentity;
    } completion:nil];
}

#pragma mark -- Action
- (void)closeButtonAction:(UIButton *)button {
    [self dismissWithDelay:0.f];
}

- (void)refreshButtonAction:(UIButton *)button {
    _slider.value = 0.f;
    _slider.enabled = YES;
    _resultImageView.hidden = YES;
    _resultImageView.image = nil;
    _puzzleView.image = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%zd.jpg", (NSInteger)(1 + (arc4random() % 12))]]];
    [_puzzleView refresh];
}

- (void)sliderValueDidChange:(UISlider *)slider {
    _puzzleView.translation = slider.value;
}

- (void)dismissWithDelay:(NSTimeInterval)delay {
    [UIView animateKeyframesWithDuration:0.2 delay:delay options:(UIViewKeyframeAnimationOptionLayoutSubviews |UIViewKeyframeAnimationOptionCalculationModeCubic) animations:^{
        self.alpha = 0.f;
        self->_contentView.transform = CGAffineTransformMakeScale(0.5, 0.5);
    } completion:^(BOOL finished) {
        [self performCallback];
        [self removeFromSuperview];
    }];
}

- (void)performCallback {
    if (!_isVerified) {
        if (_remainingVerifyNumber == 0) {
            _state = YMSliderVerifyStateFail; // 验证失败
        } else if (_remainingVerifyNumber == _maximumVerifyNumber)  {
            _state = YMSliderVerifyStateNot; // 未开始验证
        } else {
            _state = YMSliderVerifyStateIncomplete; // 未完成验证
        }
    } else {
        _state = YMSliderVerifyStateSuccess; // 验证成功
    }
    if (self.results) self.results(_state);
}

#pragma mark -- KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if([keyPath isEqualToString:@"tracking"]) {
        NSInteger oldValue = [change[@"old"] integerValue];
        NSInteger newValue = [change[@"new"] integerValue];
        if ((oldValue != 1) || (newValue != 0)) return;
        // silder 结束拖动，开始验证
        __weak typeof(self) weakSelf = self;
        [_puzzleView checkVerificationResults:^(BOOL isVerified) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (isVerified) {
                strongSelf.isVerified = YES;
                strongSelf.slider.enabled = NO;
                strongSelf.refreshButton.enabled = NO;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    strongSelf.resultImageView.hidden = NO;
                    strongSelf.resultImageView.image = [UIImage imageNamed:@"ic_成功图标"];
                });
                [strongSelf dismissWithDelay:0.6];
            } else {
                self->_isVerified = NO;
                self->_remainingVerifyNumber --;
                self->_resultImageView.hidden = NO;
                self->_resultImageView.image = [UIImage imageNamed:@"ic_失败图标"];
                
                if (self->_remainingVerifyNumber <= 0) {
                    self->_slider.enabled = NO;
                    self->_puzzleView.enable = NO;
                    self->_refreshButton.enabled = NO;
                    self->_messageLabel.text = [NSString stringWithFormat:@"您已3次验证失败，将不能继续操作！"];
                } else {
                    self->_slider.enabled = NO;
                    self->_puzzleView.enable = NO;
                    self->_messageLabel.text = [NSString stringWithFormat:@"验证失败，您还有%zd次机会！请点击刷新按钮，刷新验证码。", self->_remainingVerifyNumber];
                }
                [self updateLayout:YES];
            }
        } animated:YES];
    } else {
        return [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark -- Setter & Getter
- (void)setFrame:(CGRect)frame {
    [super setFrame:UIScreen.mainScreen.bounds];
}

- (void)setMaximumVerifyNumber:(NSUInteger)maximumVerifyNumber {
    maximumVerifyNumber = MAX(1, maximumVerifyNumber);
    
    _maximumVerifyNumber = maximumVerifyNumber;
    _remainingVerifyNumber = maximumVerifyNumber;
}

#pragma mark -- Other
- (NSAttributedString *)attributedString:(NSString *)string {
    if (string == nil) return nil;
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = 3;
    paraStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSParagraphStyleAttributeName:paraStyle};
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:string attributes:attributes];
    
    return attString;
}

- (void)dealloc {
    NSLog(@"%s", __func__);
    [_slider removeObserver:self forKeyPath:@"tracking"];
}

@end
