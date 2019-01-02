//
//  SpecialLayerViewController.m
//  YMOCCodeStandard
//
//  Created by iOS on 2019/1/2.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "SpecialLayerViewController.h"

@interface SpecialLayerViewController ()

/// 背景滚动视图
@property (nonatomic, readwrite, strong) UIScrollView *scrollView;
/// 火柴人视图
@property (nonatomic, readwrite, strong) UIView *matchesView;
/// textLayer
@property (nonatomic, readwrite, strong) UIView *labelView;

@end

@implementation SpecialLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"专用图层";
}

#pragma mark - - 加载视图
- (void)loadSubviews {
    [super loadSubviews];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.matchesView];
    [self.scrollView addSubview:self.labelView];
}

#pragma mark - - 配置属性
- (void)configSubviews {
    [super configSubviews];
    
    self.matchesView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.labelView.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

#pragma mark - - 布局视图
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.scrollView.frame = CGRectMake(0, 0, MainScreenWidth, MainScreenHeight - NavBarHeight);
    self.matchesView.frame = CGRectMake((MainScreenWidth - 250) / 2, 30, 250, 250);
    self.labelView.frame = CGRectMake(15, self.matchesView.bottom + 30, MainScreenWidth - 30, 300);
    
    self.scrollView.contentSize = CGSizeMake(MainScreenWidth, self.labelView.bottom + 50);
    
    // 绘制火柴人
    [self graphicsMatches];
    // 圆角矩形
    [self graphicsCornerCube];
    // view textLayer 画文本
    [self crateLabelTextLayer];
    // view textLayer 画富文本
    [self createNSAttributeTextLayer];
}

#pragma mark - - 绘制火柴人
- (void)graphicsMatches {
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(self.matchesView.width / 2, 100)];
    
    [path addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    [path moveToPoint:CGPointMake(150, 125)];
    [path addLineToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(125, 225)];
    [path moveToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(175, 225)];
    [path moveToPoint:CGPointMake(100, 150)];
    [path addLineToPoint:CGPointMake(200, 150)];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 5;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    
    [self.matchesView.layer addSublayer:shapeLayer];
}

#pragma mark - - 绘制圆角矩形
- (void)graphicsCornerCube {
    CGRect rect = CGRectMake(0, 0, self.matchesView.width, self.matchesView.height);
    CGSize size = CGSizeMake(20, 20);
    UIRectCorner corners = UIRectCornerTopRight | UIRectCornerTopLeft | UIRectCornerBottomLeft;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:size];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 5;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    [self.matchesView.layer addSublayer:shapeLayer];
}

#pragma mark textLayer 创建一个 label
- (void)crateLabelTextLayer {
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = self.labelView.bounds;
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.labelView.layer addSublayer:textLayer];
    
    textLayer.foregroundColor = [UIColor blackColor].CGColor;
    textLayer.alignmentMode = kCAAlignmentJustified;
    textLayer.wrapped = YES;
    
    UIFont *font = [UIFont systemFontOfSize:15];
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    textLayer.font = fontRef;
    textLayer.fontSize = font.pointSize;
    CGFontRelease(fontRef);
    
    NSString *text = @"锄禾日当午，汗滴禾下土。谁知盘中餐，粒粒皆辛苦。锄禾日当午，汗滴禾下土。谁知盘中餐，粒粒皆辛苦。锄禾日当午，汗滴禾下土。谁知盘中餐，粒粒皆辛苦。锄禾日当午，汗滴禾下土。谁知盘中餐，粒粒皆辛苦。锄禾日当午，汗滴禾下土。谁知盘中餐，粒粒皆辛苦。锄禾日当午，汗滴禾下土。谁知盘中餐，粒粒皆辛苦。锄禾日当午，汗滴禾下土。谁知盘中餐，粒粒皆辛苦。锄禾日当午，汗滴禾下土。谁知盘中餐，粒粒皆辛苦。";
    textLayer.string = text;
}

#pragma mark textLayer 创建一个 label 富文本
- (void)createNSAttributeTextLayer {
    CATextLayer *textLayer = [[CATextLayer alloc] init];
    textLayer.frame = self.labelView.bounds;
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.labelView.layer addSublayer:textLayer];
    
    textLayer.foregroundColor = [UIColor blackColor].CGColor;
    textLayer.alignmentMode = kCAAlignmentJustified;
    textLayer.wrapped = YES;
    
    UIFont *font = [UIFont systemFontOfSize:15];
    
    NSString *text = @"锄禾日当午，汗滴禾下土。谁知盘中餐，粒粒皆辛苦。锄禾日当午，汗滴禾下土。谁知盘中餐，粒粒皆辛苦。锄禾日当午，汗滴禾下土。谁知盘中餐，粒粒皆辛苦。锄禾日当午，汗滴禾下土。谁知盘中餐，粒粒皆辛苦。锄禾日当午，汗滴禾下土。谁知盘中餐，粒粒皆辛苦。锄禾日当午，汗滴禾下土。谁知盘中餐，粒粒皆辛苦。锄禾日当午，汗滴禾下土。谁知盘中餐，粒粒皆辛苦。锄禾日当午，汗滴禾下土。谁知盘中餐，粒粒皆辛苦。";
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:text];
    
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFloat fontSize = font.pointSize;
    CTFontRef fontRef = CTFontCreateWithName(fontName, fontSize, NULL);
    
    NSDictionary *attribs = @{(__bridge id)kCTForegroundColorAttributeName : (__bridge id)[UIColor blackColor].CGColor,
                              (__bridge id)kCTFontAttributeName : (__bridge id)fontRef
                                  };
    [attString setAttributes:attribs range:NSMakeRange(0, [text length])];
    
    attribs = @{(__bridge id)kCTForegroundColorAttributeName : (__bridge id)[UIColor blueColor].CGColor,
                (__bridge id)kCTFontAttributeName : (__bridge id)fontRef,
                (__bridge id)kCTUnderlineStyleAttributeName : @(kCTUnderlineStyleSingle)};
    [attString setAttributes:attribs range:NSMakeRange(6, 5)];
    
    CFRelease(fontRef);
    
    textLayer.string = attString;
}

#pragma mark - - lazyLoadUI
- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
    }
    return _scrollView;
}

- (UIView *)matchesView {
    if (_matchesView == nil) {
        _matchesView = [[UIView alloc] init];
    }
    return _matchesView;
}

- (UIView *)labelView {
    if (_labelView == nil) {
        _labelView = [[UIView alloc] init];
    }
    return _labelView;
}

@end
