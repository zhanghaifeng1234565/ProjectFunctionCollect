//
//  LayerScrollView.m
//  YMOCCodeStandard
//
//  Created by iOS on 2019/1/3.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "LayerScrollView.h"

@interface LayerScrollView ()<UIGestureRecognizerDelegate>

@end

@implementation LayerScrollView

+ (Class)layerClass {
    return [CAScrollLayer class];
}

- (void)setUp {
    self.layer.masksToBounds = YES;
    
    UIPanGestureRecognizer *recognizer = nil;
    recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:recognizer];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setUp];
}

#pragma mark - - 拖拽手势
- (void)pan:(UIPanGestureRecognizer *)recognizer {
    CGPoint offset = self.bounds.origin;
    offset.x = [recognizer locationInView:self].x;
    offset.y = [recognizer locationInView:self].y;
    
    [(CAScrollLayer *)self.layer scrollPoint:offset];
    
    [recognizer setTranslation:CGPointZero inView:self];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
