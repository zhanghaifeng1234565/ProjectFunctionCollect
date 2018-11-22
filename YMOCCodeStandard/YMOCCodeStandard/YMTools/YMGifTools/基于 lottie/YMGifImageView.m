//
//  YMGifImageView.m
//  YMOAManageSystem
//
//  Created by iOS on 2018/11/21.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "YMGifImageView.h"

@interface YMGifImageView ()

/** gif 容器 */
@property (nonatomic, strong) LOTAnimationView *lotAnimationV;

@end

@implementation YMGifImageView

#pragma mark - - init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        LOTAnimationView *animation = [[LOTAnimationView alloc] init];
        [self addSubview:animation];
        self.lotAnimationV = animation;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame animationUrl:(NSURL *)url {
    if (self = [super initWithFrame:frame]) {
        LOTAnimationView *animation = [[LOTAnimationView alloc] initWithContentsOfURL:url];
        [self addSubview:animation];
        self.lotAnimationV = animation;
    }
    return self;
}

#pragma mark - - 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.lotAnimationV.frame = CGRectMake(0, 0, self.width, self.height);
}

#pragma mark - - 通过文件名字设置
- (void)setAnimationFileName:(NSString *)fileName {
    [self.lotAnimationV setAnimationNamed:fileName];
    [self.lotAnimationV play];
    self.lotAnimationV.loopAnimation = YES;
    [self.lotAnimationV playWithCompletion:^(BOOL animationFinished) {
        // Do Something
    }];
    [self layoutIfNeeded];
}

#pragma mark - - 通过json设置
- (void)setAnimationJsonDict:(NSDictionary *)jsonDict {
    [self.lotAnimationV setAnimationFromJSON:jsonDict];
    [self.lotAnimationV play];
    self.lotAnimationV.loopAnimation = YES;
    [self.lotAnimationV playWithCompletion:^(BOOL animationFinished) {
        // Do Something
    }];
    [self layoutIfNeeded];
}



@end
