//
//  THRecorderController.h
//  YMOCCodeStandard
//
//  Created by iOS on 2019/1/17.
//  Copyright © 2019 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^THRecorderStopCompletionHandler)(BOOL);
typedef void(^THRecorderSaveCompletionHandler)(BOOL, id);

@class PlayAndRecordAudioViewController;
/// 音频录制
@interface THRecorderController : NSObject

@property (nonatomic, readonly, copy) NSString *formattedCurrentTime;


- (BOOL)record;
- (void)pause;
- (void)stopWithCompletionHandler:(THRecorderStopCompletionHandler)handler;
- (void)saveRecordingWithName:(NSString *)name completionHandler:(THRecorderSaveCompletionHandler)handler;

- (BOOL)playbackMemo:(PlayAndRecordAudioViewController *)memo;
@end

NS_ASSUME_NONNULL_END
