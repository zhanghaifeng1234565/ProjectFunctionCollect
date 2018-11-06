//
//  YMOrganizationSearchTableView.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/10/30.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMOrganizationSearchTableView.h"

#import "YMOrganizationSearchTableViewCell.h"

#import "YMOrganizationModel.h"

static NSString *kYMOrganizationSearchTableViewCellId = @"YMOrganizationSearchTableViewCellId";

@interface YMOrganizationSearchTableView ()
<UITableViewDelegate, UITableViewDataSource,
UIGestureRecognizerDelegate>


@end

@implementation YMOrganizationSearchTableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // MARK: 加载视图
        [self loadSubviews];
    }
    return self;
}

#pragma mark -- 加载视图
- (void)loadSubviews {
    [self addSubview:self.tableView];
}

#pragma mark -- 布局视图
- (void)layoutSubviews {
    [super layoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, self.width, self.height);
}

#pragma mark - - tableViewDelegate - dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YMOrganizationSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kYMOrganizationSearchTableViewCellId];
    if (cell == nil) {
        cell = [[YMOrganizationSearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kYMOrganizationSearchTableViewCellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.indexPath = indexPath;
    cell.singleSelect = self.singleSelect;
    YMOrganizationStaffModel *model = self.data[indexPath.row];
    cell.model = model;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.000001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.000001f;
}

#pragma mark - - gesture
- (void)tapGest:(UITapGestureRecognizer *)tapGest {
    if (self.tapGestBlock) {
        self.tapGestBlock();
    }
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    self.hidden = YES;
    [self.data removeAllObjects];
    [self.tableView reloadData];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch {
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return YES;
}

#pragma mark - - lazyLoadUI
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, YMSCROLLVIEW_TOP_MARGIN, MainScreenWidth, MainScreenHeight - NavBarHeight) style:UITableViewStylePlain];
        
        _tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 50;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        
        UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGest:)];
        tapGest.delegate = self;
        [_tableView addGestureRecognizer:tapGest];
    }
    return _tableView;
}

#pragma mark -- getter
- (NSMutableArray *)data {
    if (_data == nil) {
        _data = [[NSMutableArray alloc] init];
    }
    return _data;
}
@end
