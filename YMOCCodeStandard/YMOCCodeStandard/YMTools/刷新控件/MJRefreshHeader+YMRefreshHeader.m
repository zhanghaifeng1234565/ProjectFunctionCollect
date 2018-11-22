//
//  MJRefreshHeader+YMRefreshHeader.m
//  YMOAManageSystem
//
//  Created by iOS on 2018/11/20.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "MJRefreshHeader+YMRefreshHeader.h"
#import <objc/runtime.h>

@implementation MJRefreshHeader (YMRefreshHeader)

- (BOOL)ym_navigationIsTransparent {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setYm_navigationIsTransparent:(BOOL)navigationIsTransparent {
    objc_setAssociatedObject(self, @selector(ym_navigationIsTransparent), @(navigationIsTransparent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
