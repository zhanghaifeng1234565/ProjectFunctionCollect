//
//  YMPuzzleVerifyView.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/28.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "YMPuzzleVerifyView.h"
#import "UIBezierPath+YMPuzzlePathMaker.h"

@interface YMPuzzleVerifyView ()

@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UIImageView *frontImageView;
@property (nonatomic, strong) UIImageView *puzzleImageView;
@property (nonatomic, strong) UIView *puzzleImageContainerView;

@property (nonatomic, assign) CGPoint puzzlePosition;
@property (nonatomic, assign) CGPoint blankPosition;
@property (nonatomic, assign) CGPoint containerPosition;
@property (nonatomic, strong) UIBezierPath *originalPath;

@end

@implementation YMPuzzleVerifyView

#pragma mark --  Init
- (instancetype)init {
    return [self initWithFrame:CGRectZero style:YMPuzzleVerifyStyleClassic];
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame style:YMPuzzleVerifyStyleClassic];
}

- (instancetype)initWithFrame:(CGRect)frame style:(YMPuzzleVerifyStyle)style {
    if (self = [super initWithFrame:frame]) {
        
        [self initWithStyle:style];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    return [super initWithCoder:aDecoder];
}

- (void)initWithStyle:(YMPuzzleVerifyStyle)style {
    self.clipsToBounds = YES;
    self.enable = YES;
    self.style = style;
    self.tolerance = 5.f;
    self.puzzleSize = CGSizeMake(40.f, 40.f);
    self.containerInsert = UIEdgeInsetsZero;
    
    _backImageView = [[UIImageView alloc] init];
    _backImageView.alpha = 0.f;
    [self addSubview:_backImageView];
    
    _frontImageView = [[UIImageView alloc] init];
    [self addSubview:_frontImageView];
    
    _puzzleImageContainerView = [[UIView alloc] init];
    _puzzleImageContainerView.layer.shadowColor = [UIColor blackColor].CGColor;
    _puzzleImageContainerView.layer.shadowRadius = 4.f;
    _puzzleImageContainerView.layer.shadowOpacity = 1.f;
    _puzzleImageContainerView.layer.shadowOffset = CGSizeZero;
    [self addSubview:_puzzleImageContainerView];
    
    _puzzleImageView = [[UIImageView alloc] init];
    [_puzzleImageContainerView addSubview:_puzzleImageView];
}

#pragma mark -- Public Methods
- (void)refresh {
    _enable = YES;
    
    [self setTranslation:0.f];
    [self setContainerInsert:_containerInsert];
}

- (void)checkVerificationResults:(nullable void (^)(BOOL isVerified))result animated:(BOOL)animated {
    _isVerified = (fabs(_puzzlePosition.x - _blankPosition.x) <= _tolerance);
    
    if (_isVerified) {
        _enable = NO;
        _frontImageView.layer.mask = nil;
        _puzzleImageContainerView.hidden = YES;
        if (animated) [self showSuccessfulAnimation];
    } else {
        if (animated) [self showFailedAnimation];
    }
    if (result) result(_isVerified);
}

#pragma mark -- Override
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self setContainerInsert:_containerInsert];
    
    _backImageView.frame = self.bounds;
    _frontImageView.frame = self.bounds;
    _puzzleImageContainerView.frame = CGRectMake(_containerPosition.x, _containerPosition.y,
                                                 CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    _puzzleImageView.frame = _puzzleImageContainerView.bounds;
    
    [self updatePuzzleMask];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview) [self updatePuzzleMask];
}

#pragma mark -- Setter && Getter
- (void)setImage:(UIImage *)image {
    _image = image;
    
    _backImageView.image = image;
    _frontImageView.image = image;
    _puzzleImageView.image = image;
    
    [self updatePuzzleMask];
}

- (void)setTolerance:(CGFloat)tolerance {
    _tolerance = fabs(tolerance);
}

- (void)setContainerInsert:(UIEdgeInsets)containerInsert {
    _containerInsert = containerInsert;
    
    // 计算容器范围
    CGRect containerRect = CGRectMake(containerInsert.left,
                                      containerInsert.top,
                                      CGRectGetWidth(self.bounds) - containerInsert.left - containerInsert.right,
                                      CGRectGetHeight(self.bounds) - containerInsert.top - containerInsert.bottom);
    // 获取随机位置，这里只取整
    CGFloat minimumDistance = 50.f; // 最小间距
    NSInteger intX = (NSInteger)(floorf(CGRectGetWidth(containerRect) - _puzzleSize.width * 2 - minimumDistance));
    NSInteger randomX = containerInsert.left + _puzzleSize.width + minimumDistance + (arc4random() % (intX + 1));
    NSInteger intY = (NSInteger)(floorf(CGRectGetHeight(containerRect) - _puzzleSize.width));
    NSInteger randomY = containerInsert.top + (arc4random() % (intY + 1));
    // 设置滑块和空白处位置
    _puzzlePosition = CGPointMake(containerInsert.left, randomY);
    _blankPosition = CGPointMake(randomX, randomY);
    [self setContainerPosition:CGPointMake(_puzzlePosition.x - _blankPosition.x,
                                           _puzzlePosition.y - _blankPosition.y)];
    [self setStyle:_style];
    [self setPuzzlePath:_originalPath];
}

- (void)setContainerPosition:(CGPoint)containerPosition {
    _containerPosition = containerPosition;
    
    CGRect frame = _puzzleImageContainerView.frame;
    frame.origin = containerPosition;
    _puzzleImageContainerView.frame = frame;
}

- (void)setPuzzleSize:(CGSize)puzzleSize {
    _puzzleSize = puzzleSize;
    [self setContainerInsert:_containerInsert];
}

- (void)setStyle:(YMPuzzleVerifyStyle)style {
    _style = style;
    
    if (style == YMPuzzleVerifyStyleCustom) return;
    
    UIBezierPath *path = [self pathForStyle:style];
    UIBezierPath *tempPath = [UIBezierPath bezierPathWithCGPath:path.CGPath];
    [tempPath applyTransform:CGAffineTransformMakeScale(_puzzleSize.width / tempPath.bounds.size.width,
                                                        _puzzleSize.height / tempPath.bounds.size.height)];
    [tempPath applyTransform:CGAffineTransformMakeTranslation(_blankPosition.x - tempPath.bounds.origin.x,
                                                              _blankPosition.y - tempPath.bounds.origin.y)];
    _puzzlePath = tempPath;
    
    [self updatePuzzleMask];
}

- (void)setPuzzlePath:(UIBezierPath *)puzzlePath {
    _originalPath = puzzlePath; // 保留原始值
    
    if (_style != YMPuzzleVerifyStyleCustom) return;
    
    UIBezierPath *tempPath = [UIBezierPath bezierPathWithCGPath:puzzlePath.CGPath];
    [tempPath applyTransform:CGAffineTransformMakeTranslation(_blankPosition.x - tempPath.bounds.origin.x,
                                                              _blankPosition.y - tempPath.bounds.origin.y)];
    _puzzlePath = tempPath;
    
    [self updatePuzzleMask];
}

- (void)setTranslation:(CGFloat)translation {
    if (!_enable) return;
    
    translation = MAX(0.f, translation);
    translation = MIN(1.f, translation);
    
    _translation = translation;
    
    _puzzlePosition.x = _containerInsert.left + translation * (CGRectGetWidth(self.bounds) - _containerInsert.left - _puzzleSize.width);
    [self setContainerPosition:CGPointMake(_puzzlePosition.x - _blankPosition.x,
                                           _puzzlePosition.y - _blankPosition.y)];
}

#pragma mark -- Other
- (void)updatePuzzleMask {
    if (self.superview == nil) return;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRect:self.bounds];
    [maskPath appendPath:[UIBezierPath bezierPathWithCGPath:_puzzlePath.CGPath]];
    maskPath.usesEvenOddFillRule = YES;
    
    CAShapeLayer *backMaskLayer = [CAShapeLayer new];
    backMaskLayer.frame = self.bounds;
    backMaskLayer.path = _puzzlePath.CGPath;
    backMaskLayer.fillRule = kCAFillRuleEvenOdd;
    
    CAShapeLayer *frontMaskLayer = [CAShapeLayer new];
    frontMaskLayer.frame = self.bounds;
    frontMaskLayer.path = maskPath.CGPath;
    frontMaskLayer.fillRule = kCAFillRuleEvenOdd;
    
    CAShapeLayer *puzzleMaskLayer = [CAShapeLayer new];
    puzzleMaskLayer.frame = self.bounds;
    puzzleMaskLayer.path = _puzzlePath.CGPath;
    
    _backImageView.layer.mask = backMaskLayer;
    _frontImageView.layer.mask = frontMaskLayer;
    _puzzleImageView.layer.mask = puzzleMaskLayer;
}

- (void)showSuccessfulAnimation {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.duration = 0.2;
    animation.autoreverses = YES;
    animation.fromValue = @(1);
    animation.toValue = @(0);
    [self.layer addAnimation:animation forKey:@"successfulAnimation"];
}

- (void)showFailedAnimation {
    CGFloat positionX = _puzzleImageContainerView.layer.position.x;
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    animation.duration = 0.2;
    animation.repeatCount = 2;
    animation.values = @[@(positionX), @(positionX - 3), @(positionX + 3), @(positionX)];
    [_puzzleImageContainerView.layer addAnimation:animation forKey:@"failedAnimation"];
}

- (UIBezierPath *)pathForStyle:(YMPuzzleVerifyStyle)style {
    switch (style) {
        case YMPuzzleVerifyStyleClassic:
            return [self classicPuzzlePath];
        case YMPuzzleVerifyStyleSquare:
            return [self squarePuzzlePath];
        case YMPuzzleVerifyStyleCircle:
            return [self circlePuzzlePath];
        case YMPuzzleVerifyStyleCustom:
            return nil;
    }
}

- (UIBezierPath *)classicPuzzlePath {
    static UIBezierPath *classicPath;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        classicPath = [UIBezierPath ym_bezierPathWithPathMaker:^(YMPuzzlePathMaker * _Nonnull maker) {
            maker.moveTo(0.f, 8.f)
            .addLineTo(12.f, 8.f)
            .addArcWithPoint(12.f, 8.f, 20.f, 8.f, 5.f, YES, YES)
            .addLineTo(32.f, 8.f)
            .addLineTo(32.f, 20.f)
            .addArcWithPoint(32.f, 20.f, 32.f, 28.f, 5.f, YES, YES)
            .addLineTo(32.f, 40.f)
            .addLineTo(20.f, 40.f)
            .addArcWithPoint(20.f, 40.f, 12.f, 40.f, 5.f, NO, YES)
            .addLineTo(0.f, 40.f)
            .addLineTo(0.f, 28.f)
            .addArcWithPoint(0.f, 28.f, 0.f, 20.f, 5.f, NO, YES)
            .closePath();
        }];
    });
    return classicPath;
}

- (UIBezierPath *)squarePuzzlePath {
    static UIBezierPath *squarePath;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        squarePath = [UIBezierPath bezierPathWithRect:CGRectMake(0.f, 0.f, 100.f, 100.f)];
    });
    return squarePath;
}

- (UIBezierPath *)circlePuzzlePath {
    static UIBezierPath *circlePath;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        circlePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0.f, 0.f, 100.f, 100.f)];
    });
    return circlePath;
}


@end
