//
//  YMUniversalSingleSelectionPickerView.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/13.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "YMUniversalSingleSelectionPickerView.h"

#import "YMUniversalSingleSelectModel.h"

@interface YMUniversalSingleSelectionPickerView ()
<UIPickerViewDelegate, UIPickerViewDataSource>

/** pickerView */
@property (nonatomic, strong) UIPickerView *pickerView;
/** 数据源数组 */
@property (nonatomic, strong) NSMutableArray *dataMarr;

@end

@implementation YMUniversalSingleSelectionPickerView {
    /** 这一行是否选中 */
    BOOL _rowIsSelect;
}

#pragma mark - - 加载视图
- (void)loadSubviews {
    [super loadSubviews];
    
    [self.contentView addSubview:self.pickerView];
}

#pragma mark - - 配置视图
- (void)configProprty {
    [super configProprty];
    
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    NSInteger index =  [self.pickerView selectedRowInComponent:0];
    [self pickerView:self.pickerView didSelectRow:index inComponent:0];
}

#pragma mark - - 布局视图
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.pickerView.frame = CGRectMake(0, kToolBarViewHeight, self.width, kContentViewHeight - kToolBarViewHeight);
}

#pragma mark - - delegate && dataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataMarr.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return self.width;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 48;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    YMUniversalSingleDataModel *model = self.dataMarr[row];
    UILabel *label = [[UILabel alloc] init];
    label.text = model.title;
    if ([model.select isEqualToString:@"0"]) {
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor colorWithHexString:@"999999"];
    } else {
        label.font = [UIFont systemFontOfSize:17];
        label.textColor = [UIColor colorWithHexString:@"03abff"];
    }
    label.textAlignment = NSTextAlignmentCenter;
    
    
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    for (int i = 0; i < self.dataMarr.count; i++) {
        YMUniversalSingleDataModel *selectModel = self.dataMarr[i];
        if (i == row) {
            selectModel.select = @"1";
            NSDictionary *resultD = @{@"pickerViewTitle" : selectModel.title, @"pickerViewTitleId" : selectModel.titleId};
            if (self.resultBlock) {
                self.resultBlock(resultD);
            } else {
                self.resultDict = [[NSDictionary alloc] initWithDictionary:resultD];
            }
            NSLog(@"self.resultDict == %@", self.resultDict);
        } else {
            selectModel.select = @"0";
        }
    }
    [self.pickerView reloadComponent:component];
}

#pragma mark - - lazyLoadUI
- (UIPickerView *)pickerView {
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] init];
    }
    return _pickerView;
}

#pragma mark - - lazyLoadData
- (NSMutableArray *)dataMarr {
    if (_dataMarr == nil) {
        _dataMarr = [[NSMutableArray alloc] init];
        
        NSArray *listArr = [[NSArray alloc] initWithObjects:@"中国", @"美国", @"英国", @"德国", @"法国", @"俄罗斯", nil];
        NSMutableArray *dataM = [[NSMutableArray alloc] init];
        for (int i = 0; i < listArr.count; i++) {
            NSMutableDictionary *dictM = [[NSMutableDictionary alloc] init];
            [dictM setValue:listArr[i] forKey:@"title"];
            [dictM setValue:@(i + 1).description forKey:@"titleId"];
            [dictM setValue:@"0" forKey:@"select"];
            [dataM addObject:dictM];
        }
        
        NSDictionary *result = @{@"status" : @"1", @"time" : @"2018-11-13", @"list" : dataM, @"msg" : @"获取成功"};
        
        YMUniversalSingleSelectModel *model = [YMUniversalSingleSelectModel mj_objectWithKeyValues:result];
        for (int i = 0; i < model.list.count; i++) {
            [_dataMarr addObject:model.list[i]];
        }
    }
    return _dataMarr;
}

@end
