//
//  YMPictureTestView.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/5.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMPictureTestView.h"

#import <UIImageView+WebCache.h>
#import "YMPictureViewer.h"

@interface YMPictureTestView ()

/** 图片控件数组 */
@property (nonatomic, strong) NSMutableArray *array;

@end

@implementation YMPictureTestView

#pragma mark -- init
- (instancetype)initWithFrame:(CGRect)frame imageType:(nonnull NSString *)type {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithHexString:@"f0f0f0"];
        
        self.array = [NSMutableArray array];
        
        UIImageView *imageView = [self createImageView];
        if ([type isEqualToString:@"1"]) {
            imageView.image = [UIImage imageNamed:@"1.jpg"];
        } else {
            [imageView sd_setImageWithURL:[NSURL URLWithString:@"http://pic33.photophoto.cn/20141022/0019032438899352_b.jpg"]];
        }
        imageView.frame = CGRectMake(15, 15, (MainScreenWidth - 20 - 30) / 3, 100);
        [self addSubview:imageView];
        [self.array addObject:imageView];
        
        UIImageView *imageView2 = [self createImageView];
        if ([type isEqualToString:@"1"]) {
            imageView2.image = [UIImage imageNamed:@"2.jpg"];
        } else {
            [imageView2 sd_setImageWithURL:[NSURL URLWithString:@"http://pic33.photophoto.cn/20141022/0019032438899352_b.jpg"]];
        }
        imageView2.frame = CGRectMake(imageView.right + 10, imageView.top, imageView.width, imageView.height);
        [self addSubview:imageView2];
        [self.array addObject:imageView2];
        
        UIImageView *imageView3 = [self createImageView];
        if ([type isEqualToString:@"1"]) {
            imageView3.image = [UIImage imageNamed:@"3.jpg"];
        } else {
            [imageView3 sd_setImageWithURL:[NSURL URLWithString:@"http://pic33.photophoto.cn/20141022/0019032438899352_b.jpg"]];
        }
        imageView3.frame = CGRectMake(imageView2.right + 10, imageView2.top, imageView2.width, imageView2.height);
        [self addSubview:imageView3];
        [self.array addObject:imageView3];
        
        UIImageView *imageView4 = [self createImageView];
        if ([type isEqualToString:@"1"]) {
            imageView4.image = [UIImage imageNamed:@"4.jpg"];
        } else {
            [imageView4 sd_setImageWithURL:[NSURL URLWithString:@"http://pic33.photophoto.cn/20141022/0019032438899352_b.jpg"]];
        }
        imageView4.frame = CGRectMake(imageView.left, imageView.bottom + 10, imageView.width, imageView.height);
        [self addSubview:imageView4];
        [self.array addObject:imageView4];
        
        UIImageView *imageView5 = [self createImageView];
        if ([type isEqualToString:@"1"]) {
            imageView5.image = [UIImage imageNamed:@"5.jpg"];
        } else {
            [imageView5 sd_setImageWithURL:[NSURL URLWithString:@"http://pic33.photophoto.cn/20141022/0019032438899352_b.jpg"]];
        }
        imageView5.frame = CGRectMake(imageView4.right + 10, imageView4.top, imageView4.width, imageView4.height);
        [self addSubview:imageView5];
        [self.array addObject:imageView5];
        
        UIImageView *imageView6 = [self createImageView];
        if ([type isEqualToString:@"1"]) {
            imageView6.image = [UIImage imageNamed:@"6.jpg"];
        } else {
            [imageView6 sd_setImageWithURL:[NSURL URLWithString:@"http://pic33.photophoto.cn/20141022/0019032438899352_b.jpg"]];
        }
        imageView6.frame = CGRectMake(imageView5.right + 10, imageView5.top, imageView5.width, imageView5.height);
        [self addSubview:imageView6];
        [self.array addObject:imageView6];
    }
    return self;
}

#pragma mark -- 创建图片
- (UIImageView *)createImageView {
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.userInteractionEnabled = YES;
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.clipsToBounds = YES;
    imgView.layer.cornerRadius = 3.0f;
    
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
    [imgView addGestureRecognizer:tgr];
    return imgView;
}

#pragma mark -- 点击图片
- (void)click:(UITapGestureRecognizer *)tgr {
    YMPictureViewer *browserView = [[YMPictureViewer alloc] init];
    browserView.originalViews = self.array;
    browserView.currentIndex = [self.array indexOfObject:tgr.view];
    [browserView show];
}

@end
