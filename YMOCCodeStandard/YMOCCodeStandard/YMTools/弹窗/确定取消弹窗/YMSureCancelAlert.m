//
//  YMSureCancelAlert.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/10/23.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMSureCancelAlert.h"

#define Main_Screen_Width [UIScreen mainScreen].bounds.size.width
#define Main_Screen_Height [UIScreen mainScreen].bounds.size.height
#define AlerViewWidth 270

const CGFloat vHeight = 44;

@interface YMSureCancelAlert ()

/** 透明度视图 */
@property (nonatomic, strong) UIControl *alphaView;
/** 内容背景视图 */
@property (nonatomic, strong) UIView *alertBgView;
/** 标题 */
@property (nonatomic, strong) UILabel *titleLabel;
/** 标题滚动视图 */
@property (nonatomic, strong) UIScrollView *titleLabelScrollView;
/** 水平分割线 */
@property (nonatomic, strong) UILabel *hLine;
/** 垂直分割线 */
@property (nonatomic, strong) UILabel *vLine;
/** 确定按钮 */
@property (nonatomic, strong) UIButton *sureBtn;
/** 取消按钮 */
@property (nonatomic, strong) UIButton *cancelBtn;

/** 确定按钮点击 */
@property (nonatomic, copy) void(^sureBlock)(UIButton *sender);
/** 取消按钮点击 */
@property (nonatomic, copy) void(^cancelBlock)(UIButton *sender);
@end

@implementation YMSureCancelAlert

#pragma mark -- dealloc
- (void)dealloc {
    NSLog(@"dealloc -- %@", [self class]);
}

#pragma mark -- init
- (instancetype)initWithTitleText:(NSString *)text sureBtnTitle:(NSString *)sureTitle maxHeight:(CGFloat)maxHeight alertStyle:(YMAlertButtonTypeStyle)alertStyle sureBtnClick:(void (^)(UIButton * _Nonnull))sureBtnClickBlock cancelBtnClick:(void (^)(UIButton * _Nonnull))cancelBtnClickBlock {
    if (self = [super init]) {
        _sureBlock = sureBtnClickBlock;
        _cancelBlock = cancelBtnClickBlock;
        // 添加视图
        [self addAlertSubView];
        // 确定按钮文字
        [self.sureBtn setTitle:sureTitle forState:UIControlStateNormal];
        // 布局
        [self layoutAlertSubViewTitleText:text maxHeight:maxHeight alertStyle:alertStyle];
    }
    return self;
}

#pragma mark -- 类方法
+ (instancetype)alertText:(NSString *)text sureBtnTitle:(NSString *)sureTitle maxHeight:(CGFloat)maxHeight alertStyle:(YMAlertButtonTypeStyle)alertStyle sureBtnClick:(void (^)(UIButton * _Nonnull))sureBtnClickBlock cancelBtnClick:(void (^)(UIButton * _Nonnull))cancelBtnClickBlock {
    return [[self alloc] initWithTitleText:text sureBtnTitle:sureTitle maxHeight:maxHeight alertStyle:alertStyle sureBtnClick:sureBtnClickBlock cancelBtnClick:cancelBtnClickBlock];
}

#pragma mark -- 添加视图
- (void)addAlertSubView {
    [self addSubview:self.alphaView];
    [self addSubview:self.alertBgView];
    [self.alertBgView addSubview:self.titleLabelScrollView];
    [self.titleLabelScrollView addSubview:self.titleLabel];
    [self.alertBgView addSubview:self.vLine];
    [self.alertBgView addSubview:self.hLine];
    [self.alertBgView addSubview:self.sureBtn];
    [self.alertBgView addSubview:self.cancelBtn];
}

#pragma mark -- 布局视图
- (void)layoutAlertSubViewTitleText:(NSString *)text maxHeight:(CGFloat)maxHeight alertStyle:(YMAlertButtonTypeStyle)aleryStyle {
    
    self.titleLabel.text = text;
    CGFloat titleLabelWidth = [text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}].width + 1;
    CGFloat titleLabelHeight = 18;
    CGFloat titleLableScrollViewHeight = 18.f;
    if (titleLabelWidth > (AlerViewWidth - 32)) {
        // 要变蓝的字符串的范围
        NSString *tmpStr = self.titleLabel.text;
        NSRange range = [tmpStr rangeOfString:[NSString stringWithFormat:@"换货只能更换同类型，同品牌的物品"]];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:self.titleLabel.text];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        
        [attributedString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14], NSForegroundColorAttributeName:[UIColor colorWithHexString:@"00a2e0"]} range:range];
        
        [paragraphStyle setLineSpacing:9];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.titleLabel.text.length)];
        paragraphStyle.alignment=NSTextAlignmentCenter;
        self.titleLabel.attributedText = attributedString;
        
        titleLabelHeight = [self getSpaceLabelHeightwithSpeace:13 withFont:[UIFont systemFontOfSize:15] withWidth:AlerViewWidth - 32];
        titleLableScrollViewHeight = titleLabelHeight > maxHeight ? maxHeight : titleLabelHeight;
    } else {
        titleLabelHeight = 18;
        titleLableScrollViewHeight = 18;
    }
    
    CGFloat alertViewHeiht = 54 + titleLableScrollViewHeight + vHeight + 0.5;
    
    self.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height);
    self.alphaView.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height);
    self.alertBgView.frame = CGRectMake((Main_Screen_Width - AlerViewWidth) / 2, (Main_Screen_Height - alertViewHeiht) / 2, AlerViewWidth, alertViewHeiht);
    self.titleLabelScrollView.frame = CGRectMake(16, 27, self.alertBgView.frame.size.width-32, titleLableScrollViewHeight);
    self.titleLabel.frame = CGRectMake(0, 0, self.titleLabelScrollView.frame.size.width, titleLabelHeight);
    self.hLine.frame = CGRectMake(0, self.alertBgView.frame.size.height - vHeight, self.alertBgView.frame.size.width, 0.5);
    if (aleryStyle == YMAlertButtonTypeStyleDefault) {
        self.cancelBtn.hidden = NO;
        self.vLine.frame = CGRectMake((self.alertBgView.frame.size.width - 0.5) / 2, self.alertBgView.frame.size.height-vHeight, 0.5, vHeight);
        self.cancelBtn.frame = CGRectMake(self.hLine.frame.origin.x, self.hLine.frame.size.height + self.hLine.frame.origin.y, self.vLine.frame.origin.x, vHeight);
        self.sureBtn.frame = CGRectMake(self.vLine.frame.origin.x + self.vLine.frame.size.width, self.hLine.frame.size.height + self.hLine.frame.origin.y, self.vLine.frame.origin.x, vHeight);
    } else if (aleryStyle == YMAlertButtonTypeStyleAlone) {
        self.cancelBtn.hidden=YES;
        self.vLine.frame = CGRectMake((self.alertBgView.frame.size.width - 0.5) / 2, self.alertBgView.frame.size.height - vHeight, 0.0, vHeight);
        self.cancelBtn.frame = CGRectMake(self.hLine.frame.origin.x, self.hLine.frame.size.height + self.hLine.frame.origin.y, 0, 0);
        self.sureBtn.frame = CGRectMake(self.hLine.frame.origin.x, self.hLine.frame.size.height + self.hLine.frame.origin.y, self.hLine.frame.size.width, vHeight);
    }
    
    // 设置滚动范围
    self.titleLabelScrollView.contentSize = CGSizeMake(self.alertBgView.frame.size.width - 32, titleLabelHeight);
    [self alertShow];
}

#pragma mark -- 确定按钮点击
- (void)sureBtnClick:(UIButton *)sender {
    if (self.sureBlock) {
        self.sureBlock(sender);
    }
    [self alertHidden];
}

#pragma mark -- 取消按钮点击
- (void)cancelBtnClick:(UIButton *)sender {
    if (self.cancelBlock) {
        self.cancelBlock(sender);
    }
    [self alertHidden];
}

#pragma mark -- 显示弹窗
- (void)alertShow {
    self.alphaView.alpha = 0.0;
    [UIView animateWithDuration:0.25f animations:^{
        self.alphaView.alpha = 0.3;
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark -- 隐藏弹窗
- (void)alertHidden {
    [self removeFromSuperview];
}

#pragma mark -- lazyLoad
- (UIControl *)alphaView {
    if (_alphaView == nil) {
        _alphaView = [[UIControl alloc] init];
        _alphaView.backgroundColor = [UIColor blackColor];
        _alphaView.alpha = 0.3;
        _alphaView.userInteractionEnabled = YES;
    }
    return _alphaView;
}

- (UIView *)alertBgView {
    if (_alertBgView == nil) {
        _alertBgView = [[UIView alloc] init];
        _alertBgView.userInteractionEnabled = YES;
        _alertBgView.backgroundColor = [UIColor whiteColor];
        _alertBgView.layer.masksToBounds = YES;
        _alertBgView.layer.cornerRadius = 13.0f;
    }
    return _alertBgView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UIScrollView *)titleLabelScrollView {
    if (_titleLabelScrollView == nil) {
        _titleLabelScrollView = [[UIScrollView alloc] init];
        _titleLabelScrollView.userInteractionEnabled = YES;
    }
    return _titleLabelScrollView;
}

- (UILabel *)hLine {
    if (_hLine == nil) {
        _hLine = [[UILabel alloc] init];
        _hLine.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
    }
    return _hLine;
}

- (UILabel *)vLine {
    if (_vLine == nil) {
        _vLine = [[UILabel alloc] init];
        _vLine.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
    }
    return _vLine;
}

- (UIButton *)sureBtn {
    if (_sureBtn == nil) {
        _sureBtn = [[UIButton alloc] init];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [_sureBtn setTitleColor:[UIColor colorWithHexString:@"00a2e0"] forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_sureBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithHexString:@"f0f0f0"] size:CGSizeMake(1, 1)] forState:UIControlStateHighlighted];
    }
    return _sureBtn;
}

- (UIButton *)cancelBtn {
    if (_cancelBtn == nil) {
        _cancelBtn = [[UIButton alloc] init];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [_cancelBtn setTitleColor:[UIColor colorWithHexString:@"00a2e0"] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_cancelBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithHexString:@"f0f0f0"] size:CGSizeMake(1, 1)] forState:UIControlStateHighlighted];
    }
    return _cancelBtn;
}

#pragma mark -- 通过颜色值生成一张图片
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) {
        return nil;
    }
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark -- 获取行高
- (CGFloat)getSpaceLabelHeightwithSpeace:(CGFloat)lineSpeace withFont:(UIFont*)font withWidth:(CGFloat)width {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    //    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    /** 行高 */
    paraStyle.lineSpacing = lineSpeace;
    // NSKernAttributeName字体间距
    NSDictionary *dic = @{NSFontAttributeName : font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName : @1.5f
                          };
    CGSize size = [self.titleLabel.text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}
@end
