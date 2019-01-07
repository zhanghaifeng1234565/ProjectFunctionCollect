//
//  ExplicitAnimationViewController.m
//  YMOCCodeStandard
//
//  Created by iOS on 2019/1/4.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "ExplicitAnimationViewController.h"
#import "TimeWeakTarget.h"

@interface ExplicitAnimationViewController ()
<CAAnimationDelegate>

/// 滚动视图
@property (nonatomic, readwrite, strong) UIScrollView *scrollView;
/// 颜色视图
@property (nonatomic, readwrite, strong) UIView *colorView;
/// 颜色图层
@property (nonatomic, readwrite, strong) CALayer *colorLayer;
/// 改变颜色按钮
@property (nonatomic, readwrite, strong) UIButton *changeColorBtn;

/// 钟表视图
@property (nonatomic, readwrite, strong) UIView *clockView;
/// 时钟
@property (nonatomic, readwrite, strong) UIImageView *clockImageV;
/// 时针
@property (nonatomic, readwrite, strong) UIImageView *hourHandImageV;
/// 分针
@property (nonatomic, readwrite, strong) UIImageView *minuteHandImageV;
/// 秒针
@property (nonatomic, readwrite, strong) UIImageView *secondHandImageV;

/// 宇宙飞船视图
@property (nonatomic, readwrite, strong) UIView *spacecraftView;

/// 过渡动画
@property (nonatomic, readwrite, strong) UIImageView *transitionImageView;
/// 图片数组
@property (nonatomic, readwrite, strong) NSArray *imagesArr;
/// 变换图片按钮
@property (nonatomic, readwrite, strong) UIButton *changeImageBtn;

@end

@implementation ExplicitAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"显式动画";
}

#pragma mark - - 加载视图
- (void)loadSubviews {
    [super loadSubviews];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.colorView];
    [self.colorView addSubview:self.changeColorBtn];
    [self.scrollView addSubview:self.clockView];
    [self.clockView addSubview:self.clockImageV];
    [self.clockView addSubview:self.hourHandImageV];
    [self.clockView addSubview:self.minuteHandImageV];
    [self.clockView addSubview:self.secondHandImageV];
    [self.scrollView addSubview:self.spacecraftView];
    [self.scrollView addSubview:self.transitionImageView];
    [self.transitionImageView addSubview:self.changeImageBtn];
}

#pragma mark - - 配置属性
- (void)configSubviews {
    [super configSubviews];
    
    self.colorView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.clockView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.spacecraftView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.transitionImageView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.clockImageV.image = [UIImage imageNamed:@"clock"];
    self.hourHandImageV.image = [UIImage imageNamed:@"hourhand"];
    self.minuteHandImageV.image = [UIImage imageNamed:@"minutehand"];
    self.secondHandImageV.image = [UIImage imageNamed:@"secondhand"];
    self.transitionImageView.image = [UIImage imageNamed:@"clock"];
    
    [UIButton ym_button:self.changeColorBtn title:@"改变颜色" fontSize:17 titleColor:[UIColor magentaColor]];
    [UIButton ym_view:self.changeColorBtn backgroundColor:[UIColor whiteColor] cornerRadius:6.0f borderWidth:1.0f borderColor:[UIColor magentaColor]];
    self.changeColorBtn.tag = 100;
    
    [self.changeColorBtn addTarget:self action:@selector(changeColorBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.imagesArr = [[NSArray alloc] initWithObjects:
                      [UIImage imageNamed:@"clock"],
                      [UIImage imageNamed:@"hourhand"],
                      [UIImage imageNamed:@"minutehand"],
                      [UIImage imageNamed:@"secondhand"], nil];
   
    self.transitionImageView.userInteractionEnabled = YES;
    [UIButton ym_button:self.changeImageBtn title:@"改变图片" fontSize:17 titleColor:[UIColor magentaColor]];
    [UIButton ym_view:self.changeImageBtn backgroundColor:[UIColor whiteColor] cornerRadius:6.0f borderWidth:1.0f borderColor:[UIColor magentaColor]];
    [self.changeImageBtn addTarget:self action:@selector(changeImageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - - 布局视图
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.scrollView.frame = CGRectMake(0, 0, MainScreenWidth, MainScreenHeight - NavBarHeight);
    self.colorView.frame = CGRectMake((MainScreenWidth - 100) / 2, 30, 100, 150);
    self.changeColorBtn.frame = CGRectMake(15, self.colorView.height - 40, self.colorView.width - 30, 30);
    self.clockView.frame = CGRectMake(15, self.colorView.bottom + 30, MainScreenWidth - 30, 281.5);
    self.spacecraftView.frame = CGRectMake(15, self.clockView.bottom + 30, MainScreenWidth - 30, MainScreenWidth - 30);
    self.transitionImageView.frame = CGRectMake(15, self.spacecraftView.bottom + 30, MainScreenWidth - 30, MainScreenWidth - 30);
    self.changeImageBtn.frame = CGRectMake(0, 0, 100, 50);
    
    self.scrollView.contentSize = CGSizeMake(MainScreenWidth, self.transitionImageView.bottom + 50);
    
    // 设置位置
    self.clockImageV.frame = CGRectMake((self.clockView.width - 181.5) / 2, 50, 181.5, 181.5);
    self.hourHandImageV.frame = CGRectMake((self.clockView.width - 25) / 2, 50 + (self.clockImageV.height - 80) / 2, 25, 80);
    self.minuteHandImageV.frame = CGRectMake((self.clockView.width - 17) / 2, 50 + (self.clockImageV.height - 90) / 2, 17, 90);
    self.secondHandImageV.frame = CGRectMake((self.clockView.width - 7) / 2, 50 + (self.clockImageV.height - 84) / 2, 7, 84);
    
    // 调整位置
    self.hourHandImageV.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
    self.minuteHandImageV.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
    self.secondHandImageV.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
    
    // 颜色图层
    [self graphicsColorLayer];
    // 钟表
    [self graphicsClockLayer];
    // 绘制太空飞船
    [self graphicsSpacecraftLayer];
    // 绘制组动画
    [self graphicsGroupAnimation];
}

#pragma mark 颜色图层
- (void)graphicsColorLayer {
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(15, 15, self.colorView.width - 30, self.colorView.width - 30);
    [self.colorView.layer addSublayer:self.colorLayer];
    self.colorLayer.backgroundColor = [UIColor redColor].CGColor;
}

#pragma mark 改变颜色按钮点击调用
- (void)changeColorBtnClick:(UIButton *)sender {
    switch (sender.tag) {
        case 100:
        {
            // 基础动画
            CABasicAnimation *animation = [CABasicAnimation animation];
            animation.keyPath = @"backgroundColor";
            animation.toValue = (__bridge id)[UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0].CGColor;
            animation.delegate = self;
            [self.colorLayer addAnimation:animation forKey:nil];
            
            [sender setTitle:@"关键帧" forState:UIControlStateNormal];
            sender.tag = 101;
        }
            break;
        case 101:
        {
            // 关键帧动画
            CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animation];
            keyframeAnimation.keyPath = @"backgroundColor";
            keyframeAnimation.duration = 2.0f;
            keyframeAnimation.values = @[(__bridge id)[UIColor blueColor].CGColor,
                                         (__bridge id)[UIColor redColor].CGColor,
                                         (__bridge id)[UIColor greenColor].CGColor,
                                         (__bridge id)[UIColor blueColor].CGColor];
            [self.colorLayer addAnimation:keyframeAnimation forKey:nil];
            
            [sender setTitle:@"改变颜色" forState:UIControlStateNormal];
            sender.tag = 100;
        }
            break;
        default:
            [YMBlackSmallAlert showAlertWithMessage:@"未知错误！" time:0.5f];
            break;
    }
}

#pragma mark 时钟动画
- (void)graphicsClockLayer {
    // 调整位置
    self.hourHandImageV.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
    self.minuteHandImageV.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
    self.secondHandImageV.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
    
    // 添加定时任务
    [TimeWeakTarget scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateHandAnimated:) userInfo:@{} repeats:YES];
    [self updateHandAnimated:YES];
}

- (void)updateHandAnimated:(BOOL)animated {
    // NSCalendarIdentifierGregorian : 指定日历的算法
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // NSDateComponents封装了日期的组件,年月日时分秒等(个人感觉像是平时用的model模型)
    // 调用NSCalendar的components:fromDate:方法返回一个NSDateComponents对象
    // 需要的参数分别components:所需要的日期单位 date:目标月份的date对象
    // NSUInteger units = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;//所需要日期单位
    NSDateComponents *components = [calendar components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:[NSDate date]];
    //时钟偏转角度
    CGFloat hoursAngle = (components.hour / 12.0) * M_PI * 2.0;
    //分钟偏转角度
    CGFloat minsAngle = (components.minute / 60.0) * M_PI * 2.0;
    //秒钟旋转角度
    CGFloat secsAngle = (components.second / 60.0) * M_PI * 2.0;
    
    [self setAngle:hoursAngle forHand:self.hourHandImageV animated:animated];
    [self setAngle:minsAngle forHand:self.minuteHandImageV animated:animated];
    [self setAngle:secsAngle forHand:self.secondHandImageV animated:animated];
}

- (void)setAngle:(CGFloat)angle forHand:(UIView *)handView animated:(BOOL)animated {
    CATransform3D transform = CATransform3DMakeRotation(angle, 0, 0, 1);
    if (animated) {
        CABasicAnimation *animation = [CABasicAnimation animation];
        [self updateHandAnimated:NO];
        animation.keyPath = @"transform";
        animation.toValue = [NSValue valueWithCATransform3D:transform];
        animation.duration = 0.5;
        animation.delegate = self;
        animation.fillMode = kCAFillModeForwards;
        [animation setValue:handView forKey:@"handView"];
        [handView.layer addAnimation:animation forKey:nil];
    } else {
        handView.layer.transform = transform;
    }
}

#pragma mark 绘制太空飞船飞行
- (void)graphicsSpacecraftLayer {
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(0, 150)];
    [bezierPath addCurveToPoint:CGPointMake(300, 150) controlPoint1:CGPointMake(100, 50) controlPoint2:CGPointMake(200, 200)];
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = bezierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0f;
    [self.spacecraftView.layer addSublayer:pathLayer];
    
    CALayer *shipLayer = [CALayer layer];
    shipLayer.frame = CGRectMake(0, 0, 30, 30);
    shipLayer.position = CGPointMake(0, 150);
    shipLayer.contents = (__bridge id)[UIImage imageNamed:@"LayerImage"].CGImage;
    [self.spacecraftView.layer addSublayer:shipLayer];
    
//    CABasicAnimation *basicAnimation = [CABasicAnimation animation];
//    basicAnimation.keyPath = @"transform";
//    basicAnimation.duration = 2.0f;
//    basicAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 0, 1)];
//    [shipLayer addAnimation:basicAnimation forKey:nil];
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animation];
    basicAnimation.keyPath = @"transform.rotation";
    basicAnimation.duration = 2.0f;
    basicAnimation.repeatCount = MAXFLOAT;
    basicAnimation.byValue = @(M_PI * 2);
    [shipLayer addAnimation:basicAnimation forKey:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
        animation.keyPath = @"position";
        animation.duration = 4.0f;
        animation.path = pathLayer.path;
        animation.rotationMode = kCAAnimationRotateAuto;
        [shipLayer addAnimation:animation forKey:nil];
    });
}

#pragma mark 绘制组动画
- (void)graphicsGroupAnimation {
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(0, 300)];
    [bezierPath addCurveToPoint:CGPointMake(300, 300) controlPoint1:CGPointMake(100, 250) controlPoint2:CGPointMake(200, 350)];
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = bezierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0f;
    [self.spacecraftView.layer addSublayer:pathLayer];
    
    CALayer *shipLayer = [CALayer layer];
    shipLayer.frame = CGRectMake(0, 0, 30, 30);
    shipLayer.position = CGPointMake(0, 300);
    shipLayer.backgroundColor = [UIColor greenColor].CGColor;
    [self.spacecraftView.layer addSublayer:shipLayer];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.path = pathLayer.path;
    animation.rotationMode = kCAAnimationRotateAuto;

    CABasicAnimation *basicAnimation = [CABasicAnimation animation];
    basicAnimation.keyPath = @"transform.rotation";
    basicAnimation.repeatCount = MAXFLOAT;
    basicAnimation.byValue = @(M_PI * 2);
    
    CABasicAnimation *basicAnimation1 = [CABasicAnimation animation];
    basicAnimation1.keyPath = @"backgroundColor";
    basicAnimation1.toValue = (__bridge id)[UIColor redColor].CGColor;
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[animation, basicAnimation, basicAnimation1];
    groupAnimation.duration = 4.0f;
    [shipLayer addAnimation:groupAnimation forKey:nil];
}

#pragma mark CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    CABasicAnimation *basicAnim = (CABasicAnimation *)anim;
    
    if ([basicAnim.keyPath isEqualToString:@"backgroundColor"]) {
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        self.colorLayer.backgroundColor = (__bridge CGColorRef)basicAnim.toValue;
        [CATransaction commit];
    } else {
        UIView *handView = [anim valueForKey:@"handView"];
        handView.layer.transform = [basicAnim.toValue CATransform3DValue];
    }
}

#pragma mark 改变图片按钮点击调用
- (void)changeImageBtnClick:(UIButton *)sender {
    CATransition *transition = [[CATransition alloc] init];
    transition.type = kCATransitionFade;
    [self.transitionImageView.layer addAnimation:transition forKey:nil];
    
    UIImage *currentImage = self.transitionImageView.image;
    NSUInteger index = [self.imagesArr indexOfObject:currentImage];
    index = (index + 1) % [self.imagesArr count];
    self.transitionImageView.image = self.imagesArr[index];
}

#pragma mark - - lazyLoadUI
- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
    }
    return _scrollView;
}

- (UIView *)colorView {
    if (_colorView == nil) {
        _colorView = [[UIView alloc] init];
    }
    return _colorView;
}

- (UIButton *)changeColorBtn {
    if (_changeColorBtn == nil) {
        _changeColorBtn = [[UIButton alloc] init];
    }
    return _changeColorBtn;
}

- (UIView *)clockView {
    if (_clockView == nil) {
        _clockView = [[UIView alloc] init];
    }
    return _clockView;
}

- (UIImageView *)clockImageV {
    if (_clockImageV == nil) {
        _clockImageV = [[UIImageView alloc] init];
    }
    return _clockImageV;
}

- (UIImageView *)hourHandImageV {
    if (_hourHandImageV == nil) {
        _hourHandImageV = [[UIImageView alloc] init];
    }
    return _hourHandImageV;
}

- (UIImageView *)minuteHandImageV {
    if (_minuteHandImageV == nil) {
        _minuteHandImageV = [[UIImageView alloc] init];
    }
    return _minuteHandImageV;
}

- (UIImageView *)secondHandImageV {
    if (_secondHandImageV == nil) {
        _secondHandImageV = [[UIImageView alloc] init];
    }
    return _secondHandImageV;
}

- (UIView *)spacecraftView {
    if (_spacecraftView == nil) {
        _spacecraftView = [[UIView alloc] init];
    }
    return _spacecraftView;
}

- (UIImageView *)transitionImageView {
    if (_transitionImageView == nil) {
        _transitionImageView = [[UIImageView alloc] init];
    }
    return _transitionImageView;
}

- (UIButton *)changeImageBtn {
    if (_changeImageBtn == nil) {
        _changeImageBtn = [[UIButton alloc] init];
    }
    return _changeImageBtn;
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
