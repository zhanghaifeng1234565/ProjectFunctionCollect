//
//  MVVMViewModel.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/30.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "MVVMViewModel.h"

@interface MVVMViewModel ()

@end

@implementation MVVMViewModel

#pragma mark - - 请求数据
- (void)requestDataSuccess:(void (^)(MVVMViewModel * _Nonnull))success {
    NSDictionary *dict = @{@"textFieldStr" : @"67890", @"labelStr" : @"12345"};
    
    MVVMModel *model = [MVVMModel yy_modelWithJSON:dict];
    self.model = model;
    success(self);
}

#pragma mark - - 上传数据
- (void)upLoadData {
    NSLog(@"textFieldStr=%@ --- labelStr=%@", self.model.textFieldStr, self.model.labelStr);
}

@end
