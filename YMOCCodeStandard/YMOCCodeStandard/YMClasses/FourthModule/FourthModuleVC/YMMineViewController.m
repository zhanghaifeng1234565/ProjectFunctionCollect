//
//  YMMineViewController.m
//  YMDoctorClient
//
//  Created by iOS on 2018/6/14.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMMineViewController.h"
#import "YMOrganizationViewController.h"
#import "YMWXPayTool.h"

@interface YMMineViewController ()
<UITableViewDelegate,
UITableViewDataSource>

/** 列表 */
@property (nonatomic, strong) UITableView *tableView;
/** 数据 */
@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation YMMineViewController

#pragma mark - - dealloc
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"%s -- %@", __func__, [self class]);
}

#pragma mark - - init
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // MARK: 监听微信支付结果通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderPayResult:) name:@"ORDER_PAY_NOTIFICATION" object:nil];
    }
    return self;
}

#pragma mark - - 微信支付结果处理
- (void)getOrderPayResult:(NSNotification *)notification {
    if ([notification.object isEqualToString:@"success"]) {
        NSLog(@"支付成功");
    } else {
        NSLog(@"支付失败");
    }
}

#pragma mark -- lifeStyle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 加载导航数据
    [self loadNavUIData];
    // 加载视图
    [self loadSubviews];
}

#pragma mark -- 加载导航数据
- (void)loadNavUIData {
    
}

#pragma mark -- 加载视图
- (void)loadSubviews {
    [self.view addSubview:self.tableView];
}

#pragma mark -- tableViewDelegate --- dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YMBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELLID"];
    if (cell == nil) {
        cell = [[YMBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELLID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = self.dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            // 获取外界传来的员工状态数组
            NSMutableArray *staffMArr = [[NSMutableArray alloc] init];
            for (int i = 0; i < 15; i++) {
                NSMutableDictionary *staffMDict = [[NSMutableDictionary alloc] init];
                [staffMDict setObject:[NSString stringWithFormat:@"张%d", i + 1] forKey:@"name"];
                [staffMDict setObject:[NSString stringWithFormat:@"%d", i + 1] forKey:@"nameId"];
                [staffMDict setObject:[NSString stringWithFormat:@"%d", arc4random_uniform(3)] forKey:@"isSelect"];
                [staffMDict setObject:@"0" forKey:@"isShow"];
                [staffMArr addObject:staffMDict];
            }
            YMOrganizationViewController *vc = [[YMOrganizationViewController alloc] init];
            vc.singleSelect = NO;
            vc.staffMArr = [[NSMutableArray alloc] initWithArray:staffMArr];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            YMOrganizationViewController *vc = [[YMOrganizationViewController alloc] init];
            vc.singleSelect = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            // MARK: 点击进行微信支付 [NSDictionary new] 参数
            [YMWXPayTool ymWXPayWithParameterDict:[NSDictionary new]];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark -- lazyLoadUI
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, YMSCROLLVIEW_TOP_MARGIN, MainScreenWidth, MainScreenHeight - NavBarHeight - TabBarHeight) style:UITableViewStylePlain];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever; //UIScrollView也适用
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 55;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

#pragma mark -- getter
- (NSArray *)dataArr {
    if (_dataArr == nil) {
        _dataArr = [[NSArray alloc] initWithObjects:@"组织架构【多选】", @"组织架构【单选】", @"微信支付", nil];
    }
    return _dataArr;
}


@end
