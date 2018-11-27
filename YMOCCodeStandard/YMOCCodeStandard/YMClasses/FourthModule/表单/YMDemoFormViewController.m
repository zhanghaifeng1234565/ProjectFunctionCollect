//
//  YMDemoFormViewController.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/23.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "YMDemoFormViewController.h"

#import "YMFormTitleTableViewCell.h"
#import "YMFormTextFiledTableViewCell.h"
#import "YMFormTextViewTableViewCell.h"

#import "YMDemoFormModel.h"

@interface YMDemoFormViewController ()
<UITableViewDelegate, UITableViewDataSource>

/** 表单列表 */
@property (nonatomic, strong) YMBaseTableView *tableView;
/** 数据模型 */
@property (nonatomic, strong) YMDemoFormModel *model;
/** 数据结果 */
@property (nonatomic, strong) NSMutableDictionary *resultMDict;
/** 确定按钮 */
@property (nonatomic, strong) UIButton *sureBtn;

@end

@implementation YMDemoFormViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    YYCache *yyCache = [YYCache cacheWithName:@"Form.data"];
    self.resultMDict = [self.model yy_modelToJSONObject];
    [yyCache setObject:self.resultMDict forKey:@"form_dict" withBlock:^{
        NSLog(@"保存成功");
    }];
    
    [yyCache containsObjectForKey:@"form_dict" withBlock:^(NSString * _Nonnull key, BOOL contains) {
        NSLog(@"contains : %@", contains ? @"YES" : @"NO");
    }];
    
    [yyCache objectForKey:@"form_dict" withBlock:^(NSString * _Nonnull key, id<NSCoding>  _Nonnull object) {
        NSLog(@"key : %@ -- object : %@", key, object);
    }];
    
    NSString *cacheFolder = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *path = [cacheFolder stringByAppendingPathComponent:@"Form.data"];
    NSLog(@"path : %@", path);
}

#pragma mark - - 加载视图
- (void)loadSubviews {
    [super loadSubviews];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.sureBtn];
    [self.view addSubview:self.tableView];
}

#pragma mark - - 配置属性
- (void)configSubviews {
    [super configSubviews];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.tableView.estimatedRowHeight = 50;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, YMTABLEVIEW_BOTTOM_INSET, 0);
    
    [self.sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    self.sureBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - - 布局视图
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.tableView.frame = CGRectMake(0, 0, MainScreenWidth, MainScreenHeight - NavBarHeight);
}

#pragma mark - - 加载数据
- (void)loadData {
    [super loadData];
    
    YYCache *yyCache = [YYCache cacheWithName:@"Form.data"];
    
    [yyCache containsObjectForKey:@"form_dict" withBlock:^(NSString * _Nonnull key, BOOL contains) {
        NSLog(@"contains : %@", contains ? @"YES" : @"NO");
    }];
    
    [yyCache objectForKey:@"form_dict" withBlock:^(NSString * _Nonnull key, id<NSCoding>  _Nonnull object) {
        NSLog(@"key : %@ -- object : %@", key, object);
    }];
    
    
    WS(ws);
    // 判断缓存是否存在
    [yyCache containsObjectForKey:@"form_dict" withBlock:^(NSString * _Nonnull key, BOOL contains) {
        NSLog(@"isContains : %@", contains ? @"YES" : @"NO");
        [ws.tableView.dataMarr removeAllObjects];
        if (contains) {
            [yyCache objectForKey:@"form_dict" withBlock:^(NSString * _Nonnull key, id<NSCoding>  _Nonnull object) {
                
                NSDictionary *objectDict = (NSDictionary *)object;
                NSLog(@"objectDict --- %@", objectDict);
                ws.resultMDict = [[NSMutableDictionary alloc] initWithDictionary:objectDict];
                for (int i = 0; i < ws.resultMDict.count; i++) {
                    [ws.tableView.dataMarr addObject:@""];
                }
                
                YMDemoFormModel *model = [YMDemoFormModel yy_modelWithJSON:ws.resultMDict];
                ws.model = model;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [ws.tableView reloadData];
                });
            }];
        } else {
            NSDictionary *dict = @{
                                   @"titleStr" : @"我是标题 title" ,
                                   @"textFiedStr" : @"" ,
                                   @"textViewStr" : @"",
                                   @"titleStr1" : @"我是标题 title1" ,
                                   @"textFiedStr1" : @"" ,
                                   @"textViewStr1" : @"",
                                   @"titleStr2" : @"我是标题 title2" ,
                                   @"textFiedStr2" : @"" ,
                                   @"textViewStr2" : @"",
                                   @"titleStr3" : @"我是标题 title3" ,
                                   @"textFiedStr3" : @"" ,
                                   @"textViewStr3" : @""
                                   };
            
            ws.resultMDict = [[NSMutableDictionary alloc] initWithDictionary:dict];
            for (int i = 0; i < ws.resultMDict.count; i++) {
                [ws.tableView.dataMarr addObject:@""];
            }
            
            YMDemoFormModel *model = [YMDemoFormModel yy_modelWithJSON:ws.resultMDict];
            ws.model = model;
            dispatch_async(dispatch_get_main_queue(), ^{
                [ws.tableView reloadData];
            });
        }
    }];
}

#pragma mark - - delegate && dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableView.dataMarr.count;
}

#pragma mark - - 标题 cell
- (void)titleTableViewStyle:(NSIndexPath * _Nonnull)indexPath reCell:(UITableViewCell **)reCell tableView:(UITableView * _Nonnull)tableView {
    YMFormTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YMFormTitleTableViewCellId"];
    if (cell == nil) {
        cell = [[YMFormTitleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YMFormTitleTableViewCellId"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.indexPath = indexPath;
    cell.model = self.model;
    
    *reCell = cell;
}

#pragma mark - - textField cell
- (void)textFieldTableViewStyle:(NSIndexPath * _Nonnull)indexPath reCell:(UITableViewCell **)reCell tableView:(UITableView * _Nonnull)tableView {
    YMFormTextFiledTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YMFormTextFiledTableViewCellId"];
    if (cell == nil) {
        cell = [[YMFormTextFiledTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YMFormTextFiledTableViewCellId"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.indexPath = indexPath;
    cell.model = self.model;
    
    WS(ws);
    cell.textField.textFieldChange = ^(YMLimitTextField * _Nonnull textField) {
        switch (indexPath.row) {
            case 1:
            {
                ws.model.textFiedStr = textField.text;
            }
                break;
            case 4:
            {
                ws.model.textFiedStr1 = textField.text;
            }
                break;
            case 7:
            {
                ws.model.textFiedStr2 = textField.text;
            }
                break;
            case 10:
            {
                ws.model.textFiedStr3 = textField.text;
            }
                break;
            default:
                ws.model.textFiedStr = textField.text;
                break;
        }
        
        [ws.tableView beginUpdates];
        [ws.tableView endUpdates];
    };
    
    *reCell = cell;
}

#pragma mark - - textView cell
- (void)textViewTableViewStyle:(NSIndexPath * _Nonnull)indexPath reCell:(UITableViewCell **)reCell tableView:(UITableView * _Nonnull)tableView {
    YMFormTextViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YMFormTextViewTableViewCellId"];
    if (cell == nil) {
        cell = [[YMFormTextViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YMFormTextViewTableViewCellId"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.indexPath = indexPath;
    cell.model = self.model;
    
    WS(ws);
    cell.textView.textViewHeightChange = ^(YMAdaptiveHeightTextView * _Nonnull textView) {
        switch (indexPath.row) {
            case 2:
            {
                ws.model.textViewStr = textView.text;
            }
                break;
            case 5:
            {
                ws.model.textViewStr1 = textView.text;
            }
                break;
            case 8:
            {
                ws.model.textViewStr2 = textView.text;
            }
                break;
            case 11:
            {
                ws.model.textViewStr3 = textView.text;
            }
                break;
            default:
                ws.model.textViewStr = textView.text;
                break;
        }
        
        [ws.tableView beginUpdates];
        [ws.tableView endUpdates];
    };
    
    *reCell = cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *reCell = nil;
    if (indexPath.row % 3 == 0) {
        [self titleTableViewStyle:indexPath reCell:&reCell tableView:tableView];
    } else if (indexPath.row % 3 == 1) {
        [self textFieldTableViewStyle:indexPath reCell:&reCell tableView:tableView];
    } else {
        [self textViewTableViewStyle:indexPath reCell:&reCell tableView:tableView];
    }
    return reCell;
}

#pragma mark - - 确定按钮店家调用
- (void)sureBtnClick {
    [YMMBProgressHUD ymShowLoadingAlert:self.view];
    
    WS(ws);
    YYCache *yyCache = [YYCache cacheWithName:@"Form.data"];
    
    //移除所有缓存带进度
    [yyCache removeAllObjectsWithProgressBlock:^(int removedCount, int totalCount) {
        NSLog(@"removeAllObjects removedCount :%d  totalCount : %d", removedCount, totalCount);
    } endBlock:^(BOOL error) {
        if(!error){
            dispatch_async(dispatch_get_main_queue(), ^{
                [YMMBProgressHUD ymHideLoadingAlert:ws.view];
                
                [ws loadData];
            });
            NSLog(@"removeAllObjects sucess");
        } else {
            NSLog(@"removeAllObjects error");
        }
    }];
}

#pragma mark - - lazyLoadUI
- (YMBaseTableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[YMBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    return _tableView;
}

- (UIButton *)sureBtn {
    if (_sureBtn == nil) {
        _sureBtn = [[UIButton alloc] init];
    }
    return _sureBtn;
}

@end
