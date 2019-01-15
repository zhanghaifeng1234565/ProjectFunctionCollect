//
//  THPlayerController.m
//  YMOCCodeStandard
//
//  Created by iOS on 2019/1/15.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "THPlayerController.h"

@interface THPlayerController ()

@property (nonatomic, readwrite, assign) BOOL playing;
@property (nonatomic, readwrite, strong) NSArray *playersArr;

@end


@implementation THPlayerController

- (instancetype)init {
    if (self = [super init]) {
        AVAudioPlayer *guitarPlayer = [self playerForFile:@"guitar"];
        AVAudioPlayer *bassPlayer = [self playerForFile:@"bass"];
        AVAudioPlayer *drumsPlayer = [self playerForFile:@"drums"];
        _playersArr = @[guitarPlayer, bassPlayer, drumsPlayer];
    }
    return self;
}

- (AVAudioPlayer *)playerForFile:(NSString *)name {
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:name withExtension:@"caf"];
    NSError *error;
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:&error];
    if (player) {
        player.numberOfLoops = -1;
        player.enableRate = YES;
        [player prepareToPlay];
    } else {
        NSLog(@"Error creating player: %@", [error localizedDescription]);
    }
    return player;
}

- (void)play {
    if (!self.playing) {
        NSTimeInterval delayTime = [self.playersArr[0] deviceCurrentTime] + 0.01;
        for (AVAudioPlayer *player in self.playersArr) {
            [player playAtTime:delayTime];
        }
        self.playing = YES;
    }
}

- (void)stop {
    if (self.playing) {
        for (AVAudioPlayer *player in self.playersArr) {
            [player stop];
            player.currentTime = 0.0f;
        }
        self.playing = NO;
    }
}

- (void)adjustRate:(float)rate {
    for (AVAudioPlayer *player in self.playersArr) {
        [player stop];
        player.rate = rate;
    }
}

- (void)adjustPan:(float)pan forPlayerAtIndex:(NSUInteger)index {
    if ([self isValidIndex:index]) {
        AVAudioPlayer *player = self.playersArr[index];
        player.pan = pan;
    }
}

- (void)adjustVolume:(float)volume forPlayerAtIndex:(NSUInteger)index {
    if ([self isValidIndex:index]) {
        AVAudioPlayer *player = self.playersArr[index];
        player.volume = volume;
    }
}

- (BOOL)isValidIndex:(NSUInteger)index {
    return index == 0 || index < self.playersArr.count;
}

@end
