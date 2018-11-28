//
//  YMStarControlView.m
//  YMDoctorClient
//
//  Created by iOS on 2018/7/6.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMStarControlView.h"

@interface YMStarControlView ()

/** 高亮星星 */
@property (nonatomic,strong) UIView *fullStarsView;
/** 灰色星星 */
@property (nonatomic,strong) UIView *emptyStarsView;
/** 星星控件的满分值 */
@property (nonatomic,assign) CGFloat maxScore;
/** 星星间距 */
@property (nonatomic,assign) CGFloat starMargin;

@end

@implementation YMStarControlView

#pragma mark -- init
- (instancetype)initWithFrame:(CGRect)frame delegate:(id)starRatingViewDelegate touchMoveIsEnable:(BOOL)enable fullStarName:(NSString *)fullStarName emptyStarName:(NSString *)emptyStarName maxScore:(CGFloat)maxScore sartMargin:(CGFloat)starMargin {
    if (self = [super initWithFrame:frame]) {
        self.maxScore = maxScore;
        self.starMargin = starMargin;
        [self initViewWithFullStarName:fullStarName emptyStarName:emptyStarName];
        if (starRatingViewDelegate) { // 是否关联带来
            self.delegate = starRatingViewDelegate;
            self.enable = enable; // 是否允许滑动
        }
    }
    return self;
}

#pragma mark -- 初始化视图
- (void)initViewWithFullStarName:(NSString *)fullStarName emptyStarName:(NSString *)emptyStarName {
    self.fullStarsView = [self initStarViewWithImageName:fullStarName];
    self.emptyStarsView = [self initStarViewWithImageName:emptyStarName];
    
    [self addSubview:self.emptyStarsView];
    [self addSubview:self.fullStarsView];
}

#pragma mark -- 生成基本控件
- (YMStarControlView *)initStarViewWithImageName:(NSString *)imageName {
    CGRect frame = self.bounds;
    YMStarControlView *view = [[YMStarControlView alloc] init];
    view.frame = frame;
    view.clipsToBounds = YES;
    for (int i = 0; i < self.maxScore; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(i * ((frame.size.width-self.starMargin*(self.maxScore-1)) / self.maxScore +self.starMargin), 0, (frame.size.width-self.starMargin*(self.maxScore-1)) / self.maxScore, frame.size.height);
        [view addSubview:imageView];
    }
    return view;
}

#pragma mark -- 触摸事件
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    self.fullStarsView.hidden = NO;
    if (self.enable) {
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self];
        CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        if(CGRectContainsPoint(rect,point))
        {
            [self changeStarForegroundViewWithPoint:point];
        }
    }
}

#pragma mark -- 改变分数
- (void)changeStarForegroundViewWithPoint:(CGPoint)point {
    if (point.x < 0) {
        point.x = 0;
    } else if (point.x > self.frame.size.width) {
        point.x = self.frame.size.width;
    }
    
    NSString * str = [NSString stringWithFormat:@"%0.2f",point.x / self.frame.size.width];
    float score = [str floatValue];
    point.x = score * self.frame.size.width;
    self.fullStarsView.frame = CGRectMake(0, 0, point.x, self.frame.size.height);
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(starRatingView: score:)]) {
        [self.delegate starRatingView:self score:score];
    }
}

#pragma mark -- setter方法
- (void)setEnable:(BOOL)enable {
    _enable = enable;
}

- (void)setScore:(CGFloat)score {
    _score = score;
    float width = score/self.maxScore;
    self.fullStarsView.frame = CGRectMake(0, 0, self.frame.size.width * width, self.frame.size.height);
}
@end
