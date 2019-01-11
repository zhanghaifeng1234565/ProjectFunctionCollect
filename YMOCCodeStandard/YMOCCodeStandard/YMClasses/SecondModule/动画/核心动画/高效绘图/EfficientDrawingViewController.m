//
//  EfficientDrawingViewController.m
//  YMOCCodeStandard
//
//  Created by iOS on 2019/1/10.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "EfficientDrawingViewController.h"
#import "DrawingView.h"
#import "BlackBoardView.h"

@interface EfficientDrawingViewController ()

/// 滚动视图
@property (nonatomic, readwrite, strong) UIScrollView *scrollView;
/// 画板
@property (nonatomic, readwrite, strong) DrawingView *drawView;
/// 黑板
@property (nonatomic, readwrite, strong) BlackBoardView *blackView;

@end

@implementation EfficientDrawingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"高效绘图";
}

#pragma mark - - 加载视图
- (void)loadSubviews {
    [super loadSubviews];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.drawView];
    [self.scrollView addSubview:self.blackView];
}

#pragma mark - - 配置视图
- (void)configSubviews {
    [super configSubviews];
    
    self.drawView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.blackView.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

#pragma mark - - 布局视图
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.scrollView.frame = CGRectMake(0, 0, MainScreenWidth, MainScreenHeight - NavBarHeight);
    self.drawView.frame = CGRectMake(15, 30, MainScreenWidth - 30, 100);
    self.blackView.frame = CGRectMake(15, self.drawView.bottom + 30, MainScreenWidth - 30, 100);
    
    self.scrollView.contentSize = CGSizeMake(MainScreenWidth, self.blackView.bottom + 50);
}

#pragma mark - - lazyLoadUI
- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

- (DrawingView *)drawView {
    if (_drawView == nil) {
        _drawView = [[DrawingView alloc] init];
    }
    return _drawView;
}

- (BlackBoardView *)blackView {
    if (_blackView == nil) {
        _blackView = [[BlackBoardView alloc] init];
    }
    return _blackView;
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
