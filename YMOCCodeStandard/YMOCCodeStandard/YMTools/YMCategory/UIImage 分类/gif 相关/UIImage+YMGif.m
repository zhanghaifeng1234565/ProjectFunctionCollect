//
//  UIImage+YMGif.m
//  YMOAManageSystem
//
//  Created by iOS on 2018/11/23.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "UIImage+YMGif.h"
#import <objc/runtime.h>

@implementation UIImage (YMGif)

+ (void)load {
    NSLog(@"%s",__func__);
    /*
     Class:获取哪个类方法
     SEL:获取方法编号，根据SEL就能去对应的类找方法
     */
    Method imageNamedMethod = class_getClassMethod([UIImage class], @selector(setImage:));
    //home_imageNamed
    Method home_imageNamedMethod = class_getClassMethod([UIImage class], @selector(ym_setImage:));
    
    //交换方法
    method_exchangeImplementations(imageNamedMethod, home_imageNamedMethod);
}

//由于运行程序就会调用load，现在交换方法成功。
//在这个方法中，加载图片，得用home_imageNamed
+ (__kindof UIImage *)ym_setImage:(UIImage *)image {
    
    NSData *data = UIImagePNGRepresentation(image);
    UIImage *img = [UIImage ym_setImage:image];
    img.ym_imgData = data;
    return img;
}

#pragma mark - - 增加 ym_imageData 属性
- (NSData *)ym_imgData {
   return objc_getAssociatedObject(self, _cmd);
}

- (void)setYm_imgData:(NSData *)ym_imgData {
    objc_setAssociatedObject(self, @selector(ym_imgData), ym_imgData, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - - 加载本地的一张 gif 图片
+ (UIImage *)ym_setImageWithBundleGifName:(NSString *)gifName {
    
    UIImage *image = [[UIImage alloc] init];
    NSString *pathStr = [[NSBundle mainBundle] pathForResource:gifName ofType:@"gif"];
    NSData *gifData = [NSData dataWithContentsOfFile:pathStr];
    image.ym_imgData = gifData;
    image = [YYImage yy_imageWithSmallGIFData:gifData scale:1.0];
    return image;
}

#pragma mark - - 加载一张 网络的 gif
+ (UIImage *)ym_setImageWithUrlGifName:(NSString *)urlStr {
    
    UIImage *image = [[UIImage alloc] init];
    NSData *gifData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]];
    image.ym_imgData = gifData;
    image = [YYImage yy_imageWithSmallGIFData:gifData scale:1.0];
    return image;
}

@end
