//
//  YMUIConstumButton.m
//  YMUICommonlyUsedTools
//
//  Created by iOS on 2018/5/8.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMUIConstumButton.h"

@interface YMUIConstumButton ()

/** 按钮类型 */
@property (nonatomic, assign) YMUIConstumButtonType type;
/** 图片宽度 */
@property (nonatomic, assign) CGFloat imgWidth;
/** 图片高度 */
@property (nonatomic, assign) CGFloat imgHeight;
/** 文字宽度 */
@property (nonatomic, assign) CGFloat titleWidth;
/** 文字高度 */
@property (nonatomic, assign) CGFloat titleHeight;

@end

@implementation YMUIConstumButton

#pragma mark -- init
- (instancetype)initWithFrame:(CGRect)frame buttonType:(YMUIConstumButtonType)type
{
    if (self = [super initWithFrame:frame]) {
        self.type = type;
        [self setUpUI];
    }
    return self;
}
#pragma mark -- 创建视图
- (void)setUpUI
{
    // 图片
    [self addSubview:self.CBImageView];
    // 标签
    [self addSubview:self.CBTitleLabel];
    // 布局
    [self layoutSubViews];
}
#pragma mark -- 布局
- (void)layoutSubViews
{
    switch (self.type) {
        case YMUIConstumButtonTypeNormal:
        {
            _imgWidth = self.frame.size.height-10;
            _imgHeight = _imgWidth;
            _titleWidth = self.frame.size.width-15-_imgWidth;
            _titleHeight = self.frame.size.height;
            self.CBImageView.frame = CGRectMake(5, 5, _imgWidth, _imgHeight);
            self.CBTitleLabel.frame = CGRectMake(_imgWidth, 0, _titleWidth, _titleHeight);
        }
            break;
        case YMUIConstumButtonTypeRight:
        {
            _imgWidth = self.frame.size.height-10;
            _imgHeight = _imgWidth;
            _titleWidth = self.frame.size.width-15-_imgWidth;
            _titleHeight = self.frame.size.height;
            self.CBImageView.frame = CGRectMake(_titleWidth+5, 5, _imgWidth, _imgHeight);
            self.CBTitleLabel.frame = CGRectMake(5, 0, _titleWidth, _titleHeight);
        }
            break;
        case YMUIConstumButtonTypeTop:
        {
            _titleWidth = self.frame.size.width-10;
            _titleHeight = 18;
            _imgWidth = self.frame.size.height-_titleHeight-15;
            _imgHeight = _imgWidth;
            self.CBImageView.frame = CGRectMake((self.frame.size.width-_imgWidth)/2, 5, _imgWidth, _imgHeight);
            self.CBTitleLabel.frame = CGRectMake(5, self.frame.size.height-_titleHeight-5, _titleWidth, _titleHeight);
        }
            break;
        case YMUIConstumButtonTypeBottom:
        {
            _titleWidth = self.frame.size.width-10;
            _titleHeight = 18;
            _imgWidth = self.frame.size.height-_titleHeight-15;
            _imgHeight = _imgWidth;
            self.CBImageView.frame = CGRectMake((self.frame.size.width-_imgWidth)/2, 10+_titleHeight, _imgWidth, _imgHeight);
            self.CBTitleLabel.frame = CGRectMake(5, 0, _titleWidth, _titleHeight);
        }
            break;
        default:
            break;
    }
}
#pragma mark -- 控件高亮方法
- (void)setHighlighted:(BOOL)highlighted
{
    if (highlighted==YES) {
        self.backgroundColor = [UIColor blueColor];
    } else {
        self.backgroundColor = [UIColor redColor];
    }
}
#pragma mark -- getter
- (UIImageView *)CBImageView
{
    if (_CBImageView==nil) {
        _CBImageView = [[UIImageView alloc] init];
    }
    return _CBImageView;
}

- (UILabel *)CBTitleLabel
{
    if (_CBTitleLabel==nil) {
        _CBTitleLabel = [[UILabel alloc] init];
    }
    return _CBTitleLabel;
}
@end
