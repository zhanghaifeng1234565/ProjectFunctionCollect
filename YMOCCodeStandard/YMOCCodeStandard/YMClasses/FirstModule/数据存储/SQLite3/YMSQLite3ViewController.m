//
//  YMSQLite3ViewController.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/30.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "YMSQLite3ViewController.h"
#import <sqlite3.h>
#import "YMSQLit3Tools.h"
#import "YMSQLite3Person.h"

@interface YMSQLite3ViewController ()
<UITableViewDelegate,
UITableViewDataSource>

/** 列表 */
@property (nonatomic, strong) UITableView *tableView;
/** 数据 */
@property (nonatomic, strong) NSArray *dataArr;

@property (nonatomic, readwrite, strong) YMSQLite3Person *person;

@end

@implementation YMSQLite3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
            // MARK: 打开数据库
            [[YMSQLit3Tools shareManager] openSQLite3WithName:@"t_person" success:^{
                
            }];
        }
            break;
        case 1:
        {
            // MARK: 创建表格 ---> 数据库已经打开
            [[YMSQLit3Tools shareManager] createTable:@"t_person" param:@"'name' text, 'age' integer, 'height' float, 'weight' float" success:^{
                
            }];
        }
            break;
        case 2:
        {
            // MARK: 插入数据
            self.person.delete_data = NO;
            NSString *paramNames = @"id, name, age, height, weight";
            NSString *vaules =  [NSString stringWithFormat:@"'%@','%@','%@','%@', '%@'", self.person.itemid, self.person.name, self.person.age, self.person.height, self.person.weight];
            [[YMSQLit3Tools shareManager] insertTable:@"t_person" paramNames:paramNames vaules:vaules success:^{
                
            }];
        }
            break;
        case 3:
        {
            // MARK: 删除数据
            self.person.delete_data = YES;
            NSString *condition = [NSString stringWithFormat:@"id = '%@'", self.person.itemid];
            [[YMSQLit3Tools shareManager] deleteTable:@"t_person" condition:condition success:^{
                
            }];
        }
            break;
        case 4:
        {
            [[YMSQLit3Tools shareManager] updataTable:@"t_person" condition:@"name = '李四', age = '17', height = '180', weight = '78.00'" where:@"id = '0'" success:^{
                
            }];
        }
            break;
        case 5:
        {
            WS(ws);
            [[YMSQLit3Tools shareManager] selectTable:@"t_person" paramNames:@"id, name, age, height, weight" condition:@"age < 20" success:^(id  _Nonnull result, NSInteger itemid) {
                ws.person.itemid = [NSString stringWithFormat:@"%zd", itemid + 1];
                NSLog(@"result = %@ -- itemid = %zd", result, itemid);
            }];
        }
            break;
        case 6:
        {
            [[YMSQLit3Tools shareManager] closeSqlite];
        }
            break;
        default:
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
        _dataArr = [[NSArray alloc] initWithObjects:@"打开数据库", @"创建表格", @"增加", @"删除", @"修改", @"查询", @"关闭数据库", nil];
    }
    return _dataArr;
}

- (YMSQLite3Person *)person {
    if (_person == nil) {
        _person = [[YMSQLite3Person alloc] init];
        
        _person.name = @"张三";
        _person.age = @"19";
        _person.height = @"175.00";
        _person.weight = @"75.00";
    }
    return _person;
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
