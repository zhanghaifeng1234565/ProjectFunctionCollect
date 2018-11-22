//
//  MJRefreshHeader+YMRefreshHeader.h
//  YMOAManageSystem
//
//  Created by iOS on 2018/11/20.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "MJRefreshHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface MJRefreshHeader (YMRefreshHeader)

/** 导航是否透明 只在 iPhone X 以后有用 */
@property (nonatomic, assign) BOOL ym_navigationIsTransparent;

@end

NS_ASSUME_NONNULL_END
