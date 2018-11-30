//
//  MVVMModel.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/30.
//  Copyright © 2018 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MVVMModel : NSObject

/// 输入框内容
@property (nonatomic, readwrite, copy) NSString *textFieldStr;
/// 标签内容
@property (nonatomic, readwrite, copy) NSString *labelStr;

@end

NS_ASSUME_NONNULL_END
