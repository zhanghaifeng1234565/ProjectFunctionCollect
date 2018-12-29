//
//  ChangeViewController.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/12/28.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "ChangeViewController.h"

@interface ChangeViewController ()

/// 背景滚动视图
@property (nonatomic, readwrite, strong) UIScrollView *scrollView;
/// 容器
@property (nonatomic, readwrite, strong) UIView *containerView;
/// 视图
@property (nonatomic, readwrite, strong) UIView *testView;
/// 对比视图
@property (nonatomic, readwrite, strong) UIView *compareView;

/// 外部视图
@property (nonatomic, readwrite, strong) UIView *outterView;
/// 内部视图
@property (nonatomic, readwrite, strong) UIView *innerView;

@end

@implementation ChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"变换";
}

#pragma mark - - 加载视图
- (void)loadSubviews {
    [super loadSubviews];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.containerView];
    [self.containerView addSubview:self.testView];
    [self.containerView addSubview:self.compareView];
    [self.scrollView addSubview:self.outterView];
    [self.outterView addSubview:self.innerView];
}

#pragma mark - - 配置属性
- (void)configSubviews {
    [super configSubviews];
    
    self.containerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.testView.backgroundColor = [UIColor redColor];
    self.compareView.backgroundColor = [UIColor blueColor];
    self.outterView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.innerView.backgroundColor = [UIColor magentaColor];
}

#pragma mark - - 布局视图
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.scrollView.frame = CGRectMake(0, 0, MainScreenWidth, MainScreenHeight - NavBarHeight);
    self.containerView.frame = CGRectMake(30, 30, MainScreenWidth - 60, 100);
    self.testView.frame = CGRectMake(15, 15, (self.containerView.width - 45) / 2, 70);
    self.compareView.frame = CGRectMake(self.testView.right + 15, self.testView.top, self.testView.width, self.testView.height);
    self.outterView.frame = CGRectMake((MainScreenWidth - 200) / 2, self.containerView.bottom + 30, 200, 200);
    self.innerView.frame = CGRectMake(50, 50, 100, 100);
    
    self.scrollView.contentSize = CGSizeMake(MainScreenWidth, self.outterView.bottom + 100);
    
    // 2D
//    [self transform];
    // 3D
//    [self transform3D];
    // anchorPoint
    [self commonAnchorPoint];
    // 扁平化图层
//    [self flatLayer];
    // 扁平化 3D
    [self flatLayer3D];
}

#pragma mark 2D
- (void)transform {
    CGAffineTransform transfrom = CGAffineTransformIdentity;
    
    transfrom = CGAffineTransformScale(transfrom, 0.5, 0.5);
    transfrom = CGAffineTransformRotate(transfrom, M_PI_4);
    transfrom = CGAffineTransformTranslate(transfrom, 200, 0);
    
    self.testView.layer.affineTransform = transfrom;
}

#pragma mark 3D
- (void)transform3D {
    CATransform3D transform = CATransform3DIdentity;
    
    transform.m34 = -1.0 / 500.0;
    transform = CATransform3DRotate(transform, M_PI_4, 0, 1, 0);
    
    self.testView.layer.transform = transform;
}

#pragma mark 相同的灭点
- (void)commonAnchorPoint {
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0/500;
    self.containerView.layer.sublayerTransform = perspective;
    
    CATransform3D tranform1 = CATransform3DMakeRotation(M_PI, 0, 1, 0);
    self.testView.layer.transform = tranform1;
    
    CATransform3D tranform2 = CATransform3DMakeRotation(-M_PI, 0, 1, 0);
    self.compareView.layer.transform = tranform2;
}

#pragma mark 扁平化图层
- (void)flatLayer {
    CATransform3D transform1 = CATransform3DIdentity;
    transform1 = CATransform3DMakeRotation(M_PI_4, 0, 0, 2);
    self.outterView.layer.transform = transform1;
    
    CATransform3D transform2 = CATransform3DIdentity;
    transform2 = CATransform3DMakeRotation(-M_PI_4, 0, 0, 2);
    self.innerView.layer.transform = transform1;
}

#pragma mark 扁平化 3D 图层
- (void)flatLayer3D {
    CATransform3D transform1 = CATransform3DIdentity;
    transform1.m34 = - 1.0/500.0;
    transform1 = CATransform3DRotate(transform1, M_PI_4, 0, 1, 0);
    self.outterView.layer.transform = transform1;
    
    CATransform3D transform2 = CATransform3DIdentity;
    transform2.m34 = - 1.0/500.0;
    transform2 = CATransform3DRotate(transform2, -M_PI_4, 0, 1, 0);
    self.innerView.layer.transform = transform2;
}

#pragma mark - - lazyLoadUI
- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
    }
    return _scrollView;
}

- (UIView *)containerView {
    if (_containerView == nil) {
        _containerView = [[UIView alloc] init];
    }
    return _containerView;
}

- (UIView *)testView {
    if (_testView == nil) {
        _testView = [[UIView alloc] init];
    }
    return _testView;
}

- (UIView *)compareView {
    if (_compareView == nil) {
        _compareView = [[UIView alloc] init];
    }
    return _compareView;
}

- (UIView *)outterView {
    if (_outterView == nil) {
        _outterView = [[UIView alloc] init];
    }
    return _outterView;
}

- (UIView *)innerView {
    if (_innerView == nil) {
        _innerView = [[UIView alloc] init];
    }
    return _innerView;
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
