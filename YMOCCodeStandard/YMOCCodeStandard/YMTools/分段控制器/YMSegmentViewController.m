//
//  YMSegmentViewController.m
//  YMDoctorClient
//
//  Created by iOS on 2018/6/28.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMSegmentViewController.h"

#import "YMSilderView.h"

#define MainScreenWidth [UIScreen mainScreen].bounds.size.width

@interface YMSegmentViewController ()
<UIScrollViewDelegate>

/** 装有控制器的数组 */
@property (strong, nonatomic) NSMutableArray *vcMarr;
/** 下划线 */
@property (nonatomic, strong) UIView *underLineView;
/** 滑块视图 */
@property (nonatomic, strong) YMSilderView *silderView;

@end

@implementation YMSegmentViewController {
    /** 上一次选中的btn */
    UIButton *_lastBtn;
    /** 总宽度低于屏幕物理宽度时,标题btn宽度 */
    CGFloat _btnwidth;
}


#pragma mark -- init
- (instancetype)initWithVcMarr:(NSMutableArray *)vcMarr {
    if (self = [super init]) {
        self.vcMarr = vcMarr;
    }
    return self;
}

#pragma mark -- lifeStyle
- (void)viewDidLoad {
    [super viewDidLoad];
    // 配置默认数据
    [self configDefaultData];
    // 添加视图
    [self addSubviews];
}

#pragma mark -- 配置默认数据
- (void)configDefaultData {
    self.view.backgroundColor = [UIColor whiteColor];
    self.scrollViewIndex = 0;
    self.tagHeight = 44.0f;
    self.btnFont = 15.0f;
    self.btnTitleMargin = 15.0f;
}

#pragma mark -- 添加视图
- (void)addSubviews {
    [self.view addSubview:self.titleScrollView];
    [self.view addSubview:self.contentScrollView];
    [self.view addSubview:self.underLineView];
}

#pragma mark -- 布局
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.titleScrollView.frame = CGRectMake(0, 0, MainScreenWidth, self.tagHeight);
    self.contentScrollView.frame = CGRectMake(0, self.titleScrollView.height, MainScreenWidth, self.view.height - self.titleScrollView.height);
    self.underLineView.frame = CGRectMake(0, self.titleScrollView.height, MainScreenWidth, 0.5);
    self.contentScrollView.contentSize = CGSizeMake(self.vcMarr.count * MainScreenWidth, self.contentScrollView.height);
    self.silderView.frame = CGRectMake(0, self.tagHeight - 3, 50, 3);
    
    /**  标签布局   */
    CGFloat Zwidth = 0;  //每个btn宽度的总长
    CGFloat Fwidth;  //每个btn的frame
    
    int i = 0 ;
    //获取所有button
    for (UIView *titleScrollview in self.titleScrollView.subviews) {
        if ([[titleScrollview class] isEqual:[UIButton class]]) {
            UIButton *subBtn = (UIButton *)titleScrollview;
            if (_btnNormolColor) {
                [subBtn setTitleColor:_btnNormolColor forState:UIControlStateNormal];
            } else {
                [subBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
            
            //每个btn宽度
            subBtn.titleLabel.font = [UIFont systemFontOfSize:self.btnFont];
            CGFloat subBtnWidth = [subBtn.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:self.btnFont]}].width + self.btnTitleMargin * 2;
            Zwidth += subBtnWidth;  //总宽度
            Fwidth = Zwidth-subBtnWidth; //frame 宽度
            subBtn.frame=CGRectMake(Fwidth, 0, subBtnWidth, self.tagHeight - 3);
            subBtn.tag = 10000 + i;
            [subBtn addTarget:self action:@selector(cilckBtn:) forControlEvents:UIControlEventTouchUpInside];
            if (i == 0) {
                subBtn.selected = YES;
                if (_btnSlectColor) {
                    [subBtn setTitleColor:_btnSlectColor forState:UIControlStateNormal];
                }else{
                    [subBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                }
                _lastBtn = subBtn;
            }
            i++ ;
        }
    }
    //计算出来的总宽度小于屏幕宽度时，每个btn宽度
    if (Zwidth < MainScreenWidth) {
        _btnwidth = MainScreenWidth / self.vcMarr.count;
        //获取所有button
        int i = 0;
        for (UIView *titleScrollview in self.titleScrollView.subviews) {
            if ([[titleScrollview class] isEqual:[UIButton class]]) {
                UIButton *subBtn = (UIButton *)titleScrollview;
                subBtn.frame=CGRectMake(_btnwidth * i, 0, _btnwidth, self.tagHeight - 3);
                i++;
            }
        }
    }
    if (Zwidth < MainScreenWidth) {
        //titlteBtn 居中显示
        self.titleScrollView.contentSize = CGSizeMake(MainScreenWidth, self.tagHeight);
    } else {
        self.titleScrollView.contentSize = CGSizeMake(Zwidth, self.tagHeight);
    }
    
    //默认偏移
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
    CGPoint offset = self.contentScrollView.contentOffset;
    offset.x = self.scrollViewIndex * MainScreenWidth;
    [self.contentScrollView setContentOffset:offset animated:YES];
}

#pragma mark -- 标签按钮点击调用
- (void)cilckBtn:(UIButton *)btn {
    UIButton *button = [self.titleScrollView viewWithTag:btn.tag];
    _lastBtn.selected = NO;
    if (self.btnNormolColor) { //if 设置了默认btn 颜色
        [_lastBtn setTitleColor:self.btnNormolColor forState:UIControlStateNormal];
    } else {
        [_lastBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    button.selected = YES;
    if (self.btnSlectColor) {
        [button setTitleColor:self.btnSlectColor forState:UIControlStateNormal];
    } else {
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    _lastBtn = button;
    NSInteger index = btn.tag - 10000;
    // 定位到指定位置
    CGPoint offset = self.contentScrollView.contentOffset;
    offset.x = index * MainScreenWidth;
    [self.contentScrollView setContentOffset:offset animated:YES];
}

#pragma mark -- 当手指抬起停止减速的时候会调用这个方法,
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView]; //加载ctrl
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (scrollView == self.contentScrollView) {
        // 一些临时变量
        CGFloat width = scrollView.frame.size.width;  // --->屏幕的宽度
        CGFloat offsetX = scrollView.contentOffset.x;
        // 当前控制器需要显示的控制器的索引
        NSInteger index = offsetX / width;
        self.scrollViewIndex = index;
        
        NSDictionary *indexDict = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%ld", index] forKey:@"currentIndex"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SEGMENTSCROLLVIEWINDEX" object:nil userInfo:indexDict];
        // 让对应的顶部标题居中显示
        UIButton *button = self.titleScrollView.subviews[index];
        //滑块位置
        CGRect rect;
        if (_sliderWidth) {
            rect = CGRectMake(button.frame.origin.x + (button.width - _sliderWidth) / 2, button.frame.size.height , _sliderWidth, 3) ;
        } else {
            rect = CGRectMake(button.frame.origin.x + self.btnTitleMargin, button.frame.size.height, button.frame.size.width - self.btnTitleMargin * 2, 3);
        }
        
        [UIView animateWithDuration:0.3f animations:^{
            self.silderView.frame=rect;
        }];
        _lastBtn.selected = NO;
        if (self.btnNormolColor) {
            [_lastBtn setTitleColor:self.btnNormolColor forState:UIControlStateNormal];
        } else {
            [_lastBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        if (![button isKindOfClass:[UIButton class]]) {
            return;
        }
        button.selected = YES;
        if (_btnSlectColor) {
            [button setTitleColor:_btnSlectColor forState:UIControlStateNormal];
        } else {
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        _lastBtn = button;
        //偏移量
        CGPoint titleOffsetX = self.titleScrollView.contentOffset;
        titleOffsetX.x = button.center.x - width / 2; //这里是偏移移动，titlescorllview随着滑动移动，这里就是始终居中 - width/2
        UIEdgeInsets degeInset = self.titleScrollView.contentInset;
        CGFloat leftInsetMargin = degeInset.left;
        CGFloat rightInsetMargin = degeInset.right;
        // 左边偏移量边界
        if(titleOffsetX.x <= 0) {
            titleOffsetX.x = 0 - leftInsetMargin;
        }
        //最大偏移， 避免最右边空出一大部分
        CGFloat maxOffsetX = self.titleScrollView.contentSize.width - width;
        // 右边偏移量边界
        if(titleOffsetX.x > maxOffsetX) {
            titleOffsetX.x = maxOffsetX+rightInsetMargin;
        }
        // 修改偏移量
        [self.titleScrollView  setContentOffset:titleOffsetX animated:YES];
        
        // 取出需要显示的控制器
        UIViewController *vc = self.vcMarr[index];
        if ([vc isViewLoaded]) {
            return;
        }
        [self addChildViewController:vc];
        vc.view.frame = CGRectMake(index*width, 0, width, self.contentScrollView.height);
        [vc.view layoutIfNeeded];
        [self.contentScrollView addSubview:vc.view];
    }
}

#pragma mark -- setter
- (void)setTagHeight:(CGFloat)tagHeight {
    _tagHeight = tagHeight;
    [self.view layoutIfNeeded];
}

-(void)setSliderBackColor:(UIColor *)sliderBackColor {
    _sliderBackColor = sliderBackColor ;
    self.silderView.backgroundColor = sliderBackColor;
}

#pragma mark -- 标签栏颜色
- (void)setTitleScrollviewBackColor:(UIColor *)titleScrollviewBackColor {
    _titleScrollviewBackColor = titleScrollviewBackColor;
    self.titleScrollView.backgroundColor = _titleScrollviewBackColor;
}

#pragma mark -- 默认选中时的颜色
- (void)setBtnSlectColor:(UIColor *)btnSlectColor {
    _btnSlectColor = btnSlectColor;
}

#pragma mark -- 默认未选中的颜色
-(void)setBtnNormolColor:(UIColor *)btnNormolColor {
    _btnNormolColor = btnNormolColor ;
}

#pragma mark -- 滑块宽度
- (void)setSliderWidth:(CGFloat)sliderWidth {
    _sliderWidth = sliderWidth;
}

#pragma mark -- 按钮间距
- (void)setBtnTitleMargin:(CGFloat)btnTitleMargin {
    _btnTitleMargin = btnTitleMargin;
}

#pragma mark -- lazyLoadUI
- (UIView *)underLineView {
    if (_underLineView == nil) {
        _underLineView = [[UIView alloc] init];
        _underLineView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.4f];
    }
    return _underLineView;
}

- (YMSilderView *)silderView {
    if (_silderView == nil) {
        _silderView = [[YMSilderView alloc] init];
        _silderView.backgroundColor =[UIColor greenColor];
    }
    return _silderView;
}

- (UIScrollView *)titleScrollView {
    if (_titleScrollView == nil) {
        _titleScrollView = [[UIScrollView alloc] init];
        _titleScrollView.delegate = self;
        _titleScrollView.bounces = NO;
        _titleScrollView.showsHorizontalScrollIndicator = NO;
        _titleScrollView.showsVerticalScrollIndicator = NO;
        for (int i = 0; i < self.vcMarr.count; i++) {
            UIButton *segBtn = [[UIButton alloc] init];
            UIViewController *vc = self.vcMarr[i];
            NSLog(@"%@", vc.title);
            [segBtn setTitle:[vc title] forState:UIControlStateNormal];
            segBtn.titleLabel.font = [UIFont systemFontOfSize:self.btnFont];
            [_titleScrollView addSubview:segBtn];
        }
        [_titleScrollView addSubview:self.silderView];
    }
    return _titleScrollView;
}

- (UIScrollView *)contentScrollView {
    if (_contentScrollView == nil) {
        _contentScrollView = [[UIScrollView alloc] init];
        _contentScrollView.delegate = self;
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.bounces = NO;
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        _contentScrollView.showsVerticalScrollIndicator = NO;
    }
    return _contentScrollView;
}

#pragma mark -- getter
- (NSMutableArray *)vcMarr {
    if (_vcMarr == nil) {
        _vcMarr = [[NSMutableArray alloc] init];
    }
    return _vcMarr;
}

@end
