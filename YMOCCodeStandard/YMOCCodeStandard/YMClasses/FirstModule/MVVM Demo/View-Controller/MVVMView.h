//
//  MVVMView.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/30.
//  Copyright © 2018 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MVVMViewModel;
@interface MVVMView : UIView

/// viewModel
@property (nonatomic, readwrite, strong) MVVMViewModel *viewModel;

@end

NS_ASSUME_NONNULL_END
