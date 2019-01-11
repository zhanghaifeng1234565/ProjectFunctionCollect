//
//  BufferViewController.m
//  YMOCCodeStandard
//
//  Created by iOS on 2019/1/8.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "BufferViewController.h"

@interface BufferViewController ()
<CAAnimationDelegate>

/// 滚动视图
@property (nonatomic, readwrite, strong) UIScrollView *scrollView;
/// 颜色视图
@property (nonatomic, readwrite, strong) UIView *colorView;
/// 颜色图层
@property (nonatomic, readwrite, strong) CALayer *colorLayer;

/// ball 视图
@property (nonatomic, readwrite, strong) UIView *ballView;
/// ball 图片
@property (nonatomic, readwrite, strong) UIImageView *ballImageView;
/// 球动画按钮
@property (nonatomic, readwrite, strong) UIButton *ballJumpBtn;


@end

@implementation BufferViewController {
    /// 1 的时候是 图层 2 的时候是视图 3 关键帧
    int _flag;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"缓冲";
    _flag = 3;
}

#pragma mark - - 加载视图
- (void)loadSubviews {
    [super loadSubviews];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.colorView];
    [self.scrollView.layer addSublayer:self.colorLayer];
    [self.scrollView addSubview:self.ballView];
    [self.ballView addSubview:self.ballImageView];
    [self.ballView addSubview:self.ballJumpBtn];
}

#pragma mark - - 配置属性
- (void)configSubviews {
    [super configSubviews];
    
    self.colorView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.colorLayer.backgroundColor = [UIColor groupTableViewBackgroundColor].CGColor;
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
    self.colorView.frame = CGRectMake((MainScreenWidth - 100) / 2, 30, 100, 150);
    self.colorLayer.frame = CGRectMake((MainScreenWidth - 100) / 2, self.colorView.bottom + 30, 100, 150);
    self.ballView.frame = CGRectMake(15, self.colorView.bottom + 30 + 150 + 30 + 30, MainScreenWidth - 30, MainScreenWidth - 30);
    self.ballImageView.frame = CGRectMake((self.ballView.width - 50) / 2, (self.ballView.height - 50) / 2, 50, 50);
    self.ballJumpBtn.frame = CGRectMake(0, 0, 60, 40);
    
    self.scrollView.contentSize = CGSizeMake(MainScreenWidth, self.ballView.bottom + 50);
}

#pragma mark - - touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    switch (_flag) {
        case 1:
        {
            [CATransaction begin];
            [CATransaction setAnimationDuration:1.0];
            [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            self.colorLayer.position = [[touches anyObject] locationInView:self.scrollView];
            [CATransaction commit];
        }
            break;
        case 2:
        {
            [UIView animateWithDuration:1.0f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.colorView.center = [[touches anyObject] locationInView:self.scrollView];
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
        case 3:
        {
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
            animation.keyPath = @"backgroundColor";
            animation.duration = 2.0f;
            animation.values = @[(__bridge id)[UIColor blueColor].CGColor,
                                 (__bridge id)[UIColor redColor].CGColor,
                                 (__bridge id)[UIColor greenColor].CGColor,
                                 (__bridge id)[UIColor blueColor].CGColor];
            CAMediaTimingFunction *fn = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            animation.timingFunctions = @[fn, fn, fn];
            [self.colorLayer addAnimation:animation forKey:nil];
        }
            break;
        default:
            [YMBlackSmallAlert showAlertWithMessage:@"未知错误！" time:2.0f];
            break;
    }
}

#pragma mark 小球跳动按钮点击调用
- (void)ballJumpBtnClick {
    // 正常 一帧一帧实现
//    [self normalAnimation];
    // 插入 实现
    [self insertAnimation];
}

#pragma mark 一帧一帧的实现
- (void)normalAnimation {
    self.ballImageView.center = CGPointMake((self.ballView.width - 50) / 2, ((self.ballView.height - 50) / 2));
    
    CAKeyframeAnimation *animaiton = [CAKeyframeAnimation animation];
    animaiton.keyPath = @"position";
    animaiton.duration = 1.0f;
    animaiton.delegate = self;
    animaiton.values = @[[NSValue valueWithCGPoint:CGPointMake((self.ballView.width - 50) / 2, ((self.ballView.height - 50) / 2) + 5)],
                         [NSValue valueWithCGPoint:CGPointMake((self.ballView.width - 50) / 2, ((self.ballView.height - 50) / 2) + 10)],
                         [NSValue valueWithCGPoint:CGPointMake((self.ballView.width - 50) / 2, ((self.ballView.height - 50) / 2) + 15)],
                         [NSValue valueWithCGPoint:CGPointMake((self.ballView.width - 50) / 2, ((self.ballView.height - 50) / 2) + 20)],
                         [NSValue valueWithCGPoint:CGPointMake((self.ballView.width - 50) / 2, ((self.ballView.height - 50) / 2) + 25)],
                         [NSValue valueWithCGPoint:CGPointMake((self.ballView.width - 50) / 2, ((self.ballView.height - 50) / 2) + 30)],
                         [NSValue valueWithCGPoint:CGPointMake((self.ballView.width - 50) / 2, ((self.ballView.height - 50) / 2) + 35)],
                         [NSValue valueWithCGPoint:CGPointMake((self.ballView.width - 50) / 2, ((self.ballView.height - 50) / 2) + 40)]];
    animaiton.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    animaiton.keyTimes = @[@0.0, @0.3, @0.5, @0.7, @0.8, @0.9, @0.9];
    self.ballImageView.layer.position = CGPointMake((self.ballView.width - 50) / 2, (self.ballView.height - 50) / 2);
    [self.ballImageView.layer addAnimation:animaiton forKey:nil];
}

#pragma mark 循环插入实现
- (void)insertAnimation {
    self.ballImageView.center = CGPointMake((self.ballView.width - 50) / 2, ((self.ballView.height - 50) / 2));
    
    NSValue *fromValue = [NSValue valueWithCGPoint:CGPointMake((self.ballView.width - 50) / 2, (self.ballView.height - 50) / 2)];
    NSValue *toValue = [NSValue valueWithCGPoint:CGPointMake((self.ballView.width - 50) / 2, ((self.ballView.height - 50) / 2) + 150)];
    CFTimeInterval duration = 1.0;
    NSInteger numFrames = duration * 60;
    NSMutableArray *frames = [NSMutableArray array];
    for (int i = 0; i < numFrames; i++) {
        float time = 1 / (float)numFrames * i;
        time = bounceEaseOut(time);
        [frames addObject:[self interpolateFormValue:fromValue toValue:toValue time:time]];
    }
    
    CAKeyframeAnimation *animaiton = [CAKeyframeAnimation animation];
    animaiton.keyPath = @"position";
    animaiton.duration = 1.0f;
    animaiton.delegate = self;
    animaiton.values = frames;
    [self.ballImageView.layer addAnimation:animaiton forKey:nil];
}

float interpolateee(float from, float to, float time) {
    return (to - from) * time + from;
}

- (id)interpolateFormValue:(id)fromValue toValue:(id)toValue time:(float)time {
    if ([fromValue isKindOfClass:[NSValue class]]) {
        const char *type = [fromValue objCType];
        if (strcmp(type, @encode(CGPoint)) == 0) {
            CGPoint from = [fromValue CGPointValue];
            CGPoint to = [toValue CGPointValue];
            CGPoint result = CGPointMake(interpolateee(from.x, to.x, time), interpolateee(from.y, to.y, time));
            return [NSValue valueWithCGPoint:result];
        }
    }
    return (time > 0.5) ? fromValue : toValue;
}

float quadraticEaseInOut(float t) {
    return (t < 0.5) ? (2 * t * t) : (-2 * t * t) + (4 * t) - 1;
}

float bounceEaseOut(float p) {
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

- (CALayer *)colorLayer {
    if (_colorLayer == nil) {
        _colorLayer = [CALayer layer];
    }
    return _colorLayer;
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
