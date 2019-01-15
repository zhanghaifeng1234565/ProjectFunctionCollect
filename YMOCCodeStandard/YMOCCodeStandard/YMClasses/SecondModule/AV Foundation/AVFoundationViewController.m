//
//  AVFoundationViewController.m
//  YMOCCodeStandard
//
//  Created by iOS on 2019/1/14.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "AVFoundationViewController.h"

#import "FirstKnowledgeViewController.h"
#import "PlayAndRecordAudioViewController.h"

@interface AVFoundationViewController ()
<UITableViewDelegate,
UITableViewDataSource>

/** 列表 */
@property (nonatomic, strong) UITableView *tableView;
/** 数据 */
@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation AVFoundationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"AVFoundation";
}

#pragma mark -- 加载视图
- (void)loadSubviews {
    [super loadSubviews];
    
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
            // 初识 AV Foundation
            FirstKnowledgeViewController *vc = [[FirstKnowledgeViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            // 播放和录制音频
            PlayAndRecordAudioViewController *vc = [[PlayAndRecordAudioViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            [YMBlackSmallAlert showAlertWithMessage:@"敬请期待！" time:2.0];
            break;
    }
}

#pragma mark -- lazyLoadUI
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, YMSCROLLVIEW_TOP_MARGIN, MainScreenWidth, MainScreenHeight - NavBarHeight) style:UITableViewStylePlain];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever; //UIScrollView也适用
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, TabBarHeight, 0);
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
        _dataArr = [[NSArray alloc] initWithObjects:@"初识 AVFoundation", @"播放和录制音频", nil];
    }
    return _dataArr;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
