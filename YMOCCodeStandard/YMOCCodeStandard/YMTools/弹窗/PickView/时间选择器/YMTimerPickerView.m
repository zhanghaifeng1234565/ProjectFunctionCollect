//
//  YMTimerPickerView.m
//  YMDoctorClient
//
//  Created by iOS on 2018/7/30.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMTimerPickerView.h"


@interface YMTimerPickerView ()
<UIPickerViewDelegate, UIPickerViewDataSource>

/** 时间选择器 */
@property (nonatomic, strong) UIPickerView *pickerView;

/** 年数组 */
@property (nonatomic, strong) NSMutableArray *yearArray;
/** 月数组 */
@property (nonatomic, strong) NSMutableArray *monthArray;
/** 日数组 */
@property (nonatomic, strong) NSMutableArray *dayArray;

// 选中的时间
@property (nonatomic, assign) NSInteger selectedYear;
@property (nonatomic, assign) NSInteger selectedMonth;
@property (nonatomic, assign) NSInteger selectedDay;

// 当前年月日
@property (nonatomic, assign) NSInteger currentYear;
@property (nonatomic, assign) NSInteger currentMonth;
@property (nonatomic, assign) NSInteger currentDay;

/** 每个月天数 */
@property (nonatomic, assign) NSInteger dayNumber;

@end

@implementation YMTimerPickerView

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
}

#pragma mark - - 布局视图
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.pickerView.frame = CGRectMake(0, kToolBarViewHeight, self.width, kContentViewHeight - kToolBarViewHeight);
}

#pragma mark - pickerViewDatasource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.yearArray.count;
    } else if(component == 1){
        return self.monthArray.count;
    } else if (component == 2) {
        return self.dayArray.count;
    }
    return 0;
}

#pragma mark - pickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 40;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    for (UIView *lineView in pickerView.subviews) {
        if (lineView.height < 1) {
            lineView.backgroundColor = [UIColor colorWithHexString:@"03abff"];
        }
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width / 3.0, 30)];
    label.adjustsFontSizeToFitWidth = YES;
    label.textAlignment = NSTextAlignmentCenter;
    
    if (component == 0) {
        label.text = [NSString stringWithFormat:@"%@年", self.yearArray[row]];
        if (row == _selectedYear - 1) {
            label.font = [UIFont selectFont];
            label.textColor = [UIColor colorWithHexString:@"03abff"];
        } else {
            label.font = [UIFont normalFont];
            label.textColor = [UIColor colorWithHexString:@"999999"];
        }
    } else if (component == 1){
        label.text = [NSString stringWithFormat:@"%@月", self.monthArray[row]];
        if (row == _selectedMonth - 1) {
            label.font = [UIFont selectFont];
            label.textColor = [UIColor colorWithHexString:@"03abff"];
        } else {
            label.font = [UIFont normalFont];
            label.textColor = [UIColor colorWithHexString:@"999999"];
        }
    } else {
        label.text = [NSString stringWithFormat:@"%@日", self.dayArray[row]];
        if (row == _selectedDay - 1) {
            label.font = [UIFont selectFont];
            label.textColor = [UIColor colorWithHexString:@"03abff"];
        } else {
            label.font = [UIFont normalFont];
            label.textColor = [UIColor colorWithHexString:@"999999"];
        }
    }
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        self.year = _yearArray[row];
        self.selectedYear = (int)row+1;
        [pickerView reloadComponent:0];
    } else if(component == 1) {
        self.month = _monthArray[row];
        self.selectedMonth = (int)row + 1;
        [pickerView reloadComponent:1];
        self.selectedDay = 1;
        [self calculateDayWithMonth:[self.month intValue] andYear:[self.year intValue]];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
    } else {
        self.day = _dayArray[row];
        self.selectedDay = (int)row + 1;
        [pickerView reloadComponent:2];
    }
    
    NSString *string = [self getDateForMyMode];
    NSDictionary *resultD = @{@"pickerViewTitle" : string, @"pickerViewTitleId" : @"-1"};
    if (self.resultBlock) {
        self.resultBlock(resultD);
    } else {
        self.resultDict = [[NSDictionary alloc] initWithDictionary:resultD];
    }
}

#pragma mark - - 加载数据
- (void)loadData {
    [super loadData];
    
    // 获取当前年月日
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitflags = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute;
    NSDateComponents *dateComponent = [calendar components:unitflags fromDate:[NSDate date]];
    
    int year = (int)[dateComponent year];
    int month = (int)[dateComponent month];
    int day = (int)[dateComponent day];
    
    self.currentYear = year;
    self.currentMonth = month;
    self.currentDay = day;
    
    [self.yearArray removeAllObjects];
    for (int i = 1; i <= 10000; i++) {
        [_yearArray addObject:[@(i) stringValue]];
    }
    
    [self.monthArray removeAllObjects];
    for (int i = 1; i <= 12; i++) {
        [_monthArray addObject:[@(i) stringValue]];
    }
    
    [self calculateDayWithMonth:month andYear:year];
    
    _selectedYear = year; // 因为行数是从 0 开始的所以要减去 1
    _selectedMonth = month; // 因为行数是从 0 开始的所以要减去 1
    _selectedDay = day; // 因为数是从 0 开始的所以要减去 1
    
    [self.pickerView reloadAllComponents];
    //根据现在的年份和月份，初始化pickerView
    [self.pickerView selectRow:_currentYear - 1 inComponent:0 animated:YES];
    [self.pickerView selectRow:_currentMonth - 1 inComponent:1 animated:YES];
    [self.pickerView selectRow:_selectedDay - 1 inComponent:2 animated:YES];
    
    self.year = [NSString stringWithFormat:@"%d", year];
    self.month = [NSString stringWithFormat:@"%d", month];
    self.day = [NSString stringWithFormat:@"%d", day];
    
    NSString *string = [self getDateForMyMode];
    NSDictionary *resultD = @{@"pickerViewTitle" : string, @"pickerViewTitleId" : @"-1"};
    if (self.resultBlock) {
        self.resultBlock(resultD);
    } else {
        self.resultDict = [[NSDictionary alloc] initWithDictionary:resultD];
    }
}

#pragma mark -- 将日期格式转化为2016-01-01这种格式
- (NSString *)getDateForMyMode {
    NSString *myMonth = [NSString stringWithFormat:@"%@", self.month];
    NSString *myDay =[NSString stringWithFormat:@"%@", self.day];
    NSString *year = [NSString stringWithFormat:@"%@", self.year];
    
    if([self.month intValue] < 10) {
        myMonth = [NSString stringWithFormat:@"0%@", self.month];
    } else {
        myMonth = [NSString stringWithFormat:@"%@", self.month];
    }
    
    if([self.day intValue] < 10) {
        myDay = [NSString stringWithFormat:@"0%@", self.day];
    } else {
        myDay = [NSString stringWithFormat:@"%@", self.day];
    }
    
    return [NSString stringWithFormat:@"%@-%@-%@", year, myMonth, myDay];
}

#pragma mark -- 根据month和year计算对应的天数
- (void)calculateDayWithMonth:(int)month andYear:(int)year {
    NSInteger dayCount = 28;
    if (year / 100 == 0) {
        if (year / 4 == 0) {
            dayCount = 29;
        } else {
            dayCount = 28;
        }
    } else {
        if (year / 4 == 0) {
            dayCount = 29;
        } else {
            dayCount = 28;
        }
    }
    
    switch (month) {
        case 1:_dayNumber = 31; break;
        case 2:_dayNumber = dayCount; break;
        case 3:_dayNumber = 31; break;
        case 4:_dayNumber = 30; break;
        case 5:_dayNumber = 31; break;
        case 6:_dayNumber = 30; break;
        case 7:_dayNumber = 31; break;
        case 8:_dayNumber = 31; break;
        case 9:_dayNumber = 30; break;
        case 10:_dayNumber = 31; break;
        case 11:_dayNumber = 30; break;
        case 12:_dayNumber = 31; break;
    }
    [self.dayArray removeAllObjects];
    for (int index = 1; index <= _dayNumber; index++) {
        [self.dayArray addObject:[@(index) stringValue]];
    }
    self.day = _dayArray[0];
}

#pragma mark -- 创建视图
- (UIPickerView *)pickerView {
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] init];
    }
    return _pickerView;
}


#pragma mark -- getter
- (NSMutableArray *)yearArray
{
    if (_yearArray == nil) {
        _yearArray = [[NSMutableArray alloc] init];
    }
    return _yearArray;
}

- (NSMutableArray *)monthArray
{
    if (_monthArray == nil) {
        _monthArray = [[NSMutableArray alloc] init];
    }
    return _monthArray;
}

- (NSMutableArray *)dayArray
{
    if (_dayArray == nil) {
        _dayArray = [[NSMutableArray alloc] init];
    }
    return _dayArray;
}
@end
