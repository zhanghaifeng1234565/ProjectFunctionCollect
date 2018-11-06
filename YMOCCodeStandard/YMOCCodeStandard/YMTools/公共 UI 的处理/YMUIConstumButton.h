//
//  YMUIConstumButton.h
//  YMUICommonlyUsedTools
//
//  Created by iOS on 2018/5/8.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,YMUIConstumButtonType) {
    /** 默认图片在左边 */
    YMUIConstumButtonTypeNormal = 0,
    /** 默认图片在右边 */
    YMUIConstumButtonTypeRight = 1,
    /** 默认图片在上边 */
    YMUIConstumButtonTypeTop = 2,
    /** 默认图片在下边 */
    YMUIConstumButtonTypeBottom = 3,
};

@interface YMUIConstumButton : UIControl

/** 按钮图片 */
@property (nonatomic, strong) UIImageView *CBImageView;
/** 按钮标签 */
@property (nonatomic, strong) UILabel *CBTitleLabel;

- (instancetype)initWithFrame:(CGRect)frame buttonType:(YMUIConstumButtonType)type;

@end
