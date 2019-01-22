//
//  THRecorderController.m
//  YMOCCodeStandard
//
//  Created by iOS on 2019/1/17.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "THRecorderController.h"
#import "PlayAndRecordAudioViewController.h"

@interface THRecorderController ()
<AVAudioRecorderDelegate>

@property (nonatomic, readwrite, strong) AVAudioPlayer *player;
@property (nonatomic, readwrite, strong) AVAudioRecorder *recorder;
@property (nonatomic, readwrite, copy) THRecorderStopCompletionHandler completionHander;

@end

@implementation THRecorderController

- (instancetype)init {
    if (self = [super init]) {
        NSString *tmpDir = NSTemporaryDirectory();
        NSString *filePath = [tmpDir stringByAppendingPathComponent:tmpDir];
        NSURL *fileURL = [NSURL fileURLWithPath:filePath];
        
        NSDictionary *settings = @{AVFormatIDKey : @(kAudioFormatAppleIMA4),
                                   AVSampleRateKey : @44100.0f,
                                   AVNumberOfChannelsKey : @1,
                                   AVEncoderBitDepthHintKey : @16,
                                   AVEncoderAudioQualityKey : @(AVAudioQualityMedium)
                                   };
        
        NSError *error;
        self.recorder = [[AVAudioRecorder alloc] initWithURL:fileURL settings:settings error:&error];
        
        if (self.recorder) {
            self.recorder.delegate = self;
            [self.recorder prepareToRecord];
        } else {
            NSLog(@"Error : %@", [error localizedDescription]);
        }
    }
    return self;
}

- (BOOL)record {
    return [self.recorder record];
}

- (void)pause {
    [self.recorder pause];
}

- (void)stopWithCompletionHandler:(THRecorderStopCompletionHandler)handler {
    _completionHander = handler;
    [self.recorder stop];
}

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {
    if (self.completionHander) {
        self.completionHander(flag);
    }
}

- (void)saveRecordingWithName:(NSString *)name completionHandler:(THRecorderSaveCompletionHandler)handler {
    NSTimeInterval timestamp = [NSDate timeIntervalSinceReferenceDate];
    NSString *fileName = [NSString stringWithFormat:@"%@-%f.caf", name, timestamp];
    NSString *docsDir = [self documentsDirectory];
    NSString *destPath = [docsDir stringByAppendingPathComponent:fileName];
    
    NSURL *srcURL = self.recorder.url;
    NSURL *destURL = [NSURL fileURLWithPath:destPath];
    NSError *error;
    BOOL success = [[NSFileManager defaultManager] copyItemAtURL:srcURL toURL:destURL error:&error];
    
    if (success) {
        handler(YES, [PlayAndRecordAudioViewController memoWithTitle:name URL:destURL]);
        [self.recorder prepareToRecord];
    } else {
        handler(NO, error);
    }
}

- (NSString *)documentsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths firstObject];
}

- (BOOL)playbackMemo:(PlayAndRecordAudioViewController *)memo {
    [self.player stop];
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:memo.url error:nil];

    if (self.player) {
        [self.player play];
        return YES;
    }
    return NO;
}

- (NSString *)formattedCurrentTime {
    NSUInteger time = (NSUInteger)self.recorder.currentTime;
    NSInteger hours = (time / 3600);
    NSInteger minutes = (time / 60) % 60;
    NSInteger seconds = time % 60;
    NSString *format = @"%02i:%02i:%02i";
    return [NSString stringWithFormat:format, hours, minutes, seconds];
}

@end
