//
//  THPlayerController.h
//  YMOCCodeStandard
//
//  Created by iOS on 2019/1/15.
//  Copyright © 2019 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class THPlayerController;
@protocol THPlayerControllerDelegate <NSObject>

- (void)palybackStopped;
- (void)playbackBegan;

@end

@interface THPlayerController : NSObject

/// 播放
@property (nonatomic, readonly, assign, getter=isPlaying) BOOL playing;

- (void)play;
- (void)stop;
- (void)adjustRate:(float)rate;

- (void)adjustPan:(float)pan forPlayerAtIndex:(NSUInteger)index;
- (void)adjustVolume:(float)volume forPlayerAtIndex:(NSUInteger)index;

@property (nonatomic, readwrite, weak) id<THPlayerControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
