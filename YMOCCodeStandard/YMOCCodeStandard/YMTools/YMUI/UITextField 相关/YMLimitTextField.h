//
//  YMLimitTextField.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/26.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "YMUITextField.h"

NS_ASSUME_NONNULL_BEGIN

@interface YMLimitTextField : YMUITextField

/** 输入回调 */
@property (nonatomic, copy) void(^textFieldChange)(YMLimitTextField *textField);

/** 最大字数 */
@property (nonatomic, assign) CGFloat maxFontCount;

@end

NS_ASSUME_NONNULL_END
