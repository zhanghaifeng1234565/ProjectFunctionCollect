//
//  UIBezierPath+YMPuzzlePathMaker.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/28.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "UIBezierPath+YMPuzzlePathMaker.h"

@implementation UIBezierPath (YMPuzzlePathMaker)

+ (instancetype)ym_bezierPathWithPathMaker:(void(^)(YMPuzzlePathMaker *maker))maker {
    UIBezierPath *path = [UIBezierPath bezierPath];
    if (maker) {
        YMPuzzlePathMaker *pathMaker = [[YMPuzzlePathMaker alloc] initWithBezierPath:path];
        maker(pathMaker);
    }
    return path;
}

@end
