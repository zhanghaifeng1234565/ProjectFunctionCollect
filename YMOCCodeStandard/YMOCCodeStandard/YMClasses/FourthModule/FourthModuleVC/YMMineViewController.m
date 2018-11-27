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

#import "YMDemoFormViewController.h"
#import "YMNewsDemoViewController.h"

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
        case 3:
        {
            // MARK: 系统分享
            //分享的标题
            NSString *textToShare = @"分享的标题。";
            //分享的图片
            UIImage *imageToShare = [UIImage imageNamed:@"forward_resumes_blue_btn"];
            //分享的url
            NSURL *urlToShare = [NSURL URLWithString:@"http://www.baidu.com"];
            //在这里呢 如果想分享图片 就把图片添加进去  文字什么的同上
            NSArray *activityItems = @[textToShare, imageToShare, urlToShare];
            UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
            //不出现在活动项目
            activityVC.excludedActivityTypes = @[UIActivityTypePrint,  UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll];
            [self presentViewController:activityVC animated:YES completion:nil];
            // 分享之后的回调
            activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
                if (completed) {
                    NSLog(@"completed");
                    //分享 成功
                } else  {
                    NSLog(@"cancled");
                    //分享 取消
                }
            };
        }
            break;
            case 4:
        {
            YMDemoFormViewController *vc = [[YMDemoFormViewController alloc] init];
            vc.title = @"表单";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 5:
        {
            YMNewsDemoViewController *vc = [[YMNewsDemoViewController alloc] init];
            vc.title = @"多表单";
            [self.navigationController pushViewController:vc animated:YES];
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
        _dataArr = [[NSArray alloc] initWithObjects:@"组织架构【多选】", @"组织架构【单选】", @"微信支付", @"系统分享", @"表单", @"分段控制器", nil];
    }
    return _dataArr;
}


@end
