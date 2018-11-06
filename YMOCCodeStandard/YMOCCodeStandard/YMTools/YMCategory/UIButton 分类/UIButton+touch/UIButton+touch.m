//
//  UIButton+touch.m
//  LiqForDoctors
//
//  Created by StriEver on 16/3/10.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import "UIButton+touch.h"
#import <objc/runtime.h>

@interface UIButton()

/** bool 类型 设置是否执行点UI方法 */
@property (nonatomic, assign) BOOL ym_isIgnoreEvent;

@end

@implementation UIButton (touch)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL selA = @selector(sendAction:to:forEvent:);
        SEL selB = @selector(mySendAction:to:forEvent:);
        Method methodA =   class_getInstanceMethod(self,selA);
        Method methodB = class_getInstanceMethod(self, selB);
       BOOL isAdd = class_addMethod(self, selA, method_getImplementation(methodB), method_getTypeEncoding(methodB));
        if (isAdd) {
            class_replaceMethod(self, selB, method_getImplementation(methodA), method_getTypeEncoding(methodA));
        } else {
            method_exchangeImplementations(methodA, methodB);
        }
    });
}

- (NSTimeInterval)ym_timeInterval {
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}

- (void)setYm_timeInterval:(NSTimeInterval)ym_timeInterval {
    objc_setAssociatedObject(self, @selector(ym_timeInterval), @(ym_timeInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)mySendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if ([NSStringFromClass(self.class) isEqualToString:@"UIButton"]) {
        if (self.ym_isIgnoreEvent == 0) {
            self.ym_timeInterval = defaultInterval;
        };
        
        if (self.ym_isIgnoreEvent) {
            return;
        }
        
        if (self.ym_timeInterval > 0) {
            self.ym_isIgnoreEvent = YES;
            [self performSelector:@selector(setYm_isIgnoreEvent:) withObject:@(NO) afterDelay:self.ym_timeInterval];
        }
    }
    [self mySendAction:action to:target forEvent:event];
}

- (BOOL)ym_isIgnoreEvent{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setYm_isIgnoreEvent:(BOOL)ym_isIgnoreEvent {
    objc_setAssociatedObject(self, @selector(ym_isIgnoreEvent), @(ym_isIgnoreEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
