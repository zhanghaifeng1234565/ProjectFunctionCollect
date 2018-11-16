//
//  YMCountryPickerView.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/14.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "YMCountryPickerView.h"

#import "YMCountryDataTools.h"
#import "YMUniversalSingleSelectModel.h"
#import "YMCountryModel.h"


static CGFloat kRowHeight = 48.0f;

@interface YMCountryPickerView ()
<UIPickerViewDelegate, UIPickerViewDataSource>

/** pickerView */
@property (nonatomic, strong) UIPickerView *pickerView;
/** 数据源模型 */
@property (nonatomic, strong) YMCountryModel *model;

@end

@implementation YMCountryPickerView {
    /** 这一行是否选中 */
    BOOL _rowIsSelect;
    /** 第一组当前选中的行 */
    NSInteger _firstComponentCurrentRow;
    /** 第二组当前选中的行 */
    NSInteger _secondComponentCurrentRow;
    /** 第三组当前选中的行 */
    NSInteger _thirdComponentCurrentRow;
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
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSInteger rowCount = 0;
    if (component == 0) {
        rowCount = self.model.province.count;
    } else if (component == 1) {
        rowCount = self.model.province[_firstComponentCurrentRow].city.count;
    } else {
        rowCount = self.model.province[_firstComponentCurrentRow].city[_secondComponentCurrentRow].county.count;
    }
    return rowCount;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return self.width / 3;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return kRowHeight;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    for (UIView *lineView in pickerView.subviews) {
        if (lineView.height < 1) {
            lineView.backgroundColor = [UIColor colorWithHexString:@"03abff"];
        }
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.width / 3 - 20, kRowHeight)];
    if (component == 0) {
        label.text = self.model.province[row].name;
        if (row == _firstComponentCurrentRow) {
            label.font = [UIFont selectFont];
            label.textColor = [UIColor colorWithHexString:@"03abff"];
        } else {
            label.font = [UIFont normalFont];
            label.textColor = [UIColor colorWithHexString:@"999999"];
        }
    } else if (component == 1) {
        label.text = self.model.province[_firstComponentCurrentRow].city[row].name;
        if (row == _secondComponentCurrentRow) {
            label.font = [UIFont selectFont];
            label.textColor = [UIColor colorWithHexString:@"03abff"];
        } else {
            label.font = [UIFont normalFont];
            label.textColor = [UIColor colorWithHexString:@"999999"];
        }
    } else {
        label.text = self.model.province[_firstComponentCurrentRow].city[_secondComponentCurrentRow].county[row].name;
        if (row == _thirdComponentCurrentRow) {
            label.font = [UIFont selectFont];
            label.textColor = [UIColor colorWithHexString:@"03abff"];
        } else {
            label.font = [UIFont normalFont];
            label.textColor = [UIColor colorWithHexString:@"999999"];
        }
    }
    
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0) {
        _firstComponentCurrentRow = row;
        _secondComponentCurrentRow = 0;
        _thirdComponentCurrentRow = 0;
    } else if (component == 1) {
        _secondComponentCurrentRow = row;
        _thirdComponentCurrentRow = 0;
    } else {
        _thirdComponentCurrentRow = row;
    }
    
    NSString *title = [NSString stringWithFormat:@"%@-%@-%@", self.model.province[_firstComponentCurrentRow].name, self.model.province[_firstComponentCurrentRow].city[_secondComponentCurrentRow].name, self.model.province[_firstComponentCurrentRow].city[_secondComponentCurrentRow].county[_thirdComponentCurrentRow].name];
    NSString *titleId = [NSString stringWithFormat:@"%@-%@-%@", self.model.province[_firstComponentCurrentRow].nameId, self.model.province[_firstComponentCurrentRow].city[_secondComponentCurrentRow].nameId, self.model.province[_firstComponentCurrentRow].city[_secondComponentCurrentRow].county[_thirdComponentCurrentRow].nameId];
    NSDictionary *resultD = @{@"pickerViewTitle" : title, @"pickerViewTitleId" : titleId};
    
    if (self.resultBlock) {
        self.resultBlock(resultD);
    } else {
        self.resultDict = [[NSDictionary alloc] initWithDictionary:resultD];
    }
    
    if (component == 0) {
        [self.pickerView reloadAllComponents];
        [self.pickerView selectRow:_firstComponentCurrentRow inComponent:0 animated:YES];
        [self.pickerView selectRow:_secondComponentCurrentRow inComponent:1 animated:YES];
        [self.pickerView selectRow:_thirdComponentCurrentRow inComponent:2 animated:YES];
    } else if (component == 1) {
        [self.pickerView reloadComponent:1];
        [self.pickerView reloadComponent:2];
        [self.pickerView selectRow:_secondComponentCurrentRow inComponent:1 animated:YES];
    } else {
        [self.pickerView reloadComponent:3];
        [self.pickerView selectRow:_thirdComponentCurrentRow inComponent:2 animated:YES];
    }
}

#pragma mark - - 加载数据
- (void)loadData {
    [super loadData];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *pathStr = [[NSBundle mainBundle] pathForResource:@"CityPropertyList" ofType:@"plist"];
        NSDictionary *resultDict = [[NSDictionary alloc] initWithContentsOfFile:pathStr];
        YMCountryModel *model = [YMCountryModel mj_objectWithKeyValues:resultDict];
        self.model = model;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.pickerView reloadAllComponents];
            NSInteger index =  [self.pickerView selectedRowInComponent:0];
            [self pickerView:self.pickerView didSelectRow:index inComponent:0];
        });
    });
}

#pragma mark - - lazyLoadUI
- (UIPickerView *)pickerView {
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] init];
    }
    return _pickerView;
}

#pragma mark - - lazyLoadData

@end
