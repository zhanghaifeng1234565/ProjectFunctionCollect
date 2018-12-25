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

@end

@implementation YMLayerGeometryViewController

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
}

#pragma mark - - 配置视图
- (void)configSubviews {
    [super configSubviews];
    
    self.clockImageV.image = [UIImage imageNamed:@"clock"];
    self.hourHandImageV.image = [UIImage imageNamed:@"hourhand"];
    self.minuteHandImageV.image = [UIImage imageNamed:@"minutehand"];
    self.secondHandImageV.image = [UIImage imageNamed:@"secondhand"];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
