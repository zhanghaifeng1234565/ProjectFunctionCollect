//
//  YMQRViewController.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/16.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "YMQRViewController.h"

#import "YMPictureViewer.h"

#import "QRCode.h"
#import "ScanningQRVC.h"

@interface YMQRViewController ()
<UIGestureRecognizerDelegate>

/** 二维码 */
@property (nonatomic, strong) YMHighlightImageView *QRImageView;
/** 图片数组 */
@property (nonatomic, strong) NSMutableArray *imageMarr;

/** 读取识别二维码 */
@property (nonatomic, strong) UIButton *readQRCodeBtn;
/** 扫描二维码 */
@property (nonatomic, strong) UIButton *scannQRCodeBtn;
/** 二维码标签 */
@property (nonatomic, strong) UILabel *codeLabel;

@end

@implementation YMQRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - - 加载视图
- (void)loadSubviews {
    [super loadSubviews];
    
    [self.view addSubview:self.readQRCodeBtn];
    [self.view addSubview:self.scannQRCodeBtn];
    [self.view addSubview:self.QRImageView];
    [self.view addSubview:self.codeLabel];
}

#pragma mark - - 配置视图
- (void)configSubviews {
    [super configSubviews];
    
    self.QRImageView.image = [UIImage createQRCodeWithUrl:@"https://www.baidu.com" logoImageName:@"forward_resumes_blue_btn"];
    // 一定要将图片转成 二进制 否则不能保存图片
    self.QRImageView.image.ym_imageData = UIImagePNGRepresentation(self.QRImageView.image);
    self.QRImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGest:)];
    tap.delegate = self;
    [self.QRImageView addGestureRecognizer:tap];
    
    [self.imageMarr addObject:self.QRImageView];
    
    // 识别二维码
    [self.readQRCodeBtn setTitle:@"识别二维码" forState:UIControlStateNormal];
    self.readQRCodeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.readQRCodeBtn setTitleColor:[UIColor magentaColor] forState:UIControlStateNormal];
    self.readQRCodeBtn.layer.masksToBounds = YES;
    self.readQRCodeBtn.layer.cornerRadius = 3.0f;
    self.readQRCodeBtn.layer.borderWidth = 1.0f;
    self.readQRCodeBtn.layer.borderColor = [UIColor magentaColor].CGColor;
    [self.readQRCodeBtn addTarget:self action:@selector(readQRCodeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    // 扫描二维码
    [self.scannQRCodeBtn setTitle:@"扫描二维码" forState:UIControlStateNormal];
    self.scannQRCodeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.scannQRCodeBtn setTitleColor:[UIColor magentaColor] forState:UIControlStateNormal];
    self.scannQRCodeBtn.layer.masksToBounds = YES;
    self.scannQRCodeBtn.layer.cornerRadius = 3.0f;
    self.scannQRCodeBtn.layer.borderWidth = 1.0f;
    self.scannQRCodeBtn.layer.borderColor = [UIColor magentaColor].CGColor;
    [self.scannQRCodeBtn addTarget:self action:@selector(scannQRCodeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    // 二维码
    [UILabel ym_label:self.codeLabel fontSize:15 textColor:[UIColor magentaColor]];
}

#pragma mark - - 布局视图
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.readQRCodeBtn.frame = CGRectMake(30, 30, 100, 45);
    self.scannQRCodeBtn.frame = CGRectMake(MainScreenWidth - 30 - 100, 30, 100, 45);
    self.QRImageView.frame = CGRectMake((MainScreenWidth - 150) / 2, self.scannQRCodeBtn.bottom + 30, 150, 150);
    
    [UILabel ym_label:self.codeLabel lineSpace:5 maxWidth:MainScreenWidth - 30 alignment:NSTextAlignmentCenter];
    CGFloat codeLabelHeight = [UILabel ym_getHeightWithString:self.codeLabel.text fontSize:15 lineSpace:5 maxWidth:MainScreenWidth - 30];
    self.codeLabel.frame = CGRectMake(15, self.QRImageView.bottom + 30, MainScreenWidth - 30, codeLabelHeight);
}

#pragma mark - - 图片点击调用
- (void)tapGest:(UITapGestureRecognizer *)gester {
    YMPictureViewer *browserView = [[YMPictureViewer alloc] init];
    browserView.originalViews = self.imageMarr;
    browserView.currentIndex = [self.imageMarr indexOfObject:gester.view];
    [browserView show];
}

#pragma mark 识别二维码
- (void)readQRCodeBtnClick {
   NSString *codeStr = [QRCode readAlbumQRCode:self.QRImageView.image];
    NSLog(@"codeStr = %@", codeStr);
    self.codeLabel.text = [NSString stringWithFormat:@"%@", codeStr];
    [self layoutSubviews];
}

#pragma mark 扫描二维码
- (void)scannQRCodeBtnClick {
    ScanningQRVC *vc = [[ScanningQRVC alloc] init];
    [self.navigationController presentViewController:vc animated:YES completion:^{
        
    }];
    
    WS(ws);
    vc.scanningSuccess = ^(NSString * _Nonnull QRCodeStr) {
        ws.codeLabel.text = [NSString stringWithFormat:@"%@", QRCodeStr];
        [ws layoutSubviews];
    };
}

#pragma mark - - lazyLoadUI
- (YMHighlightImageView *)QRImageView {
    if (_QRImageView == nil) {
        _QRImageView = [[YMHighlightImageView alloc] init];
    }
    return _QRImageView;
}

- (UIButton *)readQRCodeBtn {
    if (_readQRCodeBtn == nil) {
        _readQRCodeBtn = [[UIButton alloc] init];
    }
    return _readQRCodeBtn;
}

- (UIButton *)scannQRCodeBtn {
    if (_scannQRCodeBtn == nil) {
        _scannQRCodeBtn = [[UIButton alloc] init];
    }
    return _scannQRCodeBtn;
}

- (UILabel *)codeLabel {
    if (_codeLabel == nil) {
        _codeLabel = [[UILabel alloc] init];
    }
    return _codeLabel;
}

#pragma mark - - lazyLoadData
- (NSMutableArray *)imageMarr {
    if (_imageMarr == nil) {
        _imageMarr = [[NSMutableArray alloc] init];
    }
    return _imageMarr;
}

@end
