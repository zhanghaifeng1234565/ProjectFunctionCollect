//
//  TimeWeakTarget.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/12/25.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "TimeWeakTarget.h"

@implementation TimeWeakTarget

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      target:(id)aTarget
                                    selector:(SEL)aSelector
                                    userInfo:(id)userInfo
                                     repeats:(BOOL)repeats{
    
    TimeWeakTarget * timer = [TimeWeakTarget new];
    timer.target = aTarget;
    timer.selector = aSelector;
    //-------------------------------------------------------------此处的target已经被换掉了不是原来的VIewController而是TimerWeakTarget类的对象timer
    timer.timer = [NSTimer scheduledTimerWithTimeInterval:interval target:timer selector:@selector(fire:) userInfo:userInfo repeats:repeats];
    return timer.timer;
}

- (void)fire:(NSTimer *)timer {
    if (self.target) {
        [self.target performSelector:self.selector withObject:timer.userInfo];
    } else {
        [self.timer invalidate];
    }
}

@end
