//
//  UIBezierPath+YMPuzzlePathMaker.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/28.
//  Copyright © 2018 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMPuzzlePathMaker.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIBezierPath (YMPuzzlePathMaker)

+ (instancetype)ym_bezierPathWithPathMaker:(void(^)(YMPuzzlePathMaker *maker))maker;

@end

NS_ASSUME_NONNULL_END
