//
//  LayerTimeViewController.m
//  YMOCCodeStandard
//
//  Created by iOS on 2019/1/8.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "LayerTimeViewController.h"

@interface LayerTimeViewController ()

/// 滚动视图
@property (nonatomic, readwrite, strong) UIScrollView *scrollView;
/// 门视图
@property (nonatomic, readwrite, strong) UIView *doorView;
/// 门图层
@property (nonatomic, readwrite, strong) CALayer *doorLayer;

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
}

#pragma mark - - 配置属性
- (void)configSubviews {
    [super configSubviews];
    
    self.doorView.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

#pragma mark - - 布局视图
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.scrollView.frame = CGRectMake(0, 0, MainScreenWidth, MainScreenHeight - NavBarHeight);
    self.doorView.frame = CGRectMake(15, 30, MainScreenWidth - 30, 300);
    
    self.scrollView.contentSize = CGSizeMake(MainScreenWidth, self.doorView.bottom + 50);
    
    // 门图层
    [self graphicsDoorLayer];
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
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation.y";
    animation.byValue = @(-M_PI_2);
    animation.duration = 2.0f;
    animation.repeatDuration = INFINITY;
    animation.autoreverses = YES;
    [self.doorLayer addAnimation:animation forKey:nil];
}

#pragma mark 开门按钮点击调用
- (void)openDoorBtnClick {
    [CATransaction begin];
    [CATransaction setAnimationDuration:1.0];
    
    //    [CATransaction setCompletionBlock:^{
    //        CGAffineTransform transform = self.colorLayer.affineTransform;
    //        transform = CGAffineTransformRotate(transform, M_PI_2);
    //        self.colorLayer.affineTransform = transform;
    //    }];
    
    CGAffineTransform transform = self.doorLayer.affineTransform;
    transform = CGAffineTransformRotate(transform, M_PI_2);
    self.doorLayer.affineTransform = transform;
    
    self.doorLayer.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0].CGColor;
    
    NSLog(@"%@", [self.doorLayer animationKeys]);
    
    [CATransaction commit];
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
