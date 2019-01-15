//
//  THSpeechController.m
//  YMOCCodeStandard
//
//  Created by iOS on 2019/1/15.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "THSpeechController.h"

@interface THSpeechController ()

/// 会话合成
@property (nonatomic, readwrite, strong) AVSpeechSynthesizer *synthesizer;
/// 声音数组
@property (nonatomic, readwrite, strong) NSArray *voicesArr;
/// 字符串数组
@property (nonatomic, readwrite, strong) NSArray *speechStringsArr;

@end

@implementation THSpeechController

+ (instancetype)speechController {
    return [[self alloc] init];
}

- (instancetype)init {
    if (self = [super init]) {
        _synthesizer = [[AVSpeechSynthesizer alloc] init];
        _voicesArr = @[[AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"],
                       [AVSpeechSynthesisVoice voiceWithLanguage:@"en-GB"]];
        _speechStringsArr = @[@"Hello AV Foundation. How are you?",
                              @"I'm well! Thanks for asking.",
                              @"Are you excited about the book?",
                              @"Very! I have always felt so misunderstood",
                              @"What's your favorite feature?",
                              @"Oh, they're all my babies. I couldn't possibly choose",
                              @"It was great to speak with you!",
                              @"The pleasure was all mine! Have fun!"];
    }
    return self;
}

#pragma mark - - 开始会话
- (void)beginConversation {
    for (NSUInteger i = 0; i < self.speechStringsArr.count; i++) {
        AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:self.speechStringsArr[i]];
        utterance.voice = self.voicesArr[i % 2];
        utterance.rate = 0.4f;
        utterance.pitchMultiplier = 0.8f;
        utterance.postUtteranceDelay = 0.1f;
        [self.synthesizer speakUtterance:utterance];
    }
}

@end
