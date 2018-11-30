//
//  MVVMViewModel.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/30.
//  Copyright © 2018 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MVVMModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MVVMViewModel : NSObject

/// 数据模型
@property (nonatomic, readwrite, strong) MVVMModel *model;


/**
 请求数据

 @param success 成功回调
 */
- (void)requestDataSuccess:(void(^)(MVVMViewModel *viewModel))success;


/**
 上传数据
 */
- (void)upLoadData;


@end

NS_ASSUME_NONNULL_END
