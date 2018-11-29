//
//  ScanningQRVC.m
//  OA
//
//  Created by iOS开发 on 2018/11/21.
//  Copyright © 2018年 iOS开发. All rights reserved.
//

#import "ScanningQRVC.h"
#import "QRCode.h"
@interface ScanningQRVC ()
<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) QRCode *qrCodeManager;

@end

@implementation ScanningQRVC

- (void)dealloc {
    NSLog(@"释放");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.blackColor;
    
    [self initScanning];
    [self createUI];
}

#pragma mark - override
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.qrCodeManager stopScanning];
}

#pragma mark - createUI
- (void)createUI {
    // 相册
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 40, 40);
    [rightBtn setTitle:@"相册" forState:UIControlStateNormal];
    [rightBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtn addTarget:self action:@selector(albumClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 40, 40);
    [leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [leftBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    [self.navigationItem setRightBarButtonItem:rightBarButtonItem];
    
    UIBarButtonItem *leftBtnBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    [self.navigationItem setLeftBarButtonItem:leftBtnBarButtonItem];
    
    UIView *backView = [[UIView alloc] initWithFrame:self.view.bounds];
    backView.backgroundColor = UIColor.clearColor;
    [self.view addSubview:backView];
    [self addBgLayer:backView];
}

- (void)addBgLayer:(UIView *)bgView {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = bgView.bounds;
    gradientLayer.colors = @[(__bridge id)[[UIColor  colorWithRed:20 / 255.0 green:13 / 255.0 blue:12 / 255.0 alpha:1] colorWithAlphaComponent:.65].CGColor,(__bridge id)[[UIColor  colorWithRed:20 / 255.0 green:13 / 255.0 blue:12 / 255.0 alpha:1] colorWithAlphaComponent:.27].CGColor];
    gradientLayer.startPoint = CGPointMake(0.5, 0);
    gradientLayer.endPoint = CGPointMake(0.5, 1);
    
    gradientLayer.locations = @[@0,@1];
    
    CGPoint beginPoint = CGPointMake((CGRectGetWidth(bgView.bounds) - 193) / 2.f + 16, (CGRectGetHeight(bgView.bounds) - 193) / 2.f);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 1;
    [path moveToPoint:CGPointMake(beginPoint.x + 10 , beginPoint.y)];
    [path addLineToPoint:CGPointMake(beginPoint.x + 161, beginPoint.y)];
    [path addArcWithCenter:CGPointMake(beginPoint.x + 161, beginPoint.y + 16) radius:16 startAngle:3 * M_PI_2 endAngle:0 clockwise:YES];
    [path addLineToPoint:CGPointMake(beginPoint.x + 177, beginPoint.y + 177)];
    [path addArcWithCenter:CGPointMake(beginPoint.x + 161, beginPoint.y + 177) radius:16 startAngle:0 endAngle:M_PI_2 clockwise:YES];
    [path addLineToPoint:CGPointMake(beginPoint.x , beginPoint.y + 193)];
    [path addArcWithCenter:CGPointMake(beginPoint.x , beginPoint.y + 177) radius:16 startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
    [path addLineToPoint:CGPointMake(beginPoint.x - 16 , beginPoint.y + 16)];
    [path addArcWithCenter:CGPointMake(beginPoint.x , beginPoint.y + 16) radius:16 startAngle:M_PI endAngle: 3 * M_PI_2 clockwise:YES];
    
    [path addLineToPoint:CGPointMake(beginPoint.x + 9.9 , beginPoint.y)];
    [path addLineToPoint:CGPointMake(beginPoint.x + 9.9 , 0)];
    [path addLineToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(0, CGRectGetHeight(bgView.bounds))];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(bgView.bounds), CGRectGetHeight(bgView.bounds))];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(bgView.bounds), 0)];
    [path addLineToPoint:CGPointMake(beginPoint.x + 10 , 0)];
    [path moveToPoint:CGPointMake(beginPoint.x + 10 , beginPoint.y)];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.strokeColor = [UIColor blackColor].CGColor;
    layer.fillColor = [UIColor blackColor].CGColor;
    gradientLayer.mask = layer;
    
    [bgView.layer addSublayer:gradientLayer];
}

#pragma mark - initDevice
- (void)initScanning {
    self.qrCodeManager = [[QRCode alloc] init];
    __weak typeof(self)weakSelf = self;
    [_qrCodeManager initDeviceAndAddView:self.view WithSuccessBlock:^(NSString * _Nonnull qrcode) {
        [weakSelf pop];
        if (weakSelf.scanningSuccess) {
            weakSelf.scanningSuccess(qrcode);
        }
    } failBlock:^(NSError *error) {
        BOOL isStill = error.code == [kfailErrorCode integerValue];
        [weakSelf showAlertWithTitle:@"错误" message:error.localizedDescription isStillScanning:isStill];
    }];
}

#pragma mark - album
- (void)albumClick:(UIButton *)button {
    //创建UIImagePickerController对象，并设置代理和可编辑
    UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.editing = YES;
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePicker animated:YES completion:^{
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{
        [self.qrCodeManager starScanning];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    [picker dismissViewControllerAnimated:YES completion:^{
        [self.qrCodeManager starScanning];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }];
    //获取到的图片
    UIImage * image = [info valueForKey:UIImagePickerControllerEditedImage];
    NSString *QRCodeStr = [QRCode readAlbumQRCode:image];
    if (!QRCodeStr.length) {
        [self showAlertWithTitle:@"错误" message:kfailErrorDesc isStillScanning:YES];
    } else {
        [self pop];
        if (self.scanningSuccess) {
            self.scanningSuccess(QRCodeStr);
        }
    }
}

- (void)leftBtnClick {
    [self pop];
}

- (void)pop {
    if (self.isPush == YES) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message isStillScanning:(BOOL)isStillScanning {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (!isStillScanning) {
            [self pop];
        } else {
            [self.qrCodeManager starScanning];
        }
    }];
    [alert addAction:action];
    
    [self.navigationController presentViewController:alert animated:YES completion:nil] ;
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
