//
//  ChangeView.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/12/29.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "ChangeView.h"

@implementation ChangeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.label];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.label.frame = CGRectMake(0, 0, self.width, self.height);
}


#pragma mark - - lazyLoadUI
- (UILabel *)label {
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        _label.font = [UIFont boldSystemFontOfSize:30];
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
