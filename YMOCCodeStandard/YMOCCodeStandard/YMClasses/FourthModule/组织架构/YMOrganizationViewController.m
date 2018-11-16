//
//  YMOrganizationViewController.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/10/29.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMOrganizationViewController.h"

#import "YMOrganizationTableViewCell.h"
#import "YMOrganizationSectionHeaderView.h"
#import "YMOrganizationSearchTableView.h"

#import "YMOrganizationModel.h"
#import "YMOrganizationViewModel.h"
#import "YMOrganizationSearchModel.h"

#import "MJExtension.h"
#import "YMMBProgressHUD.h"
#import "YMUISearchBar.h"

/** cell 重用 id */
static NSString *kYMOrganizationTableViewCellId = @"YMOrganizationTableViewCellId";
/** header 重用 id */
static NSString *kYMOrganizationSectionHeaderViewId = @"YMOrganizationSectionHeaderViewId";

@interface YMOrganizationViewController ()
<UITableViewDelegate, UITableViewDataSource>

/** 搜索 */
@property (nonatomic, strong) YMUISearchBar *searchBar;
/** 列表 tableView */
@property (nonatomic, strong) UITableView *tableView;
/** 数据源模型 */
@property (nonatomic, strong) YMOrganizationModel *model;
/** 数据源数组 */
@property (nonatomic, strong) NSMutableArray *dataMarr;

/** 全选按钮 */
@property (nonatomic, strong) UIButton *selectAllBtn;
/** 搜索列表 */
@property (nonatomic, strong) YMOrganizationSearchTableView *searchTableView;

/** 所有被选中员工数组【1 可修改的 2 不可修改的】 */
@property (nonatomic, strong) NSMutableArray *selectStaffMarr;
/** 所有被选中员工数组【仅有可修改的 状态为 1 的】 */
@property (nonatomic, strong) NSMutableArray *selectOnlyChangeMarr;
/** 搜索选中的人员数组 */
@property (nonatomic, strong) NSMutableArray *searchAllSelectMarr;
/** 列表和搜索所有被选中员工 */
@property (nonatomic, strong) NSMutableArray *totalSelectMarr;

@end

@implementation YMOrganizationViewController

#pragma mark - - dealloc
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"dealloc -- %@", [self class]);
}

#pragma mark - - init
- (instancetype)init {
    if (self = [super init]) {
        // MARK: 监听组织架构状态改变通知刷新列表
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(organizationRefreshNoti:) name:@"YMORGAIZATIONNOTI" object:nil];
        // MARK: 键盘通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

#pragma mark -- KeyBoard Notification
- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    self.searchTableView.hidden = NO;
    self.searchTableView.height = MainScreenHeight - NavBarHeight - self.searchBar.height - kbSize.height;
}

- (void)keyboardWillHide:(NSNotification *)notification {
    self.searchTableView.hidden = YES;
}

#pragma mark -- 收到通知刷新列表
- (void)organizationRefreshNoti:(NSNotification *)noti {
    NSDictionary *staffDict = noti.userInfo;

    // MARK: 选中某个公司
    [self selectCompanyNotiDict:staffDict];
    
    // MARK: 选中部门及以下
    [self selectDepartmentBlowNotiDict:staffDict];
    
    // MARK: 拿到所有选中人员的数组
    [self obtainAllSelectStaffMarr];
}

#pragma mark -- 选中公司
- (void)selectCompanyNotiDict:(NSDictionary *)staffDict {
    YMOrganizationCompanyModel *companyModel = staffDict[@"YMOrganizationCompanyModel"];
    if (companyModel) { // 选中 section 调用
        int section = [staffDict[@"section"] intValue];
        NSString *refreshType = staffDict[@"refreshType"];
        if ([refreshType isEqualToString:@"1"]) { // 选择
            if ([companyModel.isSelect isEqualToString:@"1"]) {
                [YMOrganizationViewModel isCompanySelectWithType:@"1" section:section model:self.model];
            } else if ([companyModel.isSelect isEqualToString:@"2"]) {
                [YMOrganizationViewModel isCompanySelectWithType:@"2" section:section model:self.model];
            } else {
                [YMOrganizationViewModel isCompanySelectWithType:@"0" section:section model:self.model];
            }
        }
        // MARK: 处理出入不可修改员工时多加一步操作
        if (self.staffMArr.count > 0) {
            [YMOrganizationViewModel createChangeModel:self.model];
        }
        // MARK: 更新数据
        [self updateDataWithModel:self.model];
    }
}

#pragma mark -- 选中部门及以下
- (void)selectDepartmentBlowNotiDict:(NSDictionary *)staffDict {
    YMOrganizationGeneralPurposeModel *generalModel = staffDict[@"YMOrganizationGeneralPurposeModel"];
    // MARK: 拿到状态进行赋值
    if (generalModel) { // 选中 cell 调用
        WS(ws);
        NSString *refreshType = staffDict[@"refreshType"];
        if ([refreshType isEqualToString:@"1"]) { // 选择按钮点击
            NSIndexPath *indexPath = staffDict[@"NSINDEXPATH"];
            // 更新这一行
            [UIView performWithoutAnimation:^{ // 去掉动画，解决大幅抖动
                [ws.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }];
            
            // 更新所有
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                [ws isSelectTypeWithGeneralModel:generalModel];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [ws updateDataWithModel:ws.model];
                });
            });
        } else if ([refreshType isEqualToString:@"2"]) { // 展示按钮点击
            [self isShowTypeWithGeneralModel:generalModel];
            // MARK: 更新数据
            [self updateDataWithModel:self.model];
        } else { // 搜索视图刷新
            NSIndexPath *indexPath = staffDict[@"SEARCHNSINDEXPATH"];
            NSLog(@"staffDict = %@", staffDict);
            if (self.singleSelect == YES) { // 单选
                for (int i = 0; i < self.searchTableView.data.count; i++) {
                    YMOrganizationStaffModel *staffModel = self.searchTableView.data[i];
                    if (i == indexPath.row) {
                        staffModel.isSelect = @"1";
                    } else {
                        staffModel.isSelect = @"0";
                    }
                }
                [self.searchTableView.tableView reloadData];
            } else { // 多选
                [UIView performWithoutAnimation:^{ // 去掉动画，解决大幅抖动
                    [ws.searchTableView.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                }];
            }
            
            // 获取搜索所有选中人员
            [self.searchAllSelectMarr removeAllObjects];
            for (int i = 0; i < self.searchTableView.data.count; i++) {
                YMOrganizationStaffModel *staffM = self.searchTableView.data[i];
                if ([staffM.isSelect isEqualToString:@"1"]) {
                    [self.searchAllSelectMarr addObject:staffM];
                }
            }
            
            // 同步刷新 tableView
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                [YMOrganizationViewModel dealStaffSelectStatusModelMArr:ws.searchTableView.data model:ws.model];
                [YMOrganizationViewModel createChangeModel:ws.model];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [ws updateDataWithModel:ws.model];
                });
            });
        }
    }
}

#pragma mark -- 展示的是 1 部门 2 岗位 3 员工【没有展示按钮】
- (void)isShowTypeWithGeneralModel:(YMOrganizationGeneralPurposeModel *)generalModel {
    if ([generalModel.type isEqualToString:@"1"]) { // 展示的是部门
        [YMOrganizationViewModel showDepartment:generalModel model:self.model];
    } else if ([generalModel.type isEqualToString:@"2"]) { // 展示的是岗位
        [YMOrganizationViewModel showPost:generalModel model:self.model];
    }
}

#pragma mark -- 选中的是 1 部门 2 岗位 3 员工
- (void)isSelectTypeWithGeneralModel:(YMOrganizationGeneralPurposeModel *)generalModel {
    if ([generalModel.type isEqualToString:@"1"]) { // 点击的是部门
        [YMOrganizationViewModel selectDepartment:generalModel model:self.model];
        // MARK: 处理传入不可修改员工时多加一步操作
        if (self.staffMArr.count > 0) {
            [YMOrganizationViewModel createChangeModel:self.model];
        }
    } else if ([generalModel.type isEqualToString:@"2"]) { // 点击的是岗位
        [YMOrganizationViewModel selectPost:generalModel model:self.model];
        // MARK: 处理传入不可修改员工时多加一步操作
        if (self.staffMArr.count > 0) {
            [YMOrganizationViewModel createChangeModel:self.model];
        }
    } else if ([generalModel.type isEqualToString:@"3"]) { // 点击的是员工
        if (self.isSingleSelect == YES) {
            [YMOrganizationViewModel singleSelectStaff:generalModel model:self.model];
        } else {
            [YMOrganizationViewModel selectStaff:generalModel model:self.model];
        }
    }
}

#pragma mark -- 拿到所有选中人员数组
- (void)obtainAllSelectStaffMarr {
    [self.totalSelectMarr removeAllObjects];
    self.selectOnlyChangeMarr = [YMOrganizationViewModel obtainSelectStaffOnlyChangeModel:self.model];
    for (int i = 0; i < self.selectOnlyChangeMarr.count; i++) {
        YMOrganizationStaffModel *staffM = self.selectOnlyChangeMarr[i];
        [self.totalSelectMarr addObject:staffM];
    }
    
    for (int i = 0; i < self.searchAllSelectMarr.count; i++) {
        YMOrganizationStaffModel *oneM = self.searchAllSelectMarr[i];
        [self.totalSelectMarr addObject:oneM];
        for (int j = 0; j < self.selectOnlyChangeMarr.count; j++) {
            YMOrganizationStaffModel *twoM = self.selectOnlyChangeMarr[j];
            if ([oneM.nameId isEqualToString:twoM.nameId]) {
                [self.totalSelectMarr removeObject:twoM];
            }
        }
    }
    
    NSLog(@"selectOnlyChangeMarr=%zd --- searchAllSelectMarr=%zd --- totalSelectMarr=%zd", self.selectOnlyChangeMarr.count, self.searchAllSelectMarr.count, self.totalSelectMarr.count);
}

#pragma mark - - lifeStyle
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark -- 导航
- (void)initNavData {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.selectAllBtn];
    if (self.isSingleSelect == YES) {
        [self.selectAllBtn setTitle:@"确定" forState:UIControlStateNormal];
    } else {
        [self.selectAllBtn setTitle:@"全选" forState:UIControlStateNormal];
    }
    self.title = @"组织架构";
    // 显示搜索视图
    self.searchBar.hidden = NO;
}

#pragma mark - - 添加视图
- (void)loadSubviews {
    [super loadSubviews];
    
    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.searchTableView];
}

#pragma mark - - tableViewDelegate - dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataMarr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rowCount = 0;
    if ([self.model.companyList[section].isShow isEqualToString:@"1"]) {
        NSArray *rowArr = self.dataMarr[section];
        rowCount = rowArr.count;
    } else {
        rowCount = 0;
    }
    return rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YMOrganizationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kYMOrganizationTableViewCellId];
    if (cell == nil) {
        cell = [[YMOrganizationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kYMOrganizationTableViewCellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.singleSelect = self.singleSelect;
    YMOrganizationGeneralPurposeModel *model = self.dataMarr[indexPath.section][indexPath.row];
    [cell setDataWithModel:model indexPath:indexPath];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    YMOrganizationSectionHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kYMOrganizationSectionHeaderViewId];
    if (header == nil) {
        header = [[YMOrganizationSectionHeaderView alloc] initWithReuseIdentifier:kYMOrganizationSectionHeaderViewId];
        header.layer.backgroundColor = [UIColor whiteColor].CGColor;
    }
    
    header.singleSelect = self.singleSelect;
    YMOrganizationCompanyModel *model = self.model.companyList[section];
    [header setDataWithModel:model section:section];
    
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 55;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.000001f;
}

#pragma mark - - 请求数据
- (void)loadData {
    [super loadData];
    
    WS(ws);
    [YMOrganizationViewModel obtainOrganizationDataOnTheView:self.view success:^(id  _Nonnull result) {
        // MARK: 得到的数据结果转成模型
        YMOrganizationModel *model = [YMOrganizationModel mj_objectWithKeyValues:result];
        ws.model = model;
        
        // MARK: 导航数据
        [ws initNavData];
        
        // MARK: 处理传入不可修改员工时多加一步操作
        if (ws.staffMArr.count > 0) {
            // MARK: 对模型进行第一步处理 所有员工标识是否被选中
            [YMOrganizationViewModel dealStaffSelectStatusMArr:ws.staffMArr model:model];
            
            // MARK: 对模型进行第二部步处理 创建一个员工模型模拟点击员工选中按钮来更新列表选中效果。这里只是调用一次方法，并没有去修改员工的真实状态 以及其所在的岗位部门公司的选中状态
            [YMOrganizationViewModel createChangeModel:model];
        }
        
        // MARK: 对数据进行重排更新数据
        [ws updateDataWithModel:model];
    }];
}

#pragma mark -- 更新数据
- (void)updateDataWithModel:(YMOrganizationModel *)model {
    self.dataMarr = [YMOrganizationViewModel updateDataWithModel:model];
    [self.tableView reloadData];
}

#pragma mark - - 全选按钮点击调用
- (void)selectAllBtnClick:(UIButton *)sender {
    if (self.isSingleSelect == YES) {
        self.selectOnlyChangeMarr = [YMOrganizationViewModel obtainSelectStaffOnlyChangeModel:self.model];
        
        NSString *msg = @"请选择员工";
        if (self.selectOnlyChangeMarr.count > 0) {
            YMOrganizationGeneralPurposeModel *model = self.selectOnlyChangeMarr[0];
            msg = model.name;
        } else {
            if (self.searchAllSelectMarr.count > 0) {
                 YMOrganizationStaffModel *searchModel = self.searchAllSelectMarr[0];
                msg = searchModel.name;
            } else {
                msg = @"请选择员工";
            }
        }
        [YMBlackSmallAlert showAlertWithMessage:msg time:2.0f];
    } else {
        if (sender.selected == YES) {
            [self isAllCompanySelectWithType:@"1" model:self.model];
            [sender setTitle:@"取消" forState:UIControlStateNormal];
            [sender setTitleColor:[UIColor magentaColor] forState:UIControlStateNormal];
            sender.selected = NO;
        } else {
            [self isAllCompanySelectWithType:@"0" model:self.model];
            [sender setTitle:@"全选" forState:UIControlStateNormal];
            [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            sender.selected = YES;
        }
    }
}

#pragma mark -- 是否所有全选 1 全选 否则不是全选
- (void)isAllCompanySelectWithType:(NSString *)type model:(YMOrganizationModel *)model {
    [YMOrganizationViewModel isAllCompanySelectWithType:type model:model];
    // 如果是取消创建一个员工模型模拟点击员工选中按钮来更新列表选中效果。这里只是调用一次方法，并没有去修改员工的真实状态 以及其所在的岗位部门公司的选中状态
    if ([type isEqualToString:@"0"] && self.staffMArr.count > 0) {
        [YMOrganizationViewModel createChangeModel:model];
    }
    // MARK: 更新数据
    [self updateDataWithModel:model];
}

#pragma mark - - lazyLoadUI
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, YMSCROLLVIEW_TOP_MARGIN + self.searchBar.height, MainScreenWidth, MainScreenHeight - NavBarHeight - self.searchBar.height) style:UITableViewStylePlain];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 50;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 37, 0);
    }
    return _tableView;
}

- (UIButton *)selectAllBtn {
    if (_selectAllBtn == nil) {
        _selectAllBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
        [_selectAllBtn setTitle:@"全选" forState:UIControlStateNormal];
        [_selectAllBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _selectAllBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _selectAllBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _selectAllBtn.selected = YES;
        [_selectAllBtn addTarget:self action:@selector(selectAllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectAllBtn;
}

- (YMUISearchBar *)searchBar {
    if (_searchBar == nil) {
        _searchBar = [[YMUISearchBar alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, 48)];
        _searchBar.placeholderColor = @"ffffff";
        _searchBar.textColor = @"ffffff";
        _searchBar.topMargin = 6;
        _searchBar.leftMargin = 15;
        _searchBar.placeholder = @"搜索";
        _searchBar.backgroundColor = @"ff3d3d";
        _searchBar.baseBackgroundImage = [UIImage imageWithColor:[UIColor groupTableViewBackgroundColor]];
        _searchBar.tfLeftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search_sousuo"]];
        _searchBar.clearImage = @"login_delete_icon";
        _searchBar.hidden = YES;
        
        WS(ws);
        _searchBar.ymUISearchBarSearchBtnActionBlock = ^(NSString *text) {
            [YMOrganizationViewModel obtainOrganizationSearchDataOnTheView:ws.searchTableView success:^(id  _Nonnull result) {
                YMOrganizationSearchModel *model = [YMOrganizationSearchModel mj_objectWithKeyValues:result];
                [ws.searchTableView.data removeAllObjects];
                
                // MARK: 同时设置搜索人员是否被选中【取消和不能取消】
                ws.selectStaffMarr = [YMOrganizationViewModel obtainSelectStaffModel:ws.model];
                // MARK: 拿到所有人员中已被选中且能被取消选中的人员
                ws.selectOnlyChangeMarr = [YMOrganizationViewModel obtainSelectStaffOnlyChangeModel:ws.model];
                NSLog(@"ws.selectStaffMarr.count == %zd", ws.selectStaffMarr.count);
                NSLog(@"ws.selectOnlyChangeMarr.count == %zd", ws.selectOnlyChangeMarr.count);
                for (int i = 0; i < ws.selectStaffMarr.count; i++) {
                    YMOrganizationStaffModel *staffModel = ws.selectStaffMarr[i];
                    for (int j = 0; j < model.staffList.count; j++) {
                        if ([staffModel.nameId isEqualToString:model.staffList[j].nameId]) {
                            model.staffList[j].isSelect = staffModel.isSelect;
                        }
                    }
                }
                
                for (int i = 0; i < ws.searchAllSelectMarr.count; i++) {
                    YMOrganizationStaffModel *searchModel = ws.searchAllSelectMarr[i];
                    for (int j = 0; j < model.staffList.count; j++) {
                        if ([model.staffList[j].nameId isEqualToString:searchModel.nameId]) {
                            model.staffList[j].isSelect = searchModel.isSelect;
                        }
                    }
                }
                
                for (int i = 0; i < model.staffList.count; i++) {
                    [ws.searchTableView.data addObject:model.staffList[i]];
                }
                [ws.searchTableView.tableView reloadData];
            }];
        };
        
        _searchBar.ymUISearchBarEmptyTextBlock = ^{
            [ws.searchTableView.data removeAllObjects];
            [ws.searchTableView.tableView reloadData];
        };
    }
    return _searchBar;
}

- (YMOrganizationSearchTableView *)searchTableView {
    if (_searchTableView == nil) {
        _searchTableView = [[YMOrganizationSearchTableView alloc] initWithFrame:CGRectMake(0, self.searchBar.height, MainScreenWidth, 100)];
        _searchTableView.hidden = YES;
        _searchTableView.singleSelect = self.singleSelect;
        WS(ws);
        _searchTableView.tapGestBlock = ^{
            ws.searchBar.text = @"";
        };
    }
    return _searchTableView;
}

#pragma mark -- lazyLoadData
- (NSMutableArray *)dataMarr {
    if (_dataMarr == nil) {
        _dataMarr = [[NSMutableArray alloc] init];
    }
    return _dataMarr;
}

- (NSMutableArray *)selectStaffMarr {
    if (_selectStaffMarr == nil) {
        _selectStaffMarr = [[NSMutableArray alloc] init];
    }
    return _selectStaffMarr;
}

- (NSMutableArray *)selectOnlyChangeMarr {
    if (_selectOnlyChangeMarr == nil) {
        _selectOnlyChangeMarr = [[NSMutableArray alloc] init];
    }
    return _selectOnlyChangeMarr;
}

- (NSMutableArray *)searchAllSelectMarr {
    if (_searchAllSelectMarr == nil) {
        _searchAllSelectMarr = [[NSMutableArray alloc] init];
    }
    return _searchAllSelectMarr;
}

- (NSMutableArray *)totalSelectMarr {
    if (_totalSelectMarr == nil) {
        _totalSelectMarr = [[NSMutableArray alloc] init];
    }
    return _totalSelectMarr;
}
@end
