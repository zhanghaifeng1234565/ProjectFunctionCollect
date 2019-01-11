//
//  TimerBasedAnimationViewController.m
//  YMOCCodeStandard
//
//  Created by iOS on 2019/1/9.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "TimerBasedAnimationViewController.h"
#import "TimeWeakTarget.h"

@interface TimerBasedAnimationViewController ()
<CAAnimationDelegate>

/// 滚动视图
@property (nonatomic, readwrite, strong) UIScrollView *scrollView;

/// ball 视图
@property (nonatomic, readwrite, strong) UIView *ballView;
/// ball 图片
@property (nonatomic, readwrite, strong) UIImageView *ballImageView;
/// 球动画按钮
@property (nonatomic, readwrite, strong) UIButton *ballJumpBtn;

/// 时长
@property (nonatomic, readwrite, assign) CFTimeInterval duration;
/// 时间偏移
@property (nonatomic, readwrite, assign) CFTimeInterval timeOffset;
/// 上一步时间
@property (nonatomic, readwrite, assign) CFTimeInterval lastStep;
/// 起始值
@property (nonatomic, readwrite, strong) id fromValue;
/// 结束值
@property (nonatomic, readwrite, strong) id toValue;
/// 定时器
@property (nonatomic, readwrite, strong) CADisplayLink *timer;

@end

@implementation TimerBasedAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"基于定时器动画";
}

#pragma mark - - 加载视图
- (void)loadSubviews {
    [super loadSubviews];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.ballView];
    [self.ballView addSubview:self.ballImageView];
    [self.ballView addSubview:self.ballJumpBtn];
}

#pragma mark - - 配置属性
- (void)configSubviews {
    [super configSubviews];
    
    self.ballView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.ballImageView.backgroundColor = [UIColor magentaColor];
    
    self.ballImageView.layer.masksToBounds = YES;
    self.ballImageView.layer.cornerRadius = 25.0f;
    
    [UIButton ym_button:self.ballJumpBtn title:@"jump" fontSize:15 titleColor:[UIColor magentaColor]];
    [UIButton ym_view:self.ballJumpBtn backgroundColor:[UIColor whiteColor] cornerRadius:3.0f borderWidth:0.5f borderColor:[UIColor magentaColor]];
    [self.ballJumpBtn addTarget:self action:@selector(ballJumpBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - - 布局视图
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.scrollView.frame = CGRectMake(0, 0, MainScreenWidth, MainScreenHeight - NavBarHeight);
    self.ballView.frame = CGRectMake(15, 30 + 30, MainScreenWidth - 30, MainScreenWidth - 30);
    self.ballImageView.frame = CGRectMake((self.ballView.width - 50) / 2, (self.ballView.height - 50) / 2, 50, 50);
    self.ballJumpBtn.frame = CGRectMake(0, 0, 60, 40);
    
    self.scrollView.contentSize = CGSizeMake(MainScreenWidth, self.ballView.bottom + 50);
    
    [self insertAnimation];
}

#pragma mark jump 按钮点击调用
- (void)ballJumpBtnClick {
    [self insertAnimation];
}

#pragma mark 循环插入实现
- (void)insertAnimation {
    self.ballImageView.center = CGPointMake((self.ballView.width - 50) / 2, ((self.ballView.height - 50) / 2));
    self.duration = 1.0f;
    self.timeOffset = 0.0f;
    self.fromValue = [NSValue valueWithCGPoint:CGPointMake((self.ballView.width - 50) / 2, (self.ballView.height - 50) / 2)];
    self.toValue = [NSValue valueWithCGPoint:CGPointMake((self.ballView.width - 50) / 2, ((self.ballView.height - 50) / 2) + 150)];
    
    [self.timer invalidate];
    self.lastStep = CACurrentMediaTime();
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(stepLink:)];
    [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
//    [TimeWeakTarget scheduledTimerWithTimeInterval:1/60.0 target:self selector:@selector(step:) userInfo:@{} repeats:YES];
}

//- (void)step:(NSTimer *)step {
//    self.timeOffset = MIN(self.timeOffset + 1/60.0, self.duration);
//    float time = self.timeOffset / self.duration;
//    time = bouncesEaseOut(time);
//    id position = [self interpolateFormValue:self.fromValue toValue:self.toValue time:time];
//    self.ballImageView.center = [position CGPointValue];
//}

float interpolatee(float from, float to, float time) {
    return (to - from) * time + from;
}

- (id)interpolateFormValue:(id)fromValue toValue:(id)toValue time:(float)time {
    if ([fromValue isKindOfClass:[NSValue class]]) {
        const char *type = [fromValue objCType];
        if (strcmp(type, @encode(CGPoint)) == 0) {
            CGPoint from = [fromValue CGPointValue];
            CGPoint to = [toValue CGPointValue];
            CGPoint result = CGPointMake(interpolatee(from.x, to.x, time), interpolatee(from.y, to.y, time));
            return [NSValue valueWithCGPoint:result];
        }
    }
    return (time > 0.5) ? fromValue : toValue;
}

float quadratEaseInOut(float t) {
    return (t < 0.5) ? (2 * t * t) : (-2 * t * t) + (4 * t) - 1;
}

float bouncesEaseOut(float p) {
    if(p < 4/11.0) {
        return (121 * p * p)/16.0;
    } else if(p < 8/11.0) {
        return (363/40.0 * p * p) - (99/10.0 * p) + 17/5.0;
    } else if(p < 9/10.0) {
        return (4356/361.0 * p * p) - (35442/1805.0 * p) + 16061/1805.0;
    } else {
        return (54/5.0 * p * p) - (513/25.0 * p) + 268/25.0;
    }
}

- (void)stepLink:(CADisplayLink *)step {
    CFTimeInterval thisStep = CACurrentMediaTime();
    CFTimeInterval stepDuration = thisStep - self.lastStep;
    self.lastStep = thisStep;
    
    self.timeOffset = MIN(self.timeOffset + stepDuration, self.duration);
    float time = self.timeOffset / self.duration;
    time = bouncesEaseOut(time);
    
    id position = [self interpolateFormValue:self.fromValue toValue:self.toValue time:time];
    self.ballImageView.center = [position CGPointValue];
    if (self.timeOffset >= self.duration) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

#pragma mark - - lazyLoadUI
- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
    }
    return _scrollView;
}

- (UIView *)ballView {
    if (_ballView == nil) {
        _ballView = [[UIView alloc] init];
    }
    return _ballView;
}

- (UIImageView *)ballImageView {
    if (_ballImageView == nil) {
        _ballImageView = [[UIImageView alloc] init];
    }
    return _ballImageView;
}

- (UIButton *)ballJumpBtn {
    if (_ballJumpBtn == nil) {
        _ballJumpBtn = [[UIButton alloc] init];
    }
    return _ballJumpBtn;
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
