//
//  LayerTimeViewController.m
//  YMOCCodeStandard
//
//  Created by iOS on 2019/1/8.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "LayerTimeViewController.h"

@interface LayerTimeViewController ()
<UIGestureRecognizerDelegate>

/// 滚动视图
@property (nonatomic, readwrite, strong) UIScrollView *scrollView;
/// 门视图
@property (nonatomic, readwrite, strong) UIView *doorView;
/// 门图层
@property (nonatomic, readwrite, strong) CALayer *doorLayer;

/// 飞船视图
@property (nonatomic, readwrite, strong) UIView *spaceCraftView;
/// 速度标签
@property (nonatomic, readwrite, strong) UILabel *speedLabel;
/// 时间偏移标签
@property (nonatomic, readwrite, strong) UILabel *timeOffsetLabel;
/// 速度滑块
@property (nonatomic, readwrite, strong) UISlider *speedSlider;
/// 时间偏移滑块
@property (nonatomic, readwrite, strong) UISlider *timeOffsetSlider;
/// 路径
@property (nonatomic, readwrite, strong) UIBezierPath *bezierPath;
/// 飞船
@property (nonatomic, readwrite, strong) CALayer *shipLayer;
/// 演示按钮
@property (nonatomic, readwrite, strong) UIButton *playBtn;

@end

@implementation LayerTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"图层时间";
}

#pragma mark - - 加载视图
- (void)loadSubviews {
    [super loadSubviews];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.doorView];
    [self.scrollView addSubview:self.spaceCraftView];
    [self.spaceCraftView addSubview:self.speedLabel];
    [self.spaceCraftView addSubview:self.timeOffsetLabel];
    [self.spaceCraftView addSubview:self.speedSlider];
    [self.spaceCraftView addSubview:self.timeOffsetSlider];
    [self.spaceCraftView addSubview:self.playBtn];
}

#pragma mark - - 配置属性
- (void)configSubviews {
    [super configSubviews];
    
    self.doorView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.spaceCraftView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [UIButton ym_button:self.playBtn title:@"PLAY" fontSize:15 titleColor:[UIColor magentaColor]];
    [UIButton ym_view:self.playBtn backgroundColor:[UIColor whiteColor] cornerRadius:3.0f borderWidth:0.5f borderColor:[UIColor magentaColor]];
    [self.playBtn addTarget:self action:@selector(playBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.speedSlider addTarget:self action:@selector(speedSliderAction:) forControlEvents:UIControlEventValueChanged];
    [self.timeOffsetSlider addTarget:self action:@selector(timeOffsetSliderAction:) forControlEvents:UIControlEventValueChanged];
    
    self.speedSlider.value = 0.5;
    self.timeOffsetSlider.value = 0.5;
}

#pragma mark - - 布局视图
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.scrollView.frame = CGRectMake(0, 0, MainScreenWidth, MainScreenHeight - NavBarHeight);
    self.doorView.frame = CGRectMake(15, 30, MainScreenWidth - 30, 300);
    self.spaceCraftView.frame = CGRectMake(15, self.doorView.bottom + 30, MainScreenWidth - 30, MainScreenWidth - 30);
    self.speedSlider.frame = CGRectMake(15, self.spaceCraftView.height - 100, 100, 15);
    self.speedLabel.frame = CGRectMake(self.speedSlider.right + 10, self.speedSlider.top, 150, 15);
    self.timeOffsetSlider.frame = CGRectMake(15, self.speedSlider.bottom + 30, 100, 15);
    self.timeOffsetLabel.frame = CGRectMake(self.timeOffsetSlider.right + 10, self.self.timeOffsetSlider.top, 150, 15);
    self.playBtn.frame = CGRectMake(self.spaceCraftView.width - 50, self.spaceCraftView.height - 35, 40, 20);
    
    self.scrollView.contentSize = CGSizeMake(MainScreenWidth, self.spaceCraftView.bottom + 50);
    
    // 门图层
    [self graphicsDoorLayer];
    // 飞船图层
    [self graphicsSpaceCraftLayer];
}

#pragma mark 门图层
- (void)graphicsDoorLayer {
    self.doorLayer = [CALayer layer];
    self.doorLayer.frame = CGRectMake((self.doorView.width - 100) / 2, 15, 100, 200);
    self.doorLayer.position = CGPointMake((self.doorView.width - 100) / 2, self.doorView.height / 2);
    self.doorLayer.anchorPoint = CGPointMake(0, 0.5);
    self.doorLayer.contents = (__bridge id)[UIImage imageNamed:@"LayerImage"].CGImage;
    [self.doorView.layer addSublayer:self.doorLayer];
    
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0 / 500.0;
    self.doorView.layer.sublayerTransform = perspective;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    pan.delegate = self;
    [self.doorView addGestureRecognizer:pan];
    
    self.doorView.layer.speed = 0.0;
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation.y";
    animation.byValue = @(-M_PI_2);
    animation.duration = 2.0f;
    animation.repeatDuration = INFINITY;
    animation.autoreverses = YES;
    [self.doorLayer addAnimation:animation forKey:nil];
}

#pragma mark 拖拽手势
- (void)panAction:(UIPanGestureRecognizer *)gesture {
    CGFloat x = [gesture translationInView:self.doorView].x;
    x /= 200.0f;
    CFTimeInterval timeOffset = self.doorLayer.timeOffset;
    timeOffset = MIN(0.999, timeOffset - x);
    self.doorLayer.timeOffset = timeOffset;
    
    [gesture setTranslation:CGPointZero inView:self.doorView];
}

#pragma mark 绘制飞船图层
- (void)graphicsSpaceCraftLayer {
    self.bezierPath = [UIBezierPath bezierPath];
    [self.bezierPath moveToPoint:CGPointMake(0, 150)];
    [self.bezierPath addCurveToPoint:CGPointMake(300, 150) controlPoint1:CGPointMake(100, 100) controlPoint2:CGPointMake(200, 250)];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = self.bezierPath.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.lineWidth = 3.0f;
    [self.spaceCraftView.layer addSublayer:shapeLayer];
    
    self.shipLayer = [CALayer layer];
    self.shipLayer.frame = CGRectMake(0, 0, 30, 30);
    self.shipLayer.position = CGPointMake(0, 150);
    self.shipLayer.contents = (__bridge id)[UIImage imageNamed:@"LayerImage"].CGImage;
    [self.spaceCraftView.layer addSublayer:self.shipLayer];
    
    [self speedSliderAction:self.speedSlider];
    [self timeOffsetSliderAction:self.timeOffsetSlider];
}

#pragma mark 速度滑块滑动调用
- (void)speedSliderAction:(UISlider *)slider {
    float speed = slider.value;
    self.speedLabel.text = [NSString stringWithFormat:@"speed %.02f", speed];
}

#pragma mark 时间偏移滑块滑动调用
- (void)timeOffsetSliderAction:(UISlider *)slider {
    CFTimeInterval timeOffset = slider.value;
    self.timeOffsetLabel.text = [NSString stringWithFormat:@"timeOffset %.02f", timeOffset];
}

#pragma mark 演示按钮点击调用
- (void)playBtnClick {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.timeOffset = self.timeOffsetSlider.value;
    animation.speed = self.speedSlider.value;
    animation.duration = 2.0f;
    animation.path = self.bezierPath.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    animation.removedOnCompletion = NO;
    [self.shipLayer addAnimation:animation forKey:@"slider"];
}

#pragma mark - - lazyLoadUI
- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
    }
    return _scrollView;
}

- (UIView *)doorView {
    if (_doorView == nil) {
        _doorView = [[UIView alloc] init];
    }
    return _doorView;
}

- (UIView *)spaceCraftView {
    if (_spaceCraftView == nil) {
        _spaceCraftView = [[UIView alloc] init];
    }
    return _spaceCraftView;
}

- (UISlider *)speedSlider {
    if (_speedSlider == nil) {
        _speedSlider = [[UISlider alloc] init];
    }
    return _speedSlider;
}

- (UILabel *)speedLabel {
    if (_speedLabel == nil) {
        _speedLabel = [[UILabel alloc] init];
    }
    return _speedLabel;
}

- (UISlider *)timeOffsetSlider {
    if (_timeOffsetSlider == nil) {
        _timeOffsetSlider = [[UISlider alloc] init];
    }
    return _timeOffsetSlider;
}

- (UILabel *)timeOffsetLabel {
    if (_timeOffsetLabel == nil) {
        _timeOffsetLabel = [[UILabel alloc] init];
    }
    return _timeOffsetLabel;
}

- (UIButton *)playBtn {
    if (_playBtn == nil) {
        _playBtn = [[UIButton alloc] init];
    }
    return _playBtn;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
