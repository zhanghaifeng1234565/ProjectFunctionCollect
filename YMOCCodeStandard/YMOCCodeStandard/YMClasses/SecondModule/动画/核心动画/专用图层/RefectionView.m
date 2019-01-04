//
//  RefectionView.m
//  YMOCCodeStandard
//
//  Created by iOS on 2019/1/3.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "RefectionView.h"

@implementation RefectionView

+ (Class)layerClass {
    return [CAReplicatorLayer class];
}

- (void)setUp {
    CAReplicatorLayer *layer = [CAReplicatorLayer layer];
    layer.repeatCount = 2;
    
    CATransform3D transfrom = CATransform3DIdentity;
    CGFloat verticalOffset = self.bounds.size.height + 2;
    transfrom = CATransform3DTranslate(transfrom, 0, verticalOffset, 0);
    transfrom = CATransform3DScale(transfrom, 1, -1, 0);
    layer.instanceTransform = transfrom;
    
    layer.instanceAlphaOffset = -0.6;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setUp];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self setUp];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
