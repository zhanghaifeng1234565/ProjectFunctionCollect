//
//  YMLoadingView.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/9/17.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YMLoadingView : UIView

/** 标题 */
@property (nonatomic, strong) UILabel *titleLabel;
/** 内容描述 */
@property (nonatomic, strong) UILabel *contentLabel;
/** 点击按钮 */
@property (nonatomic, strong) UIButton *clickBtn;

/** 是否网络加载失败 赋值为 YES 网络加载失败 NO 其他 */
@property (nonatomic, assign, getter=isLoadNetFail) BOOL loadNetFail;
/** 加载失败状态 */
@property (nonatomic, assign, getter=isLoadFailStatus) BOOL loadFailStatus;

@end
