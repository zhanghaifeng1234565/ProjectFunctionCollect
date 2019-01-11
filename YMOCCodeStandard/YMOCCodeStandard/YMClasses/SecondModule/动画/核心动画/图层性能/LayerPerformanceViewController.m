//
//  LayerPerformanceViewController.m
//  YMOCCodeStandard
//
//  Created by iOS on 2019/1/10.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "LayerPerformanceViewController.h"

#define WIDTH 10
#define HEIGHT 10
#define DEPTH 10
#define SIZE 100
#define SPACING 150
#define CAMERA_DISTANCE 500
#define PERSPECTIVE(z) (float)CAMERA_DISTANCE/(z + CAMERA_DISTANCE)

@interface LayerPerformanceViewController ()
<UIScrollViewDelegate>

/// 滚动视图
@property (nonatomic, readwrite, strong) UIScrollView *scrollView;
/// 用 CAShape 画圆
@property (nonatomic, readwrite, strong) UIView *cycleView;

@end

@implementation LayerPerformanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"图层性能";
}

#pragma mark - - 加载视图
- (void)loadSubviews {
    [super loadSubviews];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.cycleView];
}

#pragma mark - - 配置视图
- (void)configSubviews {
    [super configSubviews];
    
    self.cycleView.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

#pragma mark - - 布局视图
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.scrollView.frame = CGRectMake(0, 0, MainScreenWidth, MainScreenHeight - NavBarHeight);
    self.cycleView.frame = CGRectMake((MainScreenWidth - 100) / 2, 30, 100, 100);
    
    self.scrollView.contentSize = CGSizeMake((WIDTH - 1) * SPACING, (HEIGHT - 1) * SPACING);
    // 使用 CAShapeLayer 画圆
    [self drawCycleWithCAShapeLayer];
    // 通过可拉伸的图片
    [self drawCycleWithContents];
    // 很多小方块
    [self moreCube];
}

#pragma mark 使用 CAShapeLayer 画圆
- (void)drawCycleWithCAShapeLayer {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.cycleView.bounds cornerRadius:self.cycleView.width / 2];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor redColor].CGColor;
    [self.cycleView.layer addSublayer:shapeLayer];
}

#pragma mark 通过可拉伸的图片
- (void)drawCycleWithContents {
    CALayer *blueLayer = [CALayer layer];
    blueLayer.frame = self.cycleView.bounds;
    blueLayer.contentsCenter = CGRectMake(0.5, 0.5, 0, 0);
    blueLayer.contentsScale = [UIScreen mainScreen].scale;
    blueLayer.contents = (__bridge id)[UIImage imageNamed:@"forward_resumes_blue_btn"].CGImage;
    
    [self.cycleView.layer addSublayer:blueLayer];
}

#pragma mark 很多小方块
- (void)moreCube {
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = - 1.0/CAMERA_DISTANCE;
    self.scrollView.layer.sublayerTransform = transform;
    
    for (int z = DEPTH - 1; z >= 0; z--) {
        for (int y = 0; y < HEIGHT; y++) {
            for (int x = 0; x < WIDTH; x++) {
                CALayer *layer = [CALayer layer];
                layer.frame = CGRectMake(0, 0, SIZE, SIZE);
                layer.position = CGPointMake(x * SPACING, y * SPACING);
                layer.zPosition = -z * SPACING;
                layer.backgroundColor = [UIColor colorWithWhite:1 - z alpha:1.0f].CGColor;
                [self.scrollView.layer addSublayer:layer];
            }
        }
    }
}

#pragma mark - - lazyLoadUI
- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UIView *)cycleView {
    if (_cycleView == nil) {
        _cycleView = [[UIView alloc] init];
    }
    return _cycleView;
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
