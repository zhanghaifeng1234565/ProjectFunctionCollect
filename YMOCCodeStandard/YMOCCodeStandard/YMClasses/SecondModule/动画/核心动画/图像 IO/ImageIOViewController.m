//
//  ImageIOViewController.m
//  YMOCCodeStandard
//
//  Created by iOS on 2019/1/10.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "ImageIOViewController.h"
#import "ImageIOCollectionViewCell.h"

@interface ImageIOViewController ()
<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,
CALayerDelegate>

/// 集合视图
@property (nonatomic, readwrite, strong) UICollectionView *collectionView;
/// 数据源
@property (nonatomic, readwrite, strong) NSMutableArray *dataMArr;

@end

@implementation ImageIOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"图像 IO";
}

#pragma mark - - 加载视图
- (void)loadSubviews {
    [super loadSubviews];
    
    [self.view addSubview:self.collectionView];
}

#pragma mark - - 配置属性
- (void)configSubviews {
    [super configSubviews];
    
    [self.dataMArr removeAllObjects];
    for (int i = 0; i < 6; i++) {
        NSString *pathStr = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%d", i + 1] ofType:@"jpg"];
        [self.dataMArr addObject:pathStr];
    }
    NSLog(@"self.dataArr = %@", self.dataMArr);
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"ImageIOCollectionViewCellId"];
}

#pragma mark - - 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.collectionView.frame = CGRectMake(0, 0, MainScreenWidth, MainScreenHeight - NavBarHeight);
}

#pragma mark - - delegate && dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataMArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageIOCollectionViewCellId" forIndexPath:indexPath];
    
    UIImageView *imageView = [cell.contentView.subviews lastObject];
    if (!imageView) {
        imageView = [[UIImageView alloc] initWithFrame:cell.contentView.bounds];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [cell.contentView addSubview:imageView];
    }
    
    imageView.image = [self loadImageAtIndex:indexPath.item cell:cell];
    if (indexPath.item < self.dataMArr.count - 1) {
        [self loadImageAtIndex:indexPath.item + 1 cell:cell];
    };
    
    if (indexPath.item > 0) {
        [self loadImageAtIndex:indexPath.item - 1 cell:cell];
    }
    
//    CATiledLayer *tiledLayer = [cell.contentView.layer.sublayers lastObject];
//    if (!tiledLayer) {
//        tiledLayer = [CATiledLayer layer];
//        tiledLayer.frame = cell.contentView.bounds;
//        tiledLayer.tileSize = CGSizeMake(cell.bounds.size.width * [UIScreen mainScreen].scale, cell.bounds.size.height * [UIScreen mainScreen].scale);
//        tiledLayer.delegate = self;
//        [tiledLayer setValue:@(indexPath.item) forKey:@"index"];
//        [cell.contentView.layer addSublayer:tiledLayer];
//    }
//    tiledLayer.contents = nil;
//    [tiledLayer setValue:@(indexPath.item) forKey:@"index"];
//    [tiledLayer setNeedsDisplay];
    
//    cell.tag = indexPath.item;
//    CGRect rect = cell.imageV.bounds;
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
////        NSInteger index = indexPath.row;
////        NSString *imagePath = self.dataMArr[index];
////        UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
//
////        NSInteger index = indexPath.item;
////        NSURL *imageURL = [NSURL fileURLWithPath:self.dataMArr[index]];
////        NSDictionary *options = @{(__bridge id)kCGImageSourceShouldCache : @"kCFBooleanTrue"};
////        CGImageSourceRef source = CGImageSourceCreateWithURL((__bridge CFURLRef)imageURL, (__bridge CFDictionaryRef)options);
////        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(source, 0, (__bridge CFDictionaryRef)options);
////        UIImage *image = [UIImage imageWithCGImage:imageRef];
////        CGImageRelease(imageRef);
////        CFRelease(source);
//
//        NSInteger index = indexPath.row;
//        NSString *imagePath = self.dataMArr[index];
//        UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
//        UIGraphicsBeginImageContextWithOptions(rect.size, YES, [UIScreen mainScreen].scale);
//        [image drawInRect:rect];
//        image = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (index == cell.tag) {
//                cell.imageV.image = image;
//            }
//        });
//    });
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(MainScreenWidth, MainScreenWidth);
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    NSInteger index = [[layer valueForKey:@"index"] integerValue];
    NSString *imagePath = self.dataMArr[index];
    UIImage *tiledImage = [UIImage imageWithContentsOfFile:imagePath];
    
    CGFloat aspectRatio = tiledImage.size.height / tiledImage.size.width;
    CGRect imageRect = CGRectZero;
    imageRect.size.width = layer.bounds.size.width;
    imageRect.size.height = layer.bounds.size.height * aspectRatio;
    imageRect.origin.y = (layer.bounds.size.height - imageRect.size.height);
    
    UIGraphicsPushContext(ctx);
    [tiledImage drawInRect:imageRect];
    UIGraphicsPopContext();
}

#pragma mark 图片缓存
- (UIImage *)loadImageAtIndex:(NSInteger)index cell:(UICollectionViewCell *)cell {
    static NSCache *cache = nil;
    if (!cache) {
        cache = [[NSCache alloc] init];
    }
    
    UIImage *image = [cache objectForKey:@(index)];
    if (image) {
        return [image isKindOfClass:[NSNull class]] ? nil : image;
    }
    
    [cache setObject:[NSNull null] forKey:@(index)];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSString *imagePath = self.dataMArr[index];
        UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
        UIGraphicsBeginImageContextWithOptions(image.size, YES, 0);
        [image drawAtPoint:CGPointZero];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        dispatch_async(dispatch_get_main_queue(), ^{
            [cache setObject:image forKey:@(index)];
            
            NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:index];
            UIImageView *imageView = [cell.contentView.subviews lastObject];
            imageView.image = image;
        });
    });
    return nil;
}

#pragma mark - - lazyLoadUI
- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    }
    return _collectionView;
}

#pragma mark - - lazyLoadData
- (NSMutableArray *)dataMArr {
    if (_dataMArr == nil) {
        _dataMArr = [NSMutableArray array];
    }
    return _dataMArr;
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
