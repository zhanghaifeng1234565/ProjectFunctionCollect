//
//  YMWorkbenchViewController.m
//  YMDoctorClient
//
//  Created by iOS on 2018/6/14.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMWorkbenchViewController.h"

#import "YMPictureViewerDemoViewController.h"
#import "YMQRViewController.h"
#import "SimpleAnimationViewController.h"
#import "AVFoundationViewController.h"

@interface YMWorkbenchViewController ()
<UITableViewDelegate,
UITableViewDataSource>

/** 列表 */
@property (nonatomic, strong) YMBaseTableView *tableView;
/** 数据 */
@property (nonatomic, strong) NSArray *dataArr;

/** gif */
@property (nonatomic, strong) YMGifImageView *gifImageV;

@end

@implementation YMWorkbenchViewController

#pragma mark -- lifeStyle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 加载导航数据
    [self loadNavUIData];
    // 加载视图
    [self loadSubviews];
    // 加载数据
    [self initData];
}

#pragma mark -- 加载导航数据
- (void)loadNavUIData {
    self.gifImageV.frame = CGRectMake(0, 0, 146, 65);
    self.navigationItem.titleView = self.gifImageV;
    [self.gifImageV setAnimationFileName:@"OARefreshHeader"];
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
    return self.tableView.dataMarr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YMBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELLID"];
    if (cell == nil) {
        cell = [[YMBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELLID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = self.tableView.dataMarr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
            case 0:
        {
            YMPictureViewerDemoViewController *vc = [[YMPictureViewerDemoViewController alloc] init];
            vc.title = self.dataArr[indexPath.row];
            vc.imageType = @"2";
            vc.isCollectionView = @"2";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            case 1:
        {
            YMPictureViewerDemoViewController *vc = [[YMPictureViewerDemoViewController alloc] init];
            vc.title = self.dataArr[indexPath.row];
            vc.imageType = @"1";
            vc.isCollectionView = @"2";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            case 2:
        {
            YMPictureViewerDemoViewController *vc = [[YMPictureViewerDemoViewController alloc] init];
            vc.title = self.dataArr[indexPath.row];
            vc.imageType = @"2";
            vc.isCollectionView = @"1";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            case 3:
        {
            YMPictureViewerDemoViewController *vc = [[YMPictureViewerDemoViewController alloc] init];
            vc.title = self.dataArr[indexPath.row];
            vc.imageType = @"1";
            vc.isCollectionView = @"1";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:
        {
            YMQRViewController *vc = [[YMQRViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 5:
        {
            SimpleAnimationViewController *vc = [[SimpleAnimationViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 6:
        {
            AVFoundationViewController *vc = [[AVFoundationViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;

            
        default:
            break;
    }
}

#pragma mark 请求数据
- (void)initData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [YMMBProgressHUD ymHideLoadingAlert:self.view];
        [self.tableView.dataMarr removeAllObjects];
        for (int i = 0; i < self.dataArr.count; i++) {
            [self.tableView.dataMarr addObject:self.dataArr[i]];
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    });
}

#pragma mark -- lazyLoadUI
- (YMBaseTableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[YMBaseTableView alloc] initWithFrame:CGRectMake(0, YMSCROLLVIEW_TOP_MARGIN, MainScreenWidth, MainScreenHeight - NavBarHeight - TabBarHeight) style:UITableViewStylePlain];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever; //UIScrollView也适用
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _tableView.emptyDataStyle = YMBaseTableViewEmptyDataStyleXXX;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 55;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.mj_header = [YMRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(initData)];
        
        WS(ws);
        _tableView.noDataBtnBlock = ^(UIButton * _Nonnull sender) {
            [YMMBProgressHUD ymShowLoadingAlert:ws.view];
            [ws initData];
        };
    }
    return _tableView;
}

#pragma mark -- getter
- (NSArray *)dataArr {
    if (_dataArr == nil) {
        _dataArr = [[NSArray alloc] initWithObjects:@"collectionView web 图片预览", @"collectionView local 图片预览", @"UIView web 图片预览", @"UIView local 图片预览", @"带 logo 的二维码", @"动画", @"AVFoundation", nil];
    }
    return _dataArr;
}

- (YMGifImageView *)gifImageV {
    if (_gifImageV == nil) {
        _gifImageV = [[YMGifImageView alloc] initWithFrame:CGRectZero];
    }
    return _gifImageV;
}

@end
