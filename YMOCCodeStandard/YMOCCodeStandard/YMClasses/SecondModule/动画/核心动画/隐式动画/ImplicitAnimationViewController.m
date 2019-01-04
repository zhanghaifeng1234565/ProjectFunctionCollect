//
//  ImplicitAnimationViewController.m
//  YMOCCodeStandard
//
//  Created by iOS on 2019/1/4.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "ImplicitAnimationViewController.h"

@interface ImplicitAnimationViewController ()

/// 滚动视图
@property (nonatomic, readwrite, strong) UIScrollView *scrollView;
/// 颜色视图
@property (nonatomic, readwrite, strong) UIView *colorView;
/// 颜色图层
@property (nonatomic, readwrite, strong) CALayer *colorLayer;
/// 改变颜色按钮
@property (nonatomic, readwrite, strong) UIButton *changeColorBtn;

/// 自定义动画颜色视图
@property (nonatomic, readwrite, strong) UIView *diyColorView;
/// 自定义动画颜色图层
@property (nonatomic, readwrite, strong) CALayer *diyColorLayer;
/// 自定义动画颜色按钮
@property (nonatomic, readwrite, strong) UIButton *diyChangeColorBtn;

/// 测试图层移动
@property (nonatomic, readwrite, strong) CALayer *testLayer;

@end

@implementation ImplicitAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"隐式动画";
}

#pragma mark - - 加载视图
- (void)loadSubviews {
    [super loadSubviews];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.colorView];
    [self.colorView addSubview:self.changeColorBtn];
    [self.scrollView addSubview:self.diyColorView];
    [self.diyColorView addSubview:self.diyChangeColorBtn];
}

#pragma mark - - 配置属性
- (void)configSubviews {
    [super configSubviews];
    
    self.colorView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.diyColorView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [UIButton ym_button:self.changeColorBtn title:@"改变颜色" fontSize:17 titleColor:[UIColor magentaColor]];
    [UIButton ym_view:self.changeColorBtn backgroundColor:[UIColor whiteColor] cornerRadius:6.0f borderWidth:1.0f borderColor:[UIColor magentaColor]];
    
    [self.changeColorBtn addTarget:self action:@selector(changeColorBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [UIButton ym_button:self.diyChangeColorBtn title:@"改变颜色" fontSize:17 titleColor:[UIColor magentaColor]];
    [UIButton ym_view:self.diyChangeColorBtn backgroundColor:[UIColor whiteColor] cornerRadius:6.0f borderWidth:1.0f borderColor:[UIColor magentaColor]];
    
    [self.diyChangeColorBtn addTarget:self action:@selector(diyChangeColorBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - - 布局视图
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.scrollView.frame = CGRectMake(0, 0, MainScreenWidth, MainScreenHeight - NavBarHeight);
    self.colorView.frame = CGRectMake((MainScreenWidth - 100) / 2, 30, 100, 150);
    self.changeColorBtn.frame = CGRectMake(15, self.colorView.height - 40, self.colorView.width - 30, 30);
    self.diyColorView.frame = CGRectMake((MainScreenWidth - 100) / 2, self.colorView.bottom + 30, 100, 150);
    self.diyChangeColorBtn.frame = CGRectMake(15, self.diyColorView.height - 40, self.diyColorView.width - 30, 30);
    
    self.scrollView.contentSize = CGSizeMake(MainScreenWidth, self.diyColorView.bottom + 50);
    
    // 颜色图层
    [self graphicsColorLayer];
    // 自定义动画颜色图层
    [self diyGraphicsColorLayer];
    // 测试图层
    [self graphicsTestLayer];
}

#pragma mark 颜色图层
- (void)graphicsColorLayer {
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(15, 15, self.colorView.width - 30, self.colorView.width - 30);
    [self.colorView.layer addSublayer:self.colorLayer];
    
    self.colorLayer.backgroundColor = [UIColor redColor].CGColor;
    
    NSLog(@"Outside: %@", [self.colorView actionForLayer:self.colorView.layer forKey:@"backgroundColor"]);
    
    [UIView beginAnimations:nil context:nil];
    
    NSLog(@"Inside: %@", [self.colorView actionForLayer:self.colorView.layer forKey:@"backgroundColor"]);
    
    [UIView commitAnimations];
}

#pragma mark 改变颜色按钮点击调用
- (void)changeColorBtnClick {
    [CATransaction begin];
    [CATransaction setAnimationDuration:1.0];
    
//    [CATransaction setCompletionBlock:^{
//        CGAffineTransform transform = self.colorLayer.affineTransform;
//        transform = CGAffineTransformRotate(transform, M_PI_2);
//        self.colorLayer.affineTransform = transform;
//    }];
    
    CGAffineTransform transform = self.colorLayer.affineTransform;
    transform = CGAffineTransformRotate(transform, M_PI_2);
    self.colorLayer.affineTransform = transform;
    
    self.colorLayer.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0].CGColor;
    
    NSLog(@"%@", [self.colorLayer animationKeys]);
    
    [CATransaction commit];
}

#pragma mark 自定义颜色视图动画
- (void)diyGraphicsColorLayer {
    self.diyColorLayer = [CALayer layer];
    self.diyColorLayer.frame = CGRectMake(15, 15, self.diyColorView.width - 30, self.diyColorView.width - 30);
    [self.diyColorView.layer addSublayer:self.diyColorLayer];
    
    self.diyColorLayer.backgroundColor = [UIColor redColor].CGColor;
    
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    self.diyColorLayer.actions = @{@"backgroundColor" : transition};
}

#pragma mark 自定义颜色按钮点击
- (void)diyChangeColorBtnClick {
    self.diyColorLayer.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0].CGColor;
}

#pragma mark 测试图层
- (void)graphicsTestLayer {
    self.testLayer = [CALayer layer];
    self.testLayer.frame = CGRectMake(0, 0, 100, 100);
    self.testLayer.position = CGPointMake(50, 50);
    self.testLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:self.testLayer];
}

#pragma mark - - touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:self.view];
    if ([self.testLayer.presentationLayer hitTest:point]) {
        self.testLayer.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0].CGColor;
    } else {
        [CATransaction begin];
        [CATransaction setAnimationDuration:0.4];
        self.testLayer.position = point;
        [CATransaction commit];
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

- (UIButton *)changeColorBtn {
    if (_changeColorBtn == nil) {
        _changeColorBtn = [[UIButton alloc] init];
    }
    return _changeColorBtn;
}

- (UIView *)diyColorView {
    if (_diyColorView == nil) {
        _diyColorView = [[UIView alloc] init];
    }
    return _diyColorView;
}

- (UIButton *)diyChangeColorBtn {
    if (_diyChangeColorBtn == nil) {
        _diyChangeColorBtn = [[UIButton alloc] init];
    }
    return _diyChangeColorBtn;
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
