//
//  VisualEffectsViewController.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/12/25.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "VisualEffectsViewController.h"

@interface VisualEffectsViewController ()

/// 蓝色视图
@property (nonatomic, readwrite, strong) UIView *blueView;
/// 红色视图
@property (nonatomic, readwrite, strong) UIView *redView;
/// 阴影视图
@property (nonatomic, readwrite, strong) UIView *shadowView;

/// 蒙板
@property (nonatomic, readwrite, strong) CALayer *maskLayer;

/// 容器视图
@property (nonatomic, readwrite, strong) UIView *containView;
/// 显示文字
@property (nonatomic, readwrite, strong) UILabel *showLabel;

@end

@implementation VisualEffectsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"视觉效果";
}

#pragma mark - - 添加视图
- (void)loadSubviews {
    [super loadSubviews];
    
    [self.view addSubview:self.shadowView];
    [self.shadowView addSubview:self.redView];
    [self.redView addSubview:self.blueView];
    [self.view addSubview:self.containView];
    [self.containView addSubview:self.showLabel];
}

#pragma mark - - 配置视图
- (void)configSubviews {
    [super configSubviews];
    
    self.shadowView.backgroundColor = [UIColor whiteColor];
    self.blueView.backgroundColor = [UIColor blueColor];
    self.redView.backgroundColor = [UIColor redColor];
    self.containView.backgroundColor = [UIColor blackColor];
    
    self.showLabel.text = @"我是透明视图的子视图";
    self.showLabel.textAlignment = NSTextAlignmentCenter;
    self.showLabel.textColor = [UIColor whiteColor];
    self.showLabel.backgroundColor = [UIColor clearColor];
    
    // 设置视图透明度不影响子视图显示
    self.containView.alpha = 0.5f;
    self.containView.layer.shouldRasterize = YES;
    self.containView.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

#pragma mark - - 布局视图
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.shadowView.frame = CGRectMake(55, 55, 110, 110);
    self.blueView.frame = CGRectMake(-50, -50, 100, 100);
    self.redView.frame = CGRectMake(-5, -5, 110, 110);
    self.containView.frame = CGRectMake(15, self.shadowView.center.y - 30, MainScreenWidth - 30, 60);
    self.showLabel.frame = CGRectMake(30, 15, self.containView.width - 30, 30);
    
    self.shadowView.layer.shadowOpacity = 0.5;
    self.shadowView.layer.shadowOffset = CGSizeMake(0, 3);
    self.shadowView.layer.shadowRadius = 5;
    
    CGMutablePathRef circlePath = CGPathCreateMutable();
    CGPathAddRect(circlePath, NULL, self.shadowView.bounds);
    self.shadowView.layer.shadowPath = circlePath;
    CGPathRelease(circlePath);
    
    self.redView.layer.shadowOpacity = 0.5;
    self.redView.layer.shadowOffset = CGSizeMake(0, 3);
    self.redView.layer.shadowRadius = 5;
    
    self.blueView.clipsToBounds = YES;
    self.blueView.layer.cornerRadius = 15.0f;
    
    self.redView.layer.masksToBounds = YES;
    self.redView.layer.cornerRadius = 15.0f;
    
    self.redView.layer.borderWidth = 3.0f;
    self.redView.layer.borderColor = [UIColor magentaColor].CGColor;
    
    // 蒙板
    UIImage *maskImage = [UIImage imageNamed:@"secondhand"];
    self.maskLayer.contents = (__bridge id)maskImage.CGImage;
    self.maskLayer.frame = self.redView.bounds;
    self.redView.layer.mask = self.maskLayer;
}

#pragma mark - - lazyLoadUI
- (UIView *)blueView {
    if (_blueView == nil) {
        _blueView = [[UIView alloc] init];
    }
    return _blueView;
}

- (UIView *)redView {
    if (_redView == nil) {
        _redView = [[UIView alloc] init];
    }
    return _redView;
}

- (UIView *)shadowView {
    if (_shadowView == nil) {
        _shadowView = [[UIView alloc] init];
    }
    return _shadowView;
}

- (CALayer *)maskLayer {
    if (_maskLayer == nil) {
        _maskLayer = [[CALayer alloc] init];
    }
    return _maskLayer;
}

- (UIView *)containView {
    if (_containView == nil) {
        _containView = [[UIView alloc] init];
    }
    return _containView;
}

- (UILabel *)showLabel {
    if (_showLabel == nil) {
        _showLabel = [[UILabel alloc] init];
    }
    return _showLabel;
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
