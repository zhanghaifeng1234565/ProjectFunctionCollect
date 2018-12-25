//
//  BoardingMapViewController.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/12/24.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "BoardingMapViewController.h"

@interface BoardingMapViewController ()

/// 图层视图
@property (nonatomic, readwrite, strong) UIView *layerView;

/// 图层一
@property (nonatomic, readwrite, strong) UIView *oneView;
/// 图层二
@property (nonatomic, readwrite, strong) UIView *twoView;
/// 图层三
@property (nonatomic, readwrite, strong) UIView *threeView;
/// 图层四
@property (nonatomic, readwrite, strong) UIView *fourView;

@end

@implementation BoardingMapViewController {
    /// 1 代表 layerView 2 代表 one two three four
    int _flag;
    /// 是否是 contentsCenter YES 是 否则 不是
    BOOL _isContentsCenter;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"寄宿图";
}

#pragma mark - - 加载视图
- (void)loadSubviews {
    [super loadSubviews];
    
    _flag = 1;
    _isContentsCenter = YES;
    
    if (_flag == 1) {
        [self.view addSubview:self.layerView];
    } else {
        [self.view addSubview:self.oneView];
        [self.view addSubview:self.twoView];
        [self.view addSubview:self.threeView];
        [self.view addSubview:self.fourView];
    }
}

#pragma mark - - 配置视图
- (void)configSubviews {
    [super configSubviews];
    
    if (_flag == 1) {
        self.layerView.backgroundColor = UIColor.groupTableViewBackgroundColor;
        
        UIImage *image = [UIImage imageNamed:@"LayerImage"];
        self.layerView.layer.contents = (__bridge id)image.CGImage;
        self.layerView.contentMode = UIViewContentModeScaleAspectFit;
        self.layerView.layer.contentsGravity = kCAGravityResizeAspect;
        self.layerView.layer.contentsGravity = kCAGravityCenter;
        self.layerView.layer.contentsScale = image.scale;
        self.layerView.layer.contentsScale = [UIScreen mainScreen].scale;
    
        // view
        self.layerView.clipsToBounds = YES;
        // layer 或者
        self.layerView.layer.masksToBounds = YES;
    
        self.layerView.layer.contentsRect = CGRectMake(0, 0, 0.5, 0.5);
        
        if (_isContentsCenter == YES) {
            self.layerView.layer.contentsCenter = CGRectMake(0.25, 0.25, 0.5, 0.5);
        }
    } else {
        self.oneView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.twoView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.threeView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.fourView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        UIImage *imageOne = [UIImage imageNamed:@"LayerImage"];
        UIImage *imageTwo = [UIImage imageNamed:@"LayerImage"];
        UIImage *imageThree = [UIImage imageNamed:@"LayerImage"];
        UIImage *imageFour = [UIImage imageNamed:@"LayerImage"];
        
        [self addSpriteImage:imageOne contentsRect:CGRectMake(0, 0, 0.5, 0.5) layer:self.oneView.layer];
        [self addSpriteImage:imageTwo contentsRect:CGRectMake(0.5, 0, 0.5, 0.5) layer:self.twoView.layer];
        [self addSpriteImage:imageThree contentsRect:CGRectMake(0, 0.5, 0.5, 0.5) layer:self.threeView.layer];
        [self addSpriteImage:imageFour contentsRect:CGRectMake(0.5, 0.5, 0.5, 0.5) layer:self.fourView.layer];
    }
}

#pragma mark - - 布局视图
- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (_flag == 1) {
        self.layerView.frame = CGRectMake((MainScreenWidth - 200) / 2, 100, 200, 200);
    } else {
        self.oneView.frame = CGRectMake(15, 15, (MainScreenWidth - 45) / 2, (MainScreenWidth - 45) / 2);
        self.twoView.frame = CGRectMake(self.oneView.right + 15, self.oneView.top, (MainScreenWidth - 45) / 2, (MainScreenWidth - 45) / 2);
        self.threeView.frame = CGRectMake(15, self.oneView.bottom + 15, (MainScreenWidth - 45) / 2, (MainScreenWidth - 45) / 2);
        self.fourView.frame = CGRectMake(self.threeView.right + 15, self.threeView.top, (MainScreenWidth - 45) / 2, (MainScreenWidth - 45) / 2);
    }
}

#pragma mark - - 添加图片
- (void)addSpriteImage:(UIImage *)image contentsRect:(CGRect)rect layer:(CALayer *)layer {
    layer.contents = (__bridge id)image.CGImage;
    layer.contentsGravity = kCAGravityResizeAspect;
    layer.contentsRect = rect;
}

#pragma mark - - lazyLoad UI
- (UIView *)layerView {
    if (_layerView == nil) {
        _layerView = [[UIView alloc] init];
    }
    return _layerView;
}

- (UIView *)oneView {
    if (_oneView == nil) {
        _oneView = [[UIView alloc] init];
    }
    return _oneView;
}

- (UIView *)twoView {
    if (_twoView == nil) {
        _twoView = [[UIView alloc] init];
    }
    return _twoView;
}

- (UIView *)threeView {
    if (_threeView == nil) {
        _threeView = [[UIView alloc] init];
    }
    return _threeView;
}

- (UIView *)fourView {
    if (_fourView == nil) {
        _fourView = [[UIView alloc] init];
    }
    return _fourView;
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
