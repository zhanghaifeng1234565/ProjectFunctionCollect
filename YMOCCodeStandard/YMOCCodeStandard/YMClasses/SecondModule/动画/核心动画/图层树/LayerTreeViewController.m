//
//  LayerTreeViewController.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/12/24.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "LayerTreeViewController.h"

@interface LayerTreeViewController ()
<CALayerDelegate>

/// 图层视图
@property (nonatomic, readwrite, strong) UIView *layerView;
/// 蓝色图层
@property (nonatomic, readwrite, strong) CALayer *blueLayer;

@end

@implementation LayerTreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"图层树";
}

#pragma mark - - 加载视图
- (void)loadSubviews {
    [super loadSubviews];
    
    [self.view addSubview:self.layerView];
    [self.layerView.layer addSublayer:self.blueLayer];
}

#pragma mark - - 配置视图
- (void)configSubviews {
    [super configSubviews];
    
    self.layerView.backgroundColor = UIColor.groupTableViewBackgroundColor;
    self.blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    self.blueLayer.delegate = self;
    self.blueLayer.contentsScale = [UIScreen mainScreen].scale;
}

#pragma mark - - 布局视图
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.layerView.frame = CGRectMake((MainScreenWidth - 200) / 2, 100, 200, 200);
    self.blueLayer.frame = CGRectMake((self.layerView.width - 100) / 2, (self.layerView.height - 100) / 2, 100, 100);
    
    [self.blueLayer display];
}

#pragma mark - - CALayerDelegate
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    CGContextSetLineWidth(ctx, 10);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextStrokeEllipseInRect(ctx, layer.bounds);
}

#pragma mark - - lazyLoad UI
- (UIView *)layerView {
    if (_layerView == nil) {
        _layerView = [[UIView alloc] init];
    }
    return _layerView;
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
