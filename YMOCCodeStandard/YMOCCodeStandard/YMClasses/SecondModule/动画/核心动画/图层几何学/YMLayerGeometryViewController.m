//
//  YMLayerGeometryViewController.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/12/25.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "YMLayerGeometryViewController.h"

#import "TimeWeakTarget.h"

@interface YMLayerGeometryViewController ()

/// 时钟
@property (nonatomic, readwrite, strong) UIImageView *clockImageV;
/// 时针
@property (nonatomic, readwrite, strong) UIImageView *hourHandImageV;
/// 分针
@property (nonatomic, readwrite, strong) UIImageView *minuteHandImageV;
/// 秒针
@property (nonatomic, readwrite, strong) UIImageView *secondHandImageV;

/// 绿色视图
@property (nonatomic, readwrite, strong) UIView *greenView;
/// 红色视图
@property (nonatomic, readwrite, strong) UIView *redView;
/// 蓝色图层
@property (nonatomic, readwrite, strong) CALayer *blueLayer;

@end

@implementation YMLayerGeometryViewController {
    /// 是否是 hitTest
    BOOL _isHitTest;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"图层几何学";
}

#pragma mark - - 添加视图
- (void)loadSubviews {
    [super loadSubviews];
    
    [self.view addSubview:self.clockImageV];
    [self.view addSubview:self.hourHandImageV];
    [self.view addSubview:self.minuteHandImageV];
    [self.view addSubview:self.secondHandImageV];
    
    [self.view addSubview:self.greenView];
    [self.view addSubview:self.redView];
    
    [self.greenView.layer addSublayer:self.blueLayer];
}

#pragma mark - - 配置视图
- (void)configSubviews {
    [super configSubviews];
    
    self.clockImageV.image = [UIImage imageNamed:@"clock"];
    self.hourHandImageV.image = [UIImage imageNamed:@"hourhand"];
    self.minuteHandImageV.image = [UIImage imageNamed:@"minutehand"];
    self.secondHandImageV.image = [UIImage imageNamed:@"secondhand"];
    
    self.greenView.backgroundColor = [UIColor greenColor];
    self.redView.backgroundColor = [UIColor redColor];
    
    self.blueLayer.backgroundColor = [UIColor blueColor].CGColor;
}

#pragma mark - - 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 设置位置
    self.clockImageV.frame = CGRectMake((MainScreenWidth - 181.5) / 2, 50, 181.5, 181.5);
    self.hourHandImageV.frame = CGRectMake((MainScreenWidth - 25) / 2, 50 + (self.clockImageV.height - 80) / 2, 25, 80);
    self.minuteHandImageV.frame = CGRectMake((MainScreenWidth - 17) / 2, 50 + (self.clockImageV.height - 90) / 2, 17, 90);
    self.secondHandImageV.frame = CGRectMake((MainScreenWidth - 7) / 2, 50 + (self.clockImageV.height - 84) / 2, 7, 84);
    
    // 调整位置
    self.hourHandImageV.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
    self.minuteHandImageV.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
    self.secondHandImageV.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
    
    // 添加定时任务
    [TimeWeakTarget scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:@{} repeats:YES];
    [self tick];
    
    // 视图层次修改
    self.greenView.frame = CGRectMake(15, self.clockImageV.bottom + 30, MainScreenWidth - 30, 50);
    self.redView.frame = CGRectMake(15, self.greenView.bottom - 15, MainScreenWidth - 30, 50);
    self.greenView.layer.zPosition = 1.0;
    
    self.blueLayer.frame = CGRectMake(15, 10, self.greenView.width - 30, 30);
}

#pragma mark - - 定时任务
- (void)tick{
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
    self.hourHandImageV.transform = CGAffineTransformMakeRotation(hoursAngle);
    self.minuteHandImageV.transform = CGAffineTransformMakeRotation(minsAngle);
    self.secondHandImageV.transform = CGAffineTransformMakeRotation(secsAngle);
}

#pragma mark - - touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (_isHitTest == YES) {
        // 通过 hitTest: 获取
        [self obtainThroughHitTest:touches];
    } else {
        // 通过 containsPoint 获取
        [self obtainThroughContainsPoint:touches];
    }
}

#pragma mark 通过 containsPoint 获取图层
- (void)obtainThroughContainsPoint:(NSSet<UITouch *> *)touches {
    // get touch position relative to main view
    CGPoint point = [[touches anyObject] locationInView:self.view];
    // convert point to the white layer's coordinates
    point = [self.greenView.layer convertPoint:point fromLayer:self.view.layer];
    // get layer using containsPoint:
    if ([self.greenView.layer containsPoint:point]) {
        // convert point to blueLayer's coordinates
        point = [self.blueLayer convertPoint:point fromLayer:self.greenView.layer];
        if ([self.blueLayer containsPoint:point]) {
            [YMBlackSmallAlert showAlertWithMessage:@"在蓝色图层里" time:2.0f];
        } else {
            [YMBlackSmallAlert showAlertWithMessage:@"在绿色图层里" time:2.0f];
        }
    } else {
        [YMBlackSmallAlert showAlertWithMessage:@"在白色图层里" time:2.0f];
    }
}

#pragma mark 通过 hitTest:
- (void)obtainThroughHitTest:(NSSet<UITouch *> *)touches {
    // get touch position
    CGPoint point = [[touches anyObject] locationInView:self.view];
    // get touched layer
    CALayer *layer = [self.greenView.layer hitTest:point];
    // get layer using hitTest:
    if (layer == self.blueLayer) {
        [YMBlackSmallAlert showAlertWithMessage:@"在蓝色图层里" time:2.0f];
    } else if (layer == self.greenView.layer) {
        [YMBlackSmallAlert showAlertWithMessage:@"在绿色图层里" time:2.0f];
    } else {
        [YMBlackSmallAlert showAlertWithMessage:@"在白色图层里" time:2.0f];
    }
}

#pragma mark - - lazyLoadUI
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

- (UIView *)greenView {
    if (_greenView == nil) {
        _greenView = [[UIView alloc] init];
    }
    return _greenView;
}

- (UIView *)redView {
    if (_redView == nil) {
        _redView = [[UIView alloc] init];
    }
    return _redView;
}

- (CALayer *)blueLayer {
    if (_blueLayer == nil) {
        _blueLayer = [[CALayer alloc] init];
    }
    return _blueLayer;
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
