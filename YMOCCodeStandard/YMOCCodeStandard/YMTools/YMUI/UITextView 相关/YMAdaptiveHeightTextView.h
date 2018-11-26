//
//  YMAdaptiveHeightTextView.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/26.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "YMUIPlaceholderTextView.h"

NS_ASSUME_NONNULL_BEGIN

@interface YMAdaptiveHeightTextView : YMUIPlaceholderTextView

/** 高度回调 */
@property (nonatomic, copy) void(^textViewHeightChange)(YMAdaptiveHeightTextView *textView);

/** 最大字数 */
@property (nonatomic, assign) CGFloat maxFontCount;


@end

NS_ASSUME_NONNULL_END
