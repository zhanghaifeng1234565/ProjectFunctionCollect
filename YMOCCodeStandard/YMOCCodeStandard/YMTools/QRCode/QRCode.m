//
//  QRCode.m
//  OA
//
//  Created by iOS开发 on 2018/11/21.
//  Copyright © 2018年 iOS开发. All rights reserved.
//

#import "QRCode.h"
#import <AVFoundation/AVFoundation.h>

NSString *const kPowerErrorDesc = @"请在iPhone的“设置”-“隐私”-“相机”功能中，找到项目打开相机访问权限";
NSString *const kSupportErrorDesc = @"你手机不支持二维码扫描!";

NSString *const kPowerErrorCode = @"-101";
NSString *const kSupportErrorCode = @"-102";


@interface QRCode ()<AVCaptureMetadataOutputObjectsDelegate>
@property(nonatomic)AVCaptureDevice *device;
@property(nonatomic)AVCaptureDeviceInput *input;
@property(nonatomic)AVCaptureMetadataOutput *output;
@property(nonatomic)AVCaptureSession *session;
@property(nonatomic)AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, copy) void(^failScanningBlock)(NSError *);
@property (nonatomic, copy) void(^successScanningBlock)(NSString *qrcode);
@end

@implementation QRCode

#pragma mark - createQRCode
/**
 生成二维码
 
 @param string 二维码文字
 @param size 宽
 @return 二维码
 */
+ (UIImage *)creatQrWithString:(NSString *)string withSize:(CGFloat)size {
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKeyPath:@"inputMessage"];
    
    CIImage *image = [filter outputImage];
    
    return [self createNonInterpolatedUIImageFormCIImage:image withSize:size];
}

+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}



#pragma mark - albumIdentifyQRCode
/**
 通过图片读取二维码

 @param image 图片
 @return 二维码
 */
+ (NSString *)readAlbumQRCode:(UIImage *)image {
    CIImage *qrcodeImage = [CIImage imageWithCGImage:image.CGImage];
    CIContext *qrcodeContext = [CIContext contextWithOptions:nil];
    CIDetector *qrcodeDetector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:qrcodeContext options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
    NSArray *qrcodeFeaturesArr = [qrcodeDetector featuresInImage:qrcodeImage];
    NSString *qrCodeString = nil;
    if (qrcodeFeaturesArr && qrcodeFeaturesArr.count > 0) {
        for (CIQRCodeFeature *feature in qrcodeFeaturesArr) {
            if (qrCodeString && qrCodeString.length > 0) {
                break;
            }
            qrCodeString = feature.messageString;
        }
    }
    
    NSString *alertMessageString = nil;
    if (qrCodeString) {
        alertMessageString = qrCodeString;
    } else {
        alertMessageString = nil;
    }
    return alertMessageString;
}



#pragma mark - scanningQRCode
- (void)initDeviceAndAddView:(UIView *)view WithSuccessBlock:(void(^)(NSString *qrcode))successBlock failBlock:(void(^)(NSError *error))failBlock {
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:&error];
    // 判断权限
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        failBlock([self customErrorWithCode:kPowerErrorCode desc:kPowerErrorDesc]);
        return;
    }
    if (error) {
        failBlock([self customErrorWithCode:kSupportErrorCode desc:kSupportErrorDesc]);
        return;
    }
    
    self.output = [[AVCaptureMetadataOutput alloc]init];
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    self.session = [[AVCaptureSession alloc]init];
    if ([self.session canAddInput:self.input]) {
        [self.session addInput:self.input];
    }
    if ([self.session canAddOutput:self.output]) {
        [self.session addOutput:self.output];
    }
    self.output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    CGSize screen = [UIScreen mainScreen].bounds.size;
    CGPoint beginPoint = CGPointMake((CGRectGetWidth(view.bounds) - 193) / 2.f + 16, (CGRectGetHeight(view.bounds) - 193) / 2.f);
    [self.output setRectOfInterest:CGRectMake(beginPoint.y/screen.height, beginPoint.x/screen.width, 200/screen.height, 200/screen.width)];
    
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.previewLayer.frame = view.bounds;
    self.previewLayer.backgroundColor = [UIColor blackColor].CGColor;
    [view.layer addSublayer:self.previewLayer];
    view.layer.backgroundColor = [UIColor blackColor].CGColor;
    if ([UIScreen mainScreen].bounds.size.height == 480) {
        [self.session setSessionPreset:AVCaptureSessionPreset640x480];
    } else {
        [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    }
    
    [self.session startRunning];
     _successScanningBlock = successBlock;
    _failScanningBlock = failBlock;
}

#pragma mark - output
// 识别二维码成功协议回调
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if (metadataObjects.count > 0) {
        [self.session stopRunning];
        NSString *QRCodeStr = nil;
        AVMetadataMachineReadableCodeObject *obj = metadataObjects.lastObject;
        QRCodeStr = obj.stringValue;
        if (QRCodeStr.length) {
            if (_successScanningBlock) {
                _successScanningBlock(QRCodeStr);
            }
        } else {
            if (!_failScanningBlock) {
                _failScanningBlock([self customErrorWithCode:kfailErrorCode desc:kfailErrorDesc]);
            }
            [self starScanning];
        }
    }
}

- (void)starScanning {
    if (!self.session.running) {
        [self.session startRunning];
    }
}

- (void)stopScanning {
    if (self.session.running) {
        [self.session stopRunning];
    }
}

- (NSError *)customErrorWithCode:(NSString *)code desc:(NSString *)desc {
    NSString *domain = @"com.QRCode.ErrorDomain";
    NSDictionary *userInfo = @{NSLocalizedDescriptionKey: NSLocalizedString(desc, nil)};
    NSError *error = [NSError errorWithDomain:domain code:[code integerValue] userInfo:userInfo];
    return error;
}

@end
