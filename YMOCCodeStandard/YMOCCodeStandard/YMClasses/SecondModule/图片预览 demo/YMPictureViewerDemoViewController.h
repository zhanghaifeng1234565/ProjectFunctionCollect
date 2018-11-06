//
//  YMPictureViewerDemoViewController.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/5.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface YMPictureViewerDemoViewController : YMBaseViewController

/** 图片的类型 1 是本地图片 否则 是网络图片 */
@property (nonatomic, copy) NSString *imageType;

/** 是否是 collectionView 1 不是 否则 UIView */
@property (nonatomic, copy) NSString *isCollectionView;
@end

NS_ASSUME_NONNULL_END
