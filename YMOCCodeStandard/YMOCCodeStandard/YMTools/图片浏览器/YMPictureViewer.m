//
//  YMPictureViewer.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/5.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMPictureViewer.h"

#import <SDWebImageManager.h>
#import <UIImageView+WebCache.h>


@implementation YMPictureViewer {
    UIScrollView *_scrollView;
    UIPageControl *_pageView;
    NSArray *_cacheViews;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        self.clipsToBounds = YES;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.frame = CGRectMake(0, 0, self.frame.size.width + 10, self.frame.size.height);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    
    _pageView = [[UIPageControl alloc] init];
    _pageView.hidesForSinglePage = YES;
    _pageView.userInteractionEnabled = NO;
    _pageView.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageView.pageIndicatorTintColor = [UIColor grayColor];
    [self addSubview:_pageView];
}

- (void)show {
    NSMutableArray *array = [NSMutableArray array];
    //添加每个图片
    for (int i = 0; i < self.originalViews.count; i++) {
        UIImageView *originalView = self.originalViews[i];
        UIImage *img = originalView.image;
        YMImageBrowserItem *item = [[YMImageBrowserItem alloc] init];
        item.frame = CGRectMake(i * _scrollView.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
        item.imgView.image = img;
        if (i == self.currentIndex) {//当前选中的图片需要做相应的动画
            item.imgView.frame = [originalView convertRect:originalView.bounds toView:nil];
        } else {
            [item configContentSize];
        }
        __weak typeof(self) weakSelf = self;
        item.closeBlcok = ^{
            [weakSelf close];
        };
        [_scrollView addSubview:item];
        [array addObject:item];
    }
    if (array.count == 0) return;
    _cacheViews = [array copy];
    _scrollView.contentSize = CGSizeMake(_cacheViews.count * _scrollView.frame.size.width, _scrollView.frame.size.height);
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width * self.currentIndex, 0)];
    _pageView.numberOfPages = _cacheViews.count;
    _pageView.currentPage = self.currentIndex;
    CGSize size = [_pageView sizeForNumberOfPages:_cacheViews.count];
    _pageView.frame = CGRectMake((self.frame.size.width - size.width) / 2.0, self.frame.size.height - size.height - 20, size.width, size.height);
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    if (self.currentIndex < _cacheViews.count) {
        //执行动画
        YMImageBrowserItem *currentItem = _cacheViews[self.currentIndex];
        [UIView animateWithDuration:0.25 animations:^{
            self.backgroundColor = [UIColor colorWithWhite:0 alpha:1];
            [currentItem configContentSize];
        } completion:^(BOOL finished) {
            self.backgroundColor = [UIColor colorWithWhite:0 alpha:1];
            [currentItem configContentSize];
            [self downLoadImgs];//下载高清图片
        }];
    }
}

#pragma mark - - 下载图片
- (void)downLoadImgs {
    for (int i = 0; i < self.urls.count; i++) {
        YMImageBrowserItem *item = _cacheViews[i];
        NSString *urlString = self.urls[i];
        [item loadImgUrl:urlString];
    }
}

#pragma mark - - 关闭视图
- (void)close {
    if (self.currentIndex < self.originalViews.count) {
        _pageView.hidden = YES;
        UIImageView *currentOriginalView = self.originalViews[self.currentIndex];
        YMImageBrowserItem *currentItem = _cacheViews[self.currentIndex];
        CGRect frame = [currentOriginalView convertRect:currentOriginalView.bounds toView:nil];
        [UIView animateWithDuration:0.25 animations:^{
            self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
            currentItem.imgView.frame = frame;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    } else {
        [UIView animateWithDuration:0.25 animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.currentIndex = scrollView.contentOffset.x / scrollView.frame.size.width;
    _pageView.currentPage = self.currentIndex;
}

@end



@implementation YMImageBrowserItem {
    UIPanGestureRecognizer *panGestureRecognizer;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.scrollView addSubview:self.imgView];
        [self addSubview:self.scrollView];
        
        UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
        [self addGestureRecognizer:tgr];//单击
        
        UITapGestureRecognizer *doubleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTapFrom)];
        doubleRecognizer.numberOfTapsRequired = 2; // 双击
        [self addGestureRecognizer:doubleRecognizer];
        
        [tgr requireGestureRecognizerToFail:doubleRecognizer];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGester:)];
        [self addGestureRecognizer:longPress];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.scrollView.frame = self.bounds;
}

- (void)configContentSize {
    UIImage *img = self.imgView.image;
    if (img) {
        CGFloat height = img.size.height * self.frame.size.width / img.size.width;
        if (height < self.frame.size.height) height = self.frame.size.height;
        self.imgView.frame = CGRectMake(0, 0, self.frame.size.width, height);
        self.scrollView.contentSize = CGSizeMake(self.frame.size.width, height);
    } else {
        self.imgView.frame = self.bounds;
    }
}

- (void)loadImgUrl:(NSString *)urlString {
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    UIImage *image = [[manager imageCache] imageFromCacheForKey:urlString];
    if (image) {//判断本地是否已经有图片了
        self.imgView.image = image;
        [self configContentSize];
    } else {
        [self showProgressView];
        self.isloading = YES;
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:self.imgView.image options:(0) progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.progressView.progress = receivedSize * 1.0 / expectedSize;
            });
        } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            self.isloading = NO;
            [self configContentSize];
            [self.progressView removeFromSuperview];
            self.progressView = nil;
        }];
    }
}

#pragma mark - - 展示下载进度条
- (void)showProgressView {
    [self.progressView removeFromSuperview];
    self.progressView = [[YMSectorProgressView alloc] init];
    self.progressView.frame = self.bounds;
    self.progressView.userInteractionEnabled = NO;
    [self addSubview:self.progressView];
}

#pragma mark - - 双击放大或缩小
- (void)handleDoubleTapFrom {
    if (self.scrollView.isZoomBouncing || self.scrollView.isZooming) return;
    if (self.scrollView.zoomScale > 1) {
        [self.scrollView setZoomScale:1 animated:YES];
    } else {
        [self.scrollView setZoomScale:2 animated:YES];
    }
}

#pragma mark - - 长按手势
- (void)longPressGester:(UILongPressGestureRecognizer *)gester {
    if (gester.state == UIGestureRecognizerStateBegan) {
        __weak typeof(self) weakSelf = self;
        [YMSureCancelAlert alertText:@"是否要保存照片到相册" sureBtnTitle:@"确定保存" maxHeight:100 alertStyle:YMAlertButtonTypeStyleDefault sureBtnClick:^(UIButton * _Nonnull sureBtn) {
            [weakSelf savePicture:weakSelf.imgView];
        } cancelBtnClick:^(UIButton * _Nonnull cancelBtn) {
            
        }];
    }
}

#pragma mark -- 保存图片
- (void)savePicture:(UIImageView *)imageV {
    NSLog(@"imageV === %@", imageV);
    if (imageV.image != nil) {
        [YMMBProgressHUD ymShowCustomLoadingAlert:self text:@"保存中..."];
        UIImageWriteToSavedPhotosAlbum(imageV.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    } else {
        [YMMBProgressHUD ymShowBlackAlert:self text:@"保存失败！" afterDelay:2.0f];
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    [YMMBProgressHUD ymHideLoadingAlert:self];
    if(error != nil) {
        if (error.code == -3310) {
            __weak typeof(self) weakSelf = self;
            [YMSureCancelAlert alertText:@"请在“设置->隐私->照片”中确定“代码规范”是否为开启状态！" sureBtnTitle:@"我知道了！" maxHeight:100 alertStyle:YMAlertButtonTypeStyleAlone sureBtnClick:^(UIButton * _Nonnull sureBtn) {
                [YMMBProgressHUD ymShowBlackAlert:weakSelf text:@"图片保存出错！" afterDelay:2.0f];
            } cancelBtnClick:^(UIButton * _Nonnull cancelBtn) {

            }];
        } else {
            [YMMBProgressHUD ymShowBlackAlert:self text:@"图片保存出错！" afterDelay:2.0f];
        }
    } else {
        [YMMBProgressHUD ymShowBlackAlert:self text:@"图片已保存！" afterDelay:2.0f];
    }
}

#pragma mark - - 关闭视图
- (void)close {
    self.progressView.hidden = YES;
    if (self.scrollView.zoomScale > 1) self.scrollView.zoomScale = 1;
    self.scrollView.contentOffset = CGPointZero;
    if (self.closeBlcok) self.closeBlcok();
}

#pragma mark - - 下拉关闭浏览器
- (void)movePanGestureRecognizer:(UIPanGestureRecognizer *)pgr {
    if (pgr.state == UIGestureRecognizerStateBegan) {
        self.progressView.hidden = YES;
    } else if (pgr.state == UIGestureRecognizerStateChanged) {
        CGPoint location = [pgr locationInView:pgr.view.superview];
        CGPoint point = [pgr translationInView:pgr.view];
        CGRect rect = pgr.view.frame;
        CGFloat height = rect.size.height - point.y;
        CGFloat width = rect.size.width * height / rect.size.height;
        CGFloat y = rect.origin.y + 1.5 * point.y;
        CGFloat x = location.x * (rect.size.width - width) / pgr.view.superview.frame.size.width + point.x + rect.origin.x;
        if (rect.origin.y < 0) {
            height = pgr.view.superview.frame.size.height;
            width = pgr.view.superview.frame.size.width;
            y = rect.origin.y + point.y;
            x = rect.origin.x + point.x;
        }
        self.superview.superview.backgroundColor = [UIColor colorWithWhite:0 alpha:(pgr.view.superview.frame.size.height / 1.5 - y) / (pgr.view.superview.frame.size.height / 1.5)];
        pgr.view.frame = CGRectMake(x, y, width, height);
        [pgr setTranslation:CGPointZero inView:pgr.view];
    } else if (pgr.state == UIGestureRecognizerStateEnded) {
        CGPoint velocity = [pgr velocityInView:pgr.view];
        if (velocity.y > 500 && pgr.view.frame.origin.y > 0) {
            if (self.closeBlcok) self.closeBlcok();
        } else {
            [UIView animateWithDuration:0.25 animations:^{
                self.superview.superview.backgroundColor = [UIColor blackColor];
                [self configContentSize];
            } completion:^(BOOL finished) {
                self.superview.superview.backgroundColor = [UIColor blackColor];
                [self configContentSize];
                self.progressView.hidden = NO;
            }];
        }
    } else {
        if (self.closeBlcok) self.closeBlcok();
    }
}

#pragma mark - - UIScrollViewDelegate

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    if (self.isloading) {
        return nil;
    }
    return self.imgView;
}

#pragma mark -- 让UIImageView在UIScrollView缩放后居中显示
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width) ? (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height) ? (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    self.imgView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                      scrollView.contentSize.height * 0.5 + offsetY);
}

#pragma mark - - UIGestureRecognizerDelegate
//下拉才能出发手势
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer != panGestureRecognizer) return YES;
    if (self.scrollView.contentOffset.y > 0 || self.scrollView.isZoomBouncing || self.scrollView.isZooming || self.scrollView.zoomScale != 1) return NO;
    UIPanGestureRecognizer *pgr = (UIPanGestureRecognizer *)gestureRecognizer;
    CGPoint point = [pgr translationInView:pgr.view];
    if (point.y > 0) return YES;
    return NO;
}

#pragma mark - - Setter and Getter

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        _scrollView.maximumZoomScale = 3;
    }
    return _scrollView;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.userInteractionEnabled = YES;
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(movePanGestureRecognizer:)];
        panGestureRecognizer.delegate = self;
        [_imgView addGestureRecognizer:panGestureRecognizer];
    }
    return _imgView;
}

@end



@implementation YMSectorProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.radius = 20;
    }
    return self;
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [[UIColor colorWithWhite:0 alpha:0.1] set];
    UIBezierPath *bgPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0) radius:self.radius startAngle:-M_PI_2 endAngle:2 * M_PI - M_PI_2  clockwise:YES];
    [bgPath fill];
    
    [[UIColor colorWithWhite:1 alpha:0.9] set];
    [bgPath addArcWithCenter:CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0) radius:self.radius startAngle:-M_PI_2 endAngle:2 * M_PI - M_PI_2  clockwise:YES];
    [bgPath stroke];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0) radius:self.radius - 2 startAngle:-M_PI_2 endAngle:self.progress * 2 * M_PI - M_PI_2  clockwise:YES];
    [path addLineToPoint:CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0)];
    [path fill];
}

@end
