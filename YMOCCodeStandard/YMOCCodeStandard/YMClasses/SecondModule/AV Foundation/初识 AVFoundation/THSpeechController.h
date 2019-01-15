//
//  THSpeechController.h
//  YMOCCodeStandard
//
//  Created by iOS on 2019/1/15.
//  Copyright © 2019 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface THSpeechController : NSObject

/// 会话合成
@property (nonatomic, readonly, strong) AVSpeechSynthesizer *synthesizer;

/**
 实例化方法

 @return 实例
 */
+ (instancetype)speechController;

/**
 开启会话
 */
- (void)beginConversation;

@end

NS_ASSUME_NONNULL_END
