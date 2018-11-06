//
//  YMPictureTestCollectionViewCell.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/5.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMPictureTestCollectionViewCell.h"

@implementation YMPictureTestCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"YMPictureTestCollectionViewCell" owner:nil options:nil] firstObject];
        self.imageV.layer.masksToBounds = YES;
        self.imageV.layer.cornerRadius = 3.0f;
    }
    return self;
}

@end
