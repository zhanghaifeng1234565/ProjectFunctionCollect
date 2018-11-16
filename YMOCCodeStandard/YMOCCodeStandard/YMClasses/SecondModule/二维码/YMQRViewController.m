//
//  YMQRViewController.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/16.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "YMQRViewController.h"

#import "YMPictureViewer.h"

@interface YMQRViewController ()
<UIGestureRecognizerDelegate>

/** 二维码 */
@property (nonatomic, strong) YMHighlightImageView *QRImageView;
/** 图片数组 */
@property (nonatomic, strong) NSMutableArray *imageMarr;

@end

@implementation YMQRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - - 加载视图
- (void)loadSubviews {
    [super loadSubviews];
    
    [self.view addSubview:self.QRImageView];
}

#pragma mark - - 配置视图
- (void)configSubviews {
    [super configSubviews];
    
    self.QRImageView.image = [UIImage createQRCodeWithUrl:@"12345" logoImageName:@"forward_resumes_blue_btn"];
    // 一定要将图片转成 二进制 否则不能保存图片
    self.QRImageView.image.ym_imageData = UIImagePNGRepresentation(self.QRImageView.image);
    self.QRImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGest:)];
    tap.delegate = self;
    [self.QRImageView addGestureRecognizer:tap];
    
    [self.imageMarr addObject:self.QRImageView];
}

#pragma mark - - 布局视图
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.QRImageView.frame = CGRectMake((MainScreenWidth - 150) / 2, YMSCROLLVIEW_TOP_MARGIN + NavBarHeight, 150, 150);
}

#pragma mark - - 图片点击调用
- (void)tapGest:(UITapGestureRecognizer *)gester {
    YMPictureViewer *browserView = [[YMPictureViewer alloc] init];
    browserView.originalViews = self.imageMarr;
    browserView.currentIndex = [self.imageMarr indexOfObject:gester.view];
    [browserView show];
}

#pragma mark - - lazyLoadUI
- (YMHighlightImageView *)QRImageView {
    if (_QRImageView == nil) {
        _QRImageView = [[YMHighlightImageView alloc] init];
    }
    return _QRImageView;
}

#pragma mark - - lazyLoadData
- (NSMutableArray *)imageMarr {
    if (_imageMarr == nil) {
        _imageMarr = [[NSMutableArray alloc] init];
    }
    return _imageMarr;
}

@end
