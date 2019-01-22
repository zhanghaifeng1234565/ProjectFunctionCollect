//
//  PlayAndRecordAudioViewController.m
//  YMOCCodeStandard
//
//  Created by iOS on 2019/1/15.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "PlayAndRecordAudioViewController.h"

@interface PlayAndRecordAudioViewController ()

/// 音频播放器
@property (nonatomic, readwrite, strong) AVAudioPlayer *player;
/// 音频录制
@property (nonatomic, readwrite, strong) AVAudioRecorder *recorder;

@end

@implementation PlayAndRecordAudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"播放和录制音频";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self palyAudio];
    
    NSString *str = @"({[)]})";
    BOOL isRight = [self isCorrectExpression:str];
    if (isRight) {
        NSLog(@"符合规则");
    } else {
        NSLog(@"不符合规则");
    }
}

#pragma mark 播放音频
- (void)palyAudio {
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"BEYOND - 海阔天空 (KTV版伴奏)" withExtension:@"mp3"];
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
    if (self.player) {
        [self.player prepareToPlay];
    }
}

#pragma mark 录制音频
- (void)recorderAudio {
    NSString *directory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [directory stringByAppendingPathComponent:directory];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    
    NSDictionary *settings = @{AVFormatIDKey : @(kAudioFormatMPEG4AAC),
                               AVSampleRateKey : @22050.0f,
                               AVNumberOfChannelsKey : @1};
    
    NSError *error;
    self.recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
    if (self.recorder) {
        [self.recorder prepareToRecord];
    } else {
        // error
    }
}

- (BOOL)isCorrectExpression:(NSString *)exp {
    
    NSLog(@"%@", exp);
    
    NSMutableArray *arr = @[].mutableCopy;
    
    for (int i = 0; i < exp.length; i++) {
        NSString *str = [exp substringWithRange:NSMakeRange(i, 1)];
        NSLog(@"%@", [exp substringWithRange:NSMakeRange(i, 1)]);
        
        if (!arr.count) {
            [arr addObject:str];
        } else {
            if ([self isSuccessWithOneStr:arr.lastObject two:str]) {
                [arr removeLastObject];
            } else {
                [arr addObject:str];
            }
        }
    }
    
    if (!arr.count) {
        return YES;
    }
    
    return NO;
}


- (BOOL)isSuccessWithOneStr:(NSString *)one two:(NSString *)two  {
    if ([one isEqualToString:@"{"] && [two isEqualToString:@"}"]) {
        return YES;
    } else if ([one isEqualToString:@"["] && [two isEqualToString:@"]"]) {
        return YES;
    } else if ([one isEqualToString:@"("] && [two isEqualToString:@")"]) {
        return YES;
    }
    return NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
