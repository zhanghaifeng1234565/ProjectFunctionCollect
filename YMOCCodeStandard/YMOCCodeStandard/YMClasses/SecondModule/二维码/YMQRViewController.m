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

static NSString *logoNameStr = @"forward_resumes_blue_btn";

@interface YMQRViewController ()
<UIGestureRecognizerDelegate,
YMStarControlViewDelegate>

/** 滚动视图 */
@property (nonatomic, strong) UIScrollView *scrollView;
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
/** 输入要生成的二维码字符串 */
@property (nonatomic, strong) YMLimitTextField *QRTextField;

/** 星星控件 */
@property (nonatomic, strong) YMStarControlView *starView;

@end

@implementation YMQRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"二维码";
}

#pragma mark - - 加载视图
- (void)loadSubviews {
    [super loadSubviews];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.QRTextField];
    [self.scrollView addSubview:self.readQRCodeBtn];
    [self.scrollView addSubview:self.scannQRCodeBtn];
    [self.scrollView addSubview:self.QRImageView];
    [self.scrollView addSubview:self.codeLabel];
    [self.scrollView addSubview:self.starView];
}

#pragma mark - - 配置视图
- (void)configSubviews {
    [super configSubviews];
    
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    UIButton *creatBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 35)];
    [UIButton ym_button:creatBtn title:@"生成二维码" fontSize:14 titleColor:[UIColor magentaColor]];
    [UIView ym_view:creatBtn backgroundColor:[UIColor whiteColor] cornerRadius:3.0f borderWidth:0.5f borderColor:[UIColor magentaColor]];
    [creatBtn addTarget:self action:@selector(createBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [UIView ym_view:self.QRTextField backgroundColor:[UIColor whiteColor] cornerRadius:3.0f borderWidth:0.5f borderColor:[UIColor magentaColor]];
    self.QRTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入要生成二维码的字符串" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14], NSForegroundColorAttributeName : [UIColor magentaColor]}];
    
    self.QRTextField.rightView = creatBtn;
    self.QRTextField.rightViewMode = UITextFieldViewModeAlways;
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 35)];
    self.QRTextField.leftView = rightView;
    self.QRTextField.leftViewMode = UITextFieldViewModeAlways;
    
    
    self.QRImageView.image = [UIImage createQRCodeWithUrl:@"https://www.baidu.com" logoImageName:logoNameStr];
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
    self.codeLabel.userInteractionEnabled = YES;
    // 添加点击手势
    [self urlLabeltapGesture];
    // 添加长按手势
    [self urlLabelLongPressGesture];
}

#pragma mark - - 布局视图
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.scrollView.frame = CGRectMake(0, 0, MainScreenWidth, MainScreenHeight - NavBarHeight);
    self.QRTextField.frame = CGRectMake(30, 30, MainScreenWidth - 60, 35);
    self.readQRCodeBtn.frame = CGRectMake(30, self.QRTextField.bottom + 30, 100, 45);
    self.scannQRCodeBtn.frame = CGRectMake(MainScreenWidth - 30 - 100, self.readQRCodeBtn.top, 100, 45);
    self.QRImageView.frame = CGRectMake((MainScreenWidth - 150) / 2, self.scannQRCodeBtn.bottom + 30, 150, 150);
    
    [UILabel ym_label:self.codeLabel lineSpace:5 maxWidth:MainScreenWidth - 30 alignment:NSTextAlignmentCenter];
    CGFloat codeLabelHeight = [UILabel ym_getHeightWithString:self.codeLabel.text fontSize:15 lineSpace:5 maxWidth:MainScreenWidth - 30];
    self.codeLabel.frame = CGRectMake(15, self.QRImageView.bottom + 30, MainScreenWidth - 30, codeLabelHeight);
    
    self.starView.frame = CGRectMake((MainScreenWidth - 80) / 2, self.codeLabel.bottom + 30, 80, 15);
    
    BOOL isOverScreenHeight = (self.starView.bottom + 30) - (MainScreenHeight - NavBarHeight) > 0 ? YES : NO;
    self.scrollView.contentSize = CGSizeMake(MainScreenWidth, isOverScreenHeight ? self.starView.bottom + 30 : MainScreenHeight - NavBarHeight);
}

#pragma mark - - 生成二维码
- (void)createBtnClick {
    [self.view endEditing:YES];
    
    NSString *qrStr = [self.QRTextField.text length] > 0 ?  self.QRTextField.text : self.QRTextField.placeholder;
    self.QRImageView.image = [UIImage createQRCodeWithUrl:qrStr logoImageName:logoNameStr];
    // 一定要将图片转成 二进制 否则不能保存图片
    self.QRImageView.image.ym_imageData = UIImagePNGRepresentation(self.QRImageView.image);
}

#pragma mark - - 图片点击调用
- (void)tapGest:(UITapGestureRecognizer *)gester {
    [self.view endEditing:YES];
    
    YMPictureViewer *browserView = [[YMPictureViewer alloc] init];
    browserView.originalViews = self.imageMarr;
    browserView.currentIndex = [self.imageMarr indexOfObject:gester.view];
    [browserView show];
}

#pragma mark 识别二维码
- (void)readQRCodeBtnClick {
    [self.view endEditing:YES];
    
    NSString *codeStr = [QRCode readAlbumQRCode:self.QRImageView.image];
    NSLog(@"codeStr = %@", codeStr);
    self.codeLabel.text = [NSString stringWithFormat:@"%@", codeStr];
    [self layoutSubviews];
}

#pragma mark 扫描二维码
- (void)scannQRCodeBtnClick {
    [self.view endEditing:YES];
    
    ScanningQRVC *vc = [[ScanningQRVC alloc] init];
    vc.push = NO;
    YMUINavigationController *nav = [[YMUINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:^{
        
    }];
    
    WS(ws);
    vc.scanningSuccess = ^(NSString * _Nonnull QRCodeStr) {
        ws.codeLabel.text = [NSString stringWithFormat:@"%@", QRCodeStr];
        [ws layoutSubviews];
    };
}

#pragma mark -- 网址长按复制
- (void)urlLabelLongPressGesture {
    UILongPressGestureRecognizer *longPressGest = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(urlLabelLongPressGest:)];
    longPressGest.minimumPressDuration = 0.5f;
    longPressGest.delegate = self;
    [self.codeLabel addGestureRecognizer:longPressGest];
}

- (void)urlLabelLongPressGest:(UILongPressGestureRecognizer *)longGest {
    [self.view endEditing:YES];
    
    [self.codeLabel becomeFirstResponder]; // 用于UIMenuController显示，缺一不可
    if (longGest.state == UIGestureRecognizerStateBegan) {
        self.codeLabel.backgroundColor = [UIColor lightGrayColor];
        WS(ws);
        [YMSureCancelAlert alertText:[NSString stringWithFormat:@"确定复制网址？%@", self.codeLabel.text] sureBtnTitle:@"复制" maxHeight:100 alertStyle:YMAlertButtonTypeStyleDefault sureBtnClick:^(UIButton * _Nonnull sureBtn) {
            ws.codeLabel.backgroundColor = UIColor.clearColor;
            UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
            pasteBoard.string = self.codeLabel.text;
            [YMBlackSmallAlert showAlertWithMessage:@"复制成功" time:2.0f];
        } cancelBtnClick:^(UIButton * _Nonnull cancelBtn) {
            ws.codeLabel.backgroundColor = UIColor.clearColor;
        }];
    }
}

#pragma mark -- 网址点击跳转
- (void)urlLabeltapGesture {
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(urlLabeltapGest:)];
    tapGest.delegate = self;
    [self.codeLabel addGestureRecognizer:tapGest];
}

- (void)urlLabeltapGest:(UITapGestureRecognizer *)tapGest {
    [self.view endEditing:YES];
    
    NSURL *url = [self smartURLForString:self.codeLabel.text];
    [self validateUrl:url];
}

#pragma mark -- 判断网址格式
- (NSURL *)smartURLForString:(NSString *)str {
    NSURL *result;
    NSString *trimmedStr;
    NSRange schemeMarkerRange;
    NSString *scheme;
    assert(str != nil);
    result = nil;
    trimmedStr = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ( (trimmedStr != nil) && (trimmedStr.length != 0) ) {
        schemeMarkerRange = [trimmedStr rangeOfString:@"://"];
        if (schemeMarkerRange.location == NSNotFound) {
            result = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", trimmedStr]];
        } else {
            scheme = [trimmedStr substringWithRange:NSMakeRange(0, schemeMarkerRange.location)];
            assert(scheme != nil);
            if ( ([scheme compare:@"http"  options:NSCaseInsensitiveSearch] == NSOrderedSame)
                || ([scheme compare:@"https" options:NSCaseInsensitiveSearch] == NSOrderedSame) ) {
                result = [NSURL URLWithString:trimmedStr];
            } else {
                // 格式不符合
                result = [NSURL URLWithString:@"http:www.baidu.com"];
            }
        }
    }
    return result;
}

#pragma mark -- 判断网址可不可用
- (void)validateUrl:(NSURL *)candidate {
    if ([[UIApplication sharedApplication] canOpenURL:candidate]) {
        [YMMBProgressHUD ymShowCustomLoadingAlert:self.view text:@"加载中..."];
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:candidate options:[NSMutableDictionary dictionary] completionHandler:^(BOOL success) {
                [YMMBProgressHUD ymHideLoadingAlert:self.view];
            }];
        } else {
            [[UIApplication sharedApplication] openURL:candidate];
        }
    } else {
        [YMBlackSmallAlert showAlertWithMessage:@"网址无效！" time:2.0f];
    }
}

#pragma mark - - YMStarControlViewDelegate
- (void)starRatingView:(YMStarControlView *)view score:(CGFloat)score{
    NSLog(@"score = %f",score);
}

#pragma mark - - touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - - lazyLoadUI
- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
    }
    return _scrollView;
}

- (YMLimitTextField *)QRTextField {
    if (_QRTextField == nil) {
        _QRTextField = [[YMLimitTextField alloc] init];
    }
    return _QRTextField;
}

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

- (YMStarControlView *)starView {
    if (_starView == nil) {
        _starView = [[YMStarControlView alloc] initWithFrame:CGRectMake((MainScreenWidth - 80) / 2, self.codeLabel.bottom + 30, 80, 15) delegate:self touchMoveIsEnable:YES fullStarName:@"yellow_star" emptyStarName:@"gray_star" maxScore:5 sartMargin:2];
        
        [_starView setScore:3];
    }
    return _starView;
}

#pragma mark - - lazyLoadData
- (NSMutableArray *)imageMarr {
    if (_imageMarr == nil) {
        _imageMarr = [[NSMutableArray alloc] init];
    }
    return _imageMarr;
}

@end
