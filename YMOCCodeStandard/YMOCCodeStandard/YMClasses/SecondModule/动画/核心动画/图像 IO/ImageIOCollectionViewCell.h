//
//  ImageIOCollectionViewCell.h
//  YMOCCodeStandard
//
//  Created by iOS on 2019/1/11.
//  Copyright © 2019 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageIOCollectionViewCell : UICollectionViewCell

/// 图片
@property (nonatomic, readwrite, strong) YMHighlightImageView *imageV;

@end

NS_ASSUME_NONNULL_END
