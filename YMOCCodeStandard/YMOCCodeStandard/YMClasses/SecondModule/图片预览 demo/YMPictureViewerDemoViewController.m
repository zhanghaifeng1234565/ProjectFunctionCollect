
//
//  YMPictureViewerDemoViewController.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/5.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMPictureViewerDemoViewController.h"

#import <UIImageView+WebCache.h>
#import "YMPictureViewer.h"

#import "YMPictureTestCollectionViewCell.h"
#import "YMPictureTestView.h"


@interface YMPictureViewerDemoViewController ()
<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

/** 图片容器 */
@property (nonatomic, strong) YMPictureTestView *testView;

/** 图片容器 */
@property (nonatomic, strong) UICollectionView *collectionView;
/** 数据源 */
@property (nonatomic, strong) NSMutableArray *dataMArr;

@end

@implementation YMPictureViewerDemoViewController

#pragma mark - - init
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // MARK: 初始化导航
    [self initNavData];
    
    // MARK: 加载视图
    [self loadSubviews];
    
    // MARK: 初始化数据
    [self initData];
}

#pragma mark - - 初始化导航
- (void)initNavData {
//    self.title = @"collectionView 图片预览";
    self.view.backgroundColor = [UIColor colorWithHexString:@"f0f0f0"];
}

#pragma mark - - 加载视图
- (void)loadSubviews {
    if ([self.isCollectionView isEqualToString:@"1"]) {
        [self.view addSubview:self.testView];
    } else {
        [self.view addSubview:self.collectionView];
    }
}

#pragma mark - - delegate - dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataMArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YMPictureTestCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YMPictureTestCollectionViewCellId" forIndexPath:indexPath];
    
    NSString *gifPath = self.dataMArr[indexPath.item];
    NSString *extensionName = gifPath.pathExtension;
    if ([extensionName.lowercaseString isEqualToString:@"gif"]) {
        if ([self.imageType isEqualToString:@"1"]) {
            cell.imageV.image = [UIImage yy_imageWithColor:[UIColor colorWithHexString:@"f0f0f0"]];
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                NSData *imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"timg" ofType:@"gif"]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.imageV.image = [YYImage yy_imageWithSmallGIFData:imageData scale:0.5f];
                    cell.imageV.image.ym_imageData = imageData;
                });
            });
        } else {
            cell.imageV.image = [UIImage yy_imageWithColor:[UIColor colorWithHexString:@"f0f0f0"]];
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                NSURL *imageUrl = [NSURL URLWithString:self.dataMArr[indexPath.item]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.imageV.image  = [YYImage yy_imageWithSmallGIFData:[NSData dataWithContentsOfURL:imageUrl] scale:0.5f];
                    cell.imageV.image.ym_imageData = [NSData dataWithContentsOfURL:imageUrl];
                });
            });
        }
    } else {
        if ([self.imageType isEqualToString:@"1"]) {
            cell.imageV.image = [UIImage imageNamed:self.dataMArr[indexPath.item]];
            cell.imageV.image.ym_imageData = UIImagePNGRepresentation(cell.imageV.image);
        } else {
            [cell.imageV sd_setImageWithURL:[NSURL URLWithString:self.dataMArr[indexPath.item]]];
            cell.imageV.image.ym_imageData = UIImagePNGRepresentation(cell.imageV.image);
        }
    }
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableArray *imageMArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.dataMArr.count; i++) {
        NSIndexPath *indeP = [NSIndexPath indexPathForItem:i inSection:0];
        YMPictureTestCollectionViewCell *cell = (YMPictureTestCollectionViewCell *)[collectionView cellForItemAtIndexPath:indeP];
        [imageMArr addObject:cell.imageV];
    }
    
    YMPictureViewer *browserView = [[YMPictureViewer alloc] init];
    browserView.originalViews = imageMArr;
    browserView.currentIndex = indexPath.item;
    [browserView show];
}

#pragma mark -- 初始化数据
- (void)initData {
    [self.dataMArr removeAllObjects];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *gifPath = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1541501024814&di=468b91018f102112e7ce25e0d6ccb20d&imgtype=0&src=http%3A%2F%2Fimg3.duitang.com%2Fuploads%2Fitem%2F201603%2F08%2F20160308174903_X2Vnc.gif";
        if ([self.imageType isEqualToString:@"1"]) {
            for (int i = 0; i < 6; i++) {
                if (i % 2 == 0) {
                    [self.dataMArr addObject:gifPath];
                } else {
                    [self.dataMArr addObject:[NSString stringWithFormat:@"%d.jpg", i + 1]];
                }
            }
        } else {
            for (int i = 0; i < 9; i++) {
                if (i % 2 == 0) {
                    [self.dataMArr addObject:gifPath];
                } else {
                    [self.dataMArr addObject:[NSString stringWithFormat:@"http://pic33.photophoto.cn/20141022/0019032438899352_b.jpg"]];
                }
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    });
}

#pragma mark - - lazyLoadUI
- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake((MainScreenWidth - 20 - 30) / 3, 100);
        flowLayout.minimumLineSpacing = 10;
        flowLayout.minimumLineSpacing = 10;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(15, 15, MainScreenWidth - 30, MainScreenHeight - NavBarHeight - 15) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        
        [_collectionView registerClass:[YMPictureTestCollectionViewCell class] forCellWithReuseIdentifier:@"YMPictureTestCollectionViewCellId"];
    }
    return _collectionView;
}

- (YMPictureTestView *)testView {
    if (_testView == nil) {
        _testView = [[YMPictureTestView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight - NavBarHeight) imageType:self.imageType];
    }
    return _testView;
}

#pragma mark - - getter
- (NSMutableArray *)dataMArr {
    if (_dataMArr == nil) {
        _dataMArr = [[NSMutableArray alloc] init];
    }
    return _dataMArr;
}

@end
