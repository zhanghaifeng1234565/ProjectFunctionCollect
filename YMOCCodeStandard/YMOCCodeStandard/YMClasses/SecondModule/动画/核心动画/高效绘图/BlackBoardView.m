//
//  BlackBoardView.m
//  YMOCCodeStandard
//
//  Created by iOS on 2019/1/10.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "BlackBoardView.h"

#define BRUSH_SIZE 32

@interface BlackBoardView ()

/// 黑板擦数组
@property (nonatomic, readwrite, strong) NSMutableArray *strokesMArr;

@end

@implementation BlackBoardView


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:self];
    [self addBrushStrokeAtPoint:point];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:self];
    [self addBrushStrokeAtPoint:point];
}

- (void)addBrushStrokeAtPoint:(CGPoint)point {
    [self.strokesMArr addObject:[NSValue valueWithCGPoint:point]];
    [self setNeedsDisplayInRect:[self brushRectForPoint:point]];
}

- (CGRect)brushRectForPoint:(CGPoint)point {
    return CGRectMake(point.x - BRUSH_SIZE / 2, point.y - BRUSH_SIZE / 2, BRUSH_SIZE, BRUSH_SIZE);
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    for (NSValue *value in self.strokesMArr) {
        CGPoint point = [value CGPointValue];
        CGRect brushRect = [self brushRectForPoint:point];
        if (CGRectIntersectsRect(rect, brushRect)) {
            [[UIImage imageNamed:@"LayerImage"] drawInRect:brushRect];
        }
    }
}

#pragma mark - - lazyLoadUI
- (NSMutableArray *)strokesMArr {
    if (_strokesMArr == nil) {
        _strokesMArr = [NSMutableArray array];
    }
    return _strokesMArr;
}

@end
