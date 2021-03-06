//
//  PlayAndRecordAudioViewController.h
//  YMOCCodeStandard
//
//  Created by iOS on 2019/1/15.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "YMBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
/// 播放和录制音频
@interface PlayAndRecordAudioViewController : YMBaseViewController


@property (nonatomic, readwrite, strong) NSURL *url;
+ (id)memoWithTitle:(NSString *)name URL:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
