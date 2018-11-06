//
//  YMOrganizationViewModel.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/10/30.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMOrganizationViewModel.h"
#import "YMOrganizationModel.h"

#import "YMMBProgressHUD.h"

@implementation YMOrganizationViewModel

#pragma mark - - 请求组织架构数据
+ (void)obtainOrganizationDataOnTheView:(UIView *)view success:(void (^)(id _Nonnull))success {
    // 基于 HUD loading 无文字
    [YMMBProgressHUD ymShowCustomLoadingAlert:view text:@""];
    NSDate *currentDate = [NSDate date];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 人员
        NSMutableArray *staffMArr = [[NSMutableArray alloc] init];
        for (int i = 0; i < 5; i++) {
            NSMutableDictionary *staffMDict = [[NSMutableDictionary alloc] init];
            [staffMDict setObject:[NSString stringWithFormat:@"张%d", i + 1] forKey:@"name"];
            [staffMDict setObject:@(i + 1).description forKey:@"nameId"];
            [staffMDict setObject:@"0" forKey:@"isSelect"];
            [staffMDict setObject:@"0" forKey:@"isShow"];
            [staffMArr addObject:staffMDict];
        }
        
        // 岗位
        NSMutableArray *postMArr = [[NSMutableArray alloc] init];
        for (int i = 0; i < 3; i++) {
            NSMutableDictionary *postMDict = [[NSMutableDictionary alloc] init];
            [postMDict setObject:[NSString stringWithFormat:@"开发%d", i + 1] forKey:@"name"];
            [postMDict setObject:@(i + 1).description forKey:@"nameId"];
            [postMDict setObject:@"0" forKey:@"isSelect"];
            [postMDict setObject:@"0" forKey:@"isShow"];
            [postMDict setObject:staffMArr forKey:@"staffList"];
            [postMArr addObject:postMDict];
        }

        // 部门
        NSMutableArray *departmentMArr = [[NSMutableArray alloc] init];
        for (int i = 0; i < 2; i++) {
            NSMutableDictionary *departmentMDict = [[NSMutableDictionary alloc] init];
            [departmentMDict setObject:[NSString stringWithFormat:@"第%d部门", i + 1] forKey:@"name"];
            [departmentMDict setObject:@(i + 1).description forKey:@"nameId"];
            [departmentMDict setObject:@"0" forKey:@"isSelect"];
            [departmentMDict setObject:@"0" forKey:@"isShow"];
            [departmentMDict setObject:postMArr forKey:@"postList"];
            [departmentMArr addObject:departmentMDict];
        }
        
        // 公司
        NSMutableArray *companyMArr = [[NSMutableArray alloc] init];
        for (int i = 0; i < 3; i++) {
            NSMutableDictionary *companyMDict = [[NSMutableDictionary alloc] init];
            [companyMDict setObject:[NSString stringWithFormat:@"第%d分公司", i + 1] forKey:@"name"];
            [companyMDict setObject:@(i + 1).description forKey:@"nameId"];
            [companyMDict setObject:@"0" forKey:@"isSelect"];
            [companyMDict setObject:@"0" forKey:@"isShow"];
            [companyMDict setObject:departmentMArr forKey:@"departmentList"];
            [companyMArr addObject:companyMDict];
        }
        NSDictionary *result = @{@"status" : @"1", @"msg" : @"请求成", @"time" : @"2018-10-26", @"companyList" : companyMArr};
        
        NSLog(@"result = %@", result);
        dispatch_async(dispatch_get_main_queue(), ^{
            double deltaTime = [[NSDate date] timeIntervalSinceDate:currentDate];
            NSLog(@"data>>>>>>>>>>cost time = %f s", deltaTime);
            [YMMBProgressHUD ymHideLoadingAlert:view];
            success(result);
        });
    });
}

#pragma mark -- 对模型进行 所有员工标识是否被选中
+ (void)dealStaffSelectStatusMArr:(NSMutableArray *)staffMArr model:(YMOrganizationModel *)model {
    if (staffMArr.count > 0) {
        for (int i = 0; i < model.companyList.count; i++) {
            for (int j = 0; j < model.companyList[i].departmentList.count; j++) {
                for (int k = 0; k < model.companyList[i].departmentList[j].postList.count; k++) {
                    for (int m = 0; m < model.companyList[i].departmentList[j].postList[k].staffList.count; m++) {
                        for (NSDictionary *dict in staffMArr) {
                            NSString *nameId = dict[@"nameId"];
                            if ([nameId isEqualToString:model.companyList[i].departmentList[j].postList[k].staffList[m].nameId]) {
                                model.companyList[i].departmentList[j].postList[k].staffList[m].isSelect = dict[@"isSelect"];
                            }
                        }
                    }
                }
            }
        }
    }
}

#pragma mark -- 获取所有员工被选中数组【状态为 1 可修改的被选中 2 不可修改的被选中】
+ (NSMutableArray *)obtainSelectStaffModel:(YMOrganizationModel *)model {
    NSMutableArray *staffMArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < model.companyList.count; i++) {
        for (int j = 0; j < model.companyList[i].departmentList.count; j++) {
            for (int k = 0; k < model.companyList[i].departmentList[j].postList.count; k++) {
                for (int m = 0; m < model.companyList[i].departmentList[j].postList[k].staffList.count; m++) {
                    if (![model.companyList[i].departmentList[j].postList[k].staffList[m].isSelect isEqualToString:@"0"]) {
                        [staffMArr addObject:model.companyList[i].departmentList[j].postList[k].staffList[m]];
                    }
                }
            }
        }
    }
    return staffMArr;
}

#pragma mark -- 获取员工被选中数组【状态为 1 可修改的被选中】
+ (NSMutableArray *)obtainSelectStaffOnlyChangeModel:(YMOrganizationModel *)model {
    NSMutableArray *staffMArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < model.companyList.count; i++) {
        for (int j = 0; j < model.companyList[i].departmentList.count; j++) {
            for (int k = 0; k < model.companyList[i].departmentList[j].postList.count; k++) {
                for (int m = 0; m < model.companyList[i].departmentList[j].postList[k].staffList.count; m++) {
                    if ([model.companyList[i].departmentList[j].postList[k].staffList[m].isSelect isEqualToString:@"1"]) {
                        [staffMArr addObject:model.companyList[i].departmentList[j].postList[k].staffList[m]];
                    }
                }
            }
        }
    }
    return staffMArr;
}

#pragma mark -- 对模型进行 所有员工标识是否被选中
+ (void)dealStaffSelectStatusModelMArr:(NSMutableArray *)staffMArr model:(YMOrganizationModel *)model {
    if (staffMArr.count > 0) {
        for (int i = 0; i < model.companyList.count; i++) {
            for (int j = 0; j < model.companyList[i].departmentList.count; j++) {
                for (int k = 0; k < model.companyList[i].departmentList[j].postList.count; k++) {
                    for (int m = 0; m < model.companyList[i].departmentList[j].postList[k].staffList.count; m++) {
                        for (int l = 0; l < staffMArr.count; l++) {
                            YMOrganizationStaffModel *staffModel = staffMArr[l];
                            if ([model.companyList[i].departmentList[j].postList[k].staffList[m].nameId isEqualToString:staffModel.nameId]) {
                                model.companyList[i].departmentList[j].postList[k].staffList[m].isSelect = staffModel.isSelect;
                            }
                        }
                    }
                }
            }
        }
    }
}

#pragma mark -- 创建一个员工模型模拟点击员工选中按钮来更新列表选中效果。
+ (void)createChangeModel:(YMOrganizationModel *)model {
    NSString *staffBelong = [NSString stringWithFormat:@"%@-%@-%@", model.companyList[0].nameId, model.companyList[0].departmentList[0].nameId, model.companyList[0].departmentList[0].postList[0].nameId];
    YMOrganizationGeneralPurposeModel *generalModel = [YMOrganizationGeneralPurposeModel new];
    generalModel.name = model.companyList[0].departmentList[0].postList[0].staffList[0].name;
    generalModel.nameId = model.companyList[0].departmentList[0].postList[0].staffList[0].nameId;
    generalModel.isShow = model.companyList[0].departmentList[0].postList[0].staffList[0].isShow;
    generalModel.isSelect = model.companyList[0].departmentList[0].postList[0].staffList[0].isSelect;
    generalModel.type = @"3";
    generalModel.belong = staffBelong;
    [self selectStaff:generalModel model:model];
}

#pragma mark - - 更新数据
+ (NSMutableArray *)updateDataWithModel:(YMOrganizationModel *)model {
    NSMutableArray *dataMarr = [[NSMutableArray alloc] init];
    NSDate *currentDate = [NSDate date];
    // MARK: 将所有公司下的部门 部门下的所有岗位 岗位下的所有员工 的多位数组 展开成一个二位数组 第一层为公司，第二层为部门和岗位和员工
    for (int i = 0; i < model.companyList.count; i++) {
        NSMutableArray *detailMarr = [[NSMutableArray alloc] init];
        if ([model.companyList[i].isShow isEqualToString:@"1"]) {
            for (int j = 0; j < model.companyList[i].departmentList.count; j++) {
                // MARK: 这一层拿到所有部门，将所有部门装在模型中
                NSString *departmentBelong = [NSString stringWithFormat:@"%@", model.companyList[i].nameId];
                YMOrganizationGeneralPurposeModel *departmentModel = [self addNewModelWithName:model.companyList[i].departmentList[j].name nameId:model.companyList[i].departmentList[j].nameId isShow:model.companyList[i].departmentList[j].isShow isSelect:model.companyList[i].departmentList[j].isSelect type:@"1" belong:departmentBelong isLastLevel:(model.companyList[i].departmentList[j].postList.count > 0 ? @"0" : @"1")];
                [detailMarr addObject:departmentModel];
                if ([departmentModel.isShow isEqualToString:@"1"]) {
                    // MARK: 当被标记为展开时，添加元素
                    for (int k = 0; k < model.companyList[i].departmentList[j].postList.count; k++) {
                        // MARK: 这一层拿到所有岗位，将所有岗位装在模型中
                        NSString *postBelong = [NSString stringWithFormat:@"%@-%@", model.companyList[i].nameId, departmentModel.nameId];
                        YMOrganizationGeneralPurposeModel *postModel = [self addNewModelWithName:model.companyList[i].departmentList[j].postList[k].name nameId:model.companyList[i].departmentList[j].postList[k].nameId isShow:model.companyList[i].departmentList[j].postList[k].isShow isSelect:model.companyList[i].departmentList[j].postList[k].isSelect type:@"2" belong:postBelong isLastLevel:(model.companyList[i].departmentList[j].postList[k].staffList.count > 0 ? @"0" : @"1")];
                        [detailMarr addObject:postModel];
                        if ([postModel.isShow isEqualToString:@"1"]) {
                            // MARK: 当被标记为展开时，添加元素
                            for (int m = 0; m < model.companyList[i].departmentList[j].postList[k].staffList.count; m++) {
                                
                                // MARK: 这一层拿到所有人员，将所有人员装在模型中
                                NSString *staffBelong = [NSString stringWithFormat:@"%@-%@-%@", model.companyList[i].nameId, departmentModel.nameId, postModel.nameId];
                                YMOrganizationGeneralPurposeModel *staffModel = [self addNewModelWithName:model.companyList[i].departmentList[j].postList[k].staffList[m].name nameId:model.companyList[i].departmentList[j].postList[k].staffList[m].nameId isShow:model.companyList[i].departmentList[j].postList[k].staffList[m].isShow isSelect:model.companyList[i].departmentList[j].postList[k].staffList[m].isSelect type:@"3" belong:staffBelong isLastLevel:@"1"];
                                
                                [detailMarr addObject:staffModel];
                            }
                        }
                    }
                }
            }
        }
        [dataMarr addObject:detailMarr];
    }
    double deltaTime = [[NSDate date] timeIntervalSinceDate:currentDate];
    NSLog(@"update>>>>>>>>>>cost time = %f ms", deltaTime * 1000);
    return dataMarr.copy;
}

#pragma mark -- 数据添加到新的模型中
+ (YMOrganizationGeneralPurposeModel *)addNewModelWithName:(NSString *)name
                                                    nameId:(NSString *)nameId
                                                    isShow:(NSString *)isShow
                                                  isSelect:(NSString *)isSelect
                                                      type:(NSString *)type
                                                    belong:(NSString *)belong
                                               isLastLevel:(NSString *)lastLevel {
    YMOrganizationGeneralPurposeModel *model = [YMOrganizationGeneralPurposeModel new];
    model.name = name;
    model.nameId = nameId;
    model.isShow = isShow;
    model.isSelect = isSelect;
    model.type = type;
    model.belong = belong;
    model.isLastLevel = lastLevel;
    return model;
}

#pragma mark - - 是否所有全选 1 全选 否则不是全选
+ (void)isAllCompanySelectWithType:(NSString *)type model:(YMOrganizationModel *)model {
    for (int i = 0; i < model.companyList.count; i++) {
        if (![model.companyList[i].isSelect isEqualToString:@"2"]) {
            model.companyList[i].isSelect = type;
        }
        for (int j = 0; j < model.companyList[i].departmentList.count; j++) {
            if (![model.companyList[i].departmentList[j].isSelect isEqualToString:@"2"]) {
                model.companyList[i].departmentList[j].isSelect = type;
            }
            for (int k = 0; k < model.companyList[i].departmentList[j].postList.count; k++) {
                if (![model.companyList[i].departmentList[j].postList[k].isSelect isEqualToString:@"2"]) {
                    model.companyList[i].departmentList[j].postList[k].isSelect = type;
                }
                for (int m = 0; m < model.companyList[i].departmentList[j].postList[k].staffList.count; m++) {
                    if (![model.companyList[i].departmentList[j].postList[k].staffList[m].isSelect isEqualToString:@"2"]) {
                        model.companyList[i].departmentList[j].postList[k].staffList[m].isSelect = type;
                    }
                }
            }
        }
    }
}

#pragma mark - - 是否某个公司全选 1 全选 否则不是全选
+ (void)isCompanySelectWithType:(NSString *)type section:(int)section model:(YMOrganizationModel *)model {
    for (int i = 0; i < model.companyList.count; i++) {
        if (section == i) {
            if (![model.companyList[i].isSelect isEqualToString:@"2"]) {
                model.companyList[i].isSelect = type;
            }
            for (int j = 0; j < model.companyList[i].departmentList.count; j++) {
                if (![model.companyList[i].departmentList[j].isSelect isEqualToString:@"2"]) {
                    model.companyList[i].departmentList[j].isSelect = type;
                }
                for (int k = 0; k < model.companyList[i].departmentList[j].postList.count; k++) {
                    if (![model.companyList[i].departmentList[j].postList[k].isSelect isEqualToString:@"2"]) {
                        model.companyList[i].departmentList[j].postList[k].isSelect = type;
                    }
                    for (int m = 0; m < model.companyList[i].departmentList[j].postList[k].staffList.count; m++) {
                        if (![model.companyList[i].departmentList[j].postList[k].staffList[m].isSelect isEqualToString:@"2"]) {
                            model.companyList[i].departmentList[j].postList[k].staffList[m].isSelect = type;
                        }
                    }
                }
            }
        }
    }
}

#pragma mark - - 显示选中部门
+ (void)showDepartment:(YMOrganizationGeneralPurposeModel *)generalModel model:(YMOrganizationModel *)model {
    for (int i = 0; i < model.companyList.count; i++) {
        for (int j = 0; j < model.companyList[i].departmentList.count; j++) {
            NSString *departmentBelong = [NSString stringWithFormat:@"%@", model.companyList[i].nameId];
            if ([generalModel.belong isEqualToString:departmentBelong]
                && [generalModel.nameId isEqualToString:model.companyList[i].departmentList[j].nameId]
                ) {
                // MARK: 是这一组并且是这个部门赋值
                model.companyList[i].departmentList[j].isShow = generalModel.isShow;
            }
        }
    }
}

#pragma mark -- 显示选中岗位
+ (void)showPost:(YMOrganizationGeneralPurposeModel *)generalModel model:(YMOrganizationModel *)model {
    for (int i = 0; i < model.companyList.count; i++) {
        for (int j = 0; j < model.companyList[i].departmentList.count; j++) {
            for (int k = 0; k < model.companyList[i].departmentList[j].postList.count; k++) {
                NSString *postBelong = [NSString stringWithFormat:@"%@-%@", model.companyList[i].nameId, model.companyList[i].departmentList[j].nameId];
                if ([generalModel.belong isEqualToString:postBelong]
                    && [generalModel.nameId isEqualToString:model.companyList[i].departmentList[j].postList[k].nameId]
                    ) {
                    // MARK: 是这一组并且是这个部门并且是这个岗位赋值
                    model.companyList[i].departmentList[j].postList[k].isShow = generalModel.isShow;
                }
            }
        }
    }
}

#pragma mark - - 点击选择部门设置选中
+ (void)selectDepartment:(YMOrganizationGeneralPurposeModel *)generalModel model:(YMOrganizationModel *)model {
    int companySelectCount = 0;
    for (int i = 0; i < model.companyList.count; i++) {
        int departmentSelectCount = 0;
        int departmentNormalSelectCount = 0;
        int departmentPartSelectCount = 0;
        for (int j = 0; j < model.companyList[i].departmentList.count; j++) {
            NSString *departmentBelong = [NSString stringWithFormat:@"%@", model.companyList[i].nameId];
            if ([generalModel.belong isEqualToString:departmentBelong]
                && [generalModel.nameId isEqualToString:model.companyList[i].departmentList[j].nameId]
                ) {
                // MARK: 是这一组并且是这个部门赋值
                model.companyList[i].departmentList[j].isShow = generalModel.isShow;
                model.companyList[i].departmentList[j].isSelect = generalModel.isSelect;
                
                if ([model.companyList[i].departmentList[j].isSelect isEqualToString:@"1"]) {
                    for (int k = 0; k < model.companyList[i].departmentList[j].postList.count; k++) {
                        if (![model.companyList[i].departmentList[j].postList[k].isSelect isEqualToString:@"2"]) {
                            model.companyList[i].departmentList[j].postList[k].isSelect = @"1";
                        }
                        
                        for (int m = 0; m < model.companyList[i].departmentList[j].postList[k].staffList.count; m++) {
                            if (![model.companyList[i].departmentList[j].postList[k].staffList[m].isSelect isEqualToString:@"2"]) {
                                model.companyList[i].departmentList[j].postList[k].staffList[m].isSelect = @"1";
                            }
                        }
                    }
                } else if ([model.companyList[i].departmentList[j].isSelect isEqualToString:@"0"]) {
                    for (int k = 0; k < model.companyList[i].departmentList[j].postList.count; k++) {
                        if (![model.companyList[i].departmentList[j].postList[k].isSelect isEqualToString:@"2"]) {
                            model.companyList[i].departmentList[j].postList[k].isSelect = @"0";
                        }
                        for (int m = 0; m < model.companyList[i].departmentList[j].postList[k].staffList.count; m++) {
                            if (![model.companyList[i].departmentList[j].postList[k].staffList[m].isSelect isEqualToString:@"2"]) {
                                model.companyList[i].departmentList[j].postList[k].staffList[m].isSelect = @"0";
                            }
                            
                            if (![model.companyList[i].departmentList[j].postList[k].isSelect isEqualToString:@"2"]) {
                                model.companyList[i].departmentList[j].postList[k].isSelect = @"0";
                            }
                            
                            if (![model.companyList[i].departmentList[j].isSelect isEqualToString:@"2"]) {
                                model.companyList[i].departmentList[j].isSelect = @"0";
                            }
                            
                            if (![model.companyList[i].isSelect isEqualToString:@"2"]) {
                                model.companyList[i].isSelect = @"0";
                            }
                        }
                    }
                }
            }
            if (![model.companyList[i].departmentList[j].isSelect isEqualToString:@"0"]) {
                departmentSelectCount++;
                if ([model.companyList[i].departmentList[j].isSelect isEqualToString:@"1"]) {
                    departmentNormalSelectCount++;
                } else if ([model.companyList[i].departmentList[j].isSelect isEqualToString:@"3"]) {
                    departmentPartSelectCount++;
                }
            }
        }
        if (departmentSelectCount == model.companyList[i].departmentList.count && departmentSelectCount != 0) {
            if (departmentPartSelectCount != 0) {
                model.companyList[i].isSelect = @"3";
            } else {
                if (departmentNormalSelectCount != 0) {
                    model.companyList[i].isSelect = @"1";
                } else {
                    model.companyList[i].isSelect = @"2";
                }
            }
        } else {
            if (departmentSelectCount != 0) {
                model.companyList[i].isSelect = @"3";
            } else {
                model.companyList[i].isSelect = @"0";
            }
        }
        
        if (![model.companyList[i].isSelect isEqualToString:@"0"]) {
            companySelectCount++;
        }
    }
    if (companySelectCount == model.companyList.count) {
        NSLog(@"全选所有公司");
    }
}

#pragma mark -- 点击选中岗位
+ (void)selectPost:(YMOrganizationGeneralPurposeModel *)generalModel model:(YMOrganizationModel *)model {
    int companySelectCount = 0;
    for (int i = 0; i < model.companyList.count; i++) {
        int departmentSelectCount = 0;
        int departmentNormalSelectCount = 0;
        int departmentPartSelectCount = 0;
        for (int j = 0; j < model.companyList[i].departmentList.count; j++) {
            int postSelectCount = 0;
            int postNormalSelectCount = 0;
            int postPartSelectCount = 0;
            for (int k = 0; k < model.companyList[i].departmentList[j].postList.count; k++) {
                NSString *postBelong = [NSString stringWithFormat:@"%@-%@", model.companyList[i].nameId, model.companyList[i].departmentList[j].nameId];
                if ([generalModel.belong isEqualToString:postBelong]
                    && [generalModel.nameId isEqualToString:model.companyList[i].departmentList[j].postList[k].nameId]
                    ) {
                    // MARK: 是这一组并且是这个部门并且是这个岗位赋值
                    model.companyList[i].departmentList[j].postList[k].isShow = generalModel.isShow;
                    model.companyList[i].departmentList[j].postList[k].isSelect = generalModel.isSelect;
                    if ([model.companyList[i].departmentList[j].postList[k].isSelect isEqualToString:@"1"]) {
                        for (int m = 0; m < model.companyList[i].departmentList[j].postList[k].staffList.count; m++) {
                            if (![model.companyList[i].departmentList[j].postList[k].staffList[m].isSelect isEqualToString:@"2"]) {
                                model.companyList[i].departmentList[j].postList[k].staffList[m].isSelect = @"1";
                            }
                        }
                    } else if ([model.companyList[i].departmentList[j].postList[k].isSelect isEqualToString:@"0"]) {
                        for (int m = 0; m < model.companyList[i].departmentList[j].postList[k].staffList.count; m++) {
                            if (![model.companyList[i].departmentList[j].postList[k].staffList[m].isSelect isEqualToString:@"2"]) {
                                model.companyList[i].departmentList[j].postList[k].staffList[m].isSelect = @"0";
                            }
                            
                            if (![model.companyList[i].departmentList[j].postList[k].isSelect isEqualToString:@"2"]) {
                                model.companyList[i].departmentList[j].postList[k].isSelect = @"0";
                            }
                            
                            if (![model.companyList[i].departmentList[j].isSelect isEqualToString:@"2"]) {
                                model.companyList[i].departmentList[j].isSelect = @"0";
                            }
                            
                            if (![model.companyList[i].isSelect isEqualToString:@"2"]) {
                                model.companyList[i].isSelect = @"0";
                            }
                        }
                    }
                }
                if (![model.companyList[i].departmentList[j].postList[k].isSelect isEqualToString:@"0"]) {
                    postSelectCount++;
                    if ([model.companyList[i].departmentList[j].postList[k].isSelect isEqualToString:@"1"]) {
                        postNormalSelectCount++;
                    } else if ([model.companyList[i].departmentList[j].postList[k].isSelect isEqualToString:@"3"]) {
                        postPartSelectCount++;
                    }
                }
            }
            if (postSelectCount == model.companyList[i].departmentList[j].postList.count && postSelectCount != 0) {
                if (postPartSelectCount != 0) {
                    model.companyList[i].departmentList[j].isSelect = @"3";
                } else {
                    if (postNormalSelectCount != 0) {
                        model.companyList[i].departmentList[j].isSelect = @"1";
                    } else {
                        model.companyList[i].departmentList[j].isSelect = @"2";
                    }
                }
            } else {
                if (postSelectCount != 0) {
                    model.companyList[i].departmentList[j].isSelect = @"3";
                } else {
                    model.companyList[i].departmentList[j].isSelect = @"0";
                }
            }
            
            if (![model.companyList[i].departmentList[j].isSelect isEqualToString:@"0"]) {
                departmentSelectCount++;
                if ([model.companyList[i].departmentList[j].isSelect isEqualToString:@"1"]) {
                    departmentNormalSelectCount++;
                } else if ([model.companyList[i].departmentList[j].isSelect isEqualToString:@"3"]) {
                    departmentPartSelectCount++;
                }
            }
        }
        if (departmentSelectCount == model.companyList[i].departmentList.count && departmentSelectCount != 0) {
            if (departmentPartSelectCount != 0) {
                model.companyList[i].isSelect = @"3";
            } else {
                if (departmentNormalSelectCount != 0) {
                    model.companyList[i].isSelect = @"1";
                } else {
                    model.companyList[i].isSelect = @"2";
                }
            }
        } else {
            if (departmentSelectCount != 0) {
                model.companyList[i].isSelect = @"3";
            } else {
                model.companyList[i].isSelect = @"0";
            }
        }
        
        if (![model.companyList[i].isSelect isEqualToString:@"0"]) {
            companySelectCount++;
        }
    }
    if (companySelectCount == model.companyList.count) {
        NSLog(@"全选所有公司");
    }
}

#pragma mark -- 点击选中员工
+ (void)selectStaff:(YMOrganizationGeneralPurposeModel *)generalModel model:(YMOrganizationModel *)model {
    int companySelectCount = 0;
    for (int i = 0; i < model.companyList.count; i++) {
        int departmentSelectCount = 0;
        int departmentNormalSelectCount = 0;
        int departmentPartSelectCount = 0;
        for (int j = 0; j < model.companyList[i].departmentList.count; j++) {
            int postSelectCount = 0;
            int postNormalSelectCount = 0;
            int postPartSelectCount = 0;
            for (int k = 0; k < model.companyList[i].departmentList[j].postList.count; k++) {
                int staffSelectCount = 0;
                int staffNormalSelectCount = 0;
                for (int m = 0; m < model.companyList[i].departmentList[j].postList[k].staffList.count; m++) {
                    NSString *staffBelong = [NSString stringWithFormat:@"%@-%@-%@", model.companyList[i].nameId, model.companyList[i].departmentList[j].nameId, model.companyList[i].departmentList[j].postList[k].nameId];
                    if ([generalModel.belong isEqualToString:staffBelong]
                        && [generalModel.nameId isEqualToString:model.companyList[i].departmentList[j].postList[k].staffList[m].nameId]) {
                        // MARK: 是这一组并且是这个部门并且是这个岗位并且是这个员工赋值
                        model.companyList[i].departmentList[j].postList[k].staffList[m].isSelect = generalModel.isSelect;
                        
                        if ([model.companyList[i].departmentList[j].postList[k].staffList[m].isSelect isEqualToString:@"0"]) {
                            model.companyList[i].departmentList[j].postList[k].isSelect = generalModel.isSelect;
                            model.companyList[i].departmentList[j].isSelect = generalModel.isSelect;
                            model.companyList[i].isSelect = generalModel.isSelect;
                        }
                    }
                    
                    if (![model.companyList[i].departmentList[j].postList[k].staffList[m].isSelect isEqualToString:@"0"]) {
                        staffSelectCount++;
                        if ([model.companyList[i].departmentList[j].postList[k].staffList[m].isSelect isEqualToString:@"1"]) {
                            staffNormalSelectCount++;
                        }
                    }
                }
                
                if (staffSelectCount == model.companyList[i].departmentList[j].postList[k].staffList.count && staffSelectCount != 0) {
                    if (staffNormalSelectCount != 0) {
                        model.companyList[i].departmentList[j].postList[k].isSelect = @"1";
                    } else {
                        model.companyList[i].departmentList[j].postList[k].isSelect = @"2";
                    }
                } else {
                    if (staffSelectCount != 0) {
                        model.companyList[i].departmentList[j].postList[k].isSelect = @"3";
                    } else {
                        model.companyList[i].departmentList[j].postList[k].isSelect = @"0";
                    }
                }
                
                if (![model.companyList[i].departmentList[j].postList[k].isSelect isEqualToString:@"0"]) {
                    postSelectCount++;
                    if ([model.companyList[i].departmentList[j].postList[k].isSelect isEqualToString:@"1"]) {
                        postNormalSelectCount++;
                    } else if ([model.companyList[i].departmentList[j].postList[k].isSelect isEqualToString:@"3"]) {
                        postPartSelectCount++;
                    }
                }
            }
            if (postSelectCount == model.companyList[i].departmentList[j].postList.count && postSelectCount != 0) {
                if (postPartSelectCount != 0) {
                    model.companyList[i].departmentList[j].isSelect = @"3";
                } else {
                    if (postNormalSelectCount != 0) {
                        model.companyList[i].departmentList[j].isSelect = @"1";
                    } else {
                        model.companyList[i].departmentList[j].isSelect = @"2";
                    }
                }
            } else {
                if (postSelectCount != 0) {
                    model.companyList[i].departmentList[j].isSelect = @"3";
                } else {
                    model.companyList[i].departmentList[j].isSelect = @"0";
                }
            }
            
            if (![model.companyList[i].departmentList[j].isSelect isEqualToString:@"0"]) {
                departmentSelectCount++;
                if ([model.companyList[i].departmentList[j].isSelect isEqualToString:@"1"]) {
                    departmentNormalSelectCount++;
                } else if ([model.companyList[i].departmentList[j].isSelect isEqualToString:@"3"]) {
                    departmentPartSelectCount++;
                }
            }
        }
        if (departmentSelectCount == model.companyList[i].departmentList.count && departmentSelectCount != 0) {
            if (departmentPartSelectCount != 0) {
                model.companyList[i].isSelect = @"3";
            } else {
                if (departmentNormalSelectCount != 0) {
                    model.companyList[i].isSelect = @"1";
                } else {
                    model.companyList[i].isSelect = @"2";
                }
            }
        } else {
            if (departmentSelectCount != 0) {
                model.companyList[i].isSelect = @"3";
            } else {
                model.companyList[i].isSelect = @"0";
            }
        }
        
        if (![model.companyList[i].isSelect isEqualToString:@"0"]) {
            companySelectCount++;
        }
    }
    if (companySelectCount == model.companyList.count) {
        NSLog(@"全选所有公司");
    }
}

#pragma mark -- 单选员工
+ (void)singleSelectStaff:(YMOrganizationGeneralPurposeModel *)generalModel model:(YMOrganizationModel *)model {
    for (int i = 0; i < model.companyList.count; i++) {
        for (int j = 0; j < model.companyList[i].departmentList.count; j++) {
            for (int k = 0; k < model.companyList[i].departmentList[j].postList.count; k++) {
                for (int m = 0; m < model.companyList[i].departmentList[j].postList[k].staffList.count; m++) {
                    NSString *staffBelong = [NSString stringWithFormat:@"%@-%@-%@", model.companyList[i].nameId, model.companyList[i].departmentList[j].nameId, model.companyList[i].departmentList[j].postList[k].nameId];
                    if ([generalModel.belong isEqualToString:staffBelong]
                        && [generalModel.nameId isEqualToString:model.companyList[i].departmentList[j].postList[k].staffList[m].nameId]) {
                        // MARK: 是这一组并且是这个部门并且是这个岗位并且是这个员工赋值
                        model.companyList[i].departmentList[j].postList[k].staffList[m].isSelect = @"1";
                    } else {
                        model.companyList[i].departmentList[j].postList[k].staffList[m].isSelect = @"0";
                    }
                }
            }
        }
    }
}

#pragma mark - - 搜索相关
+ (void)obtainOrganizationSearchDataOnTheView:(UIView *)view success:(void (^)(id _Nonnull))success {
    // 基于 HUD loading 无文字
    [YMMBProgressHUD ymShowCustomLoadingAlert:view text:@""];
    NSDate *currentDate = [NSDate date];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 人员
        NSMutableArray *staffMArr = [[NSMutableArray alloc] init];
        for (int i = 0; i < 15; i++) {
            NSMutableDictionary *staffMDict = [[NSMutableDictionary alloc] init];
            [staffMDict setObject:[NSString stringWithFormat:@"张%d", i + 1] forKey:@"name"];
            [staffMDict setObject:[NSString stringWithFormat:@"%d", i + 1] forKey:@"nameId"];
            [staffMDict setObject:@"0" forKey:@"isSelect"];
            [staffMDict setObject:@"0" forKey:@"isShow"];
            [staffMArr addObject:staffMDict];
        }
        
        NSDictionary *result = @{@"status" : @"1", @"msg" : @"请求成", @"time" : @"2018-10-26", @"staffList" : staffMArr};
        NSLog(@"result = %@", result);
        dispatch_async(dispatch_get_main_queue(), ^{
            double deltaTime = [[NSDate date] timeIntervalSinceDate:currentDate];
            NSLog(@"data>>>>>>>>>>cost time = %f s", deltaTime);
            [YMMBProgressHUD ymHideLoadingAlert:view];
            success(result);
        });
    });
}
@end
