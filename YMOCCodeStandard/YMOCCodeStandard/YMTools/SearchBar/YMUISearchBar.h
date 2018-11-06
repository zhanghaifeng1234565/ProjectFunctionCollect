//
//  YMUISearchBar.h
//  YMUICommonlyUsedTools
//
//  Created by iOS on 2018/5/25.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YMUISearchBar : UISearchBar

/** 搜索按钮点击回到 */
@property (nonatomic, copy) void(^ymUISearchBarSearchBtnActionBlock)(NSString *text);

/** 改变为空文本是调用 */
@property (nonatomic, copy) void(^ymUISearchBarEmptyTextBlock)(void);

/** 占位文字颜色 */
@property (nonatomic, copy) NSString *placeholderColor;
/** 占位文字大小 */
@property (nonatomic, assign) CGFloat placeholderFont;
/** 文字大小 */
@property (nonatomic, assign) CGFloat textFont;
/** 文字颜色 */
@property (nonatomic, copy) NSString *textColor;
/** 输入框背景颜色 */
@property (nonatomic, copy) NSString *backgroundColor;
/** 背景图片颜色 */
@property (nonatomic, strong) UIImage *baseBackgroundImage;
/** 输入框距背景顶部间距 */
@property (nonatomic, assign) CGFloat topMargin;
/** 输入框距背景左边间距 */
@property (nonatomic, assign) CGFloat leftMargin;
/** 搜索图片和文字间隙 */
@property (nonatomic, assign) CGFloat iconSpacing;
/** 输入框圆角 */
@property (nonatomic, assign) CGFloat tfCornerRadius;
/** 左侧放大镜 */
@property (nonatomic, strong) UIImageView *tfLeftView;
/** 清除按钮图片 */
@property (nonatomic, copy) NSString *clearImage;

@end
