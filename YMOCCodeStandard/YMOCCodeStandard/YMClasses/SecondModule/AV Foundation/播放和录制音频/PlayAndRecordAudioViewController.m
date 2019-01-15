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

@end

@implementation PlayAndRecordAudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"播放和录制音频";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self palyAudio];
}

#pragma mark 播放音频
- (void)palyAudio {
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"BEYOND - 海阔天空 (KTV版伴奏)" withExtension:@"mp3"];
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
    if (self.player) {
        [self.player prepareToPlay];
    }
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
