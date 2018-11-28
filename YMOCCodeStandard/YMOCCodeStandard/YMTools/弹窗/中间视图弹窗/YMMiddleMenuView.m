//
//  YMMiddleMenuView.m
//  OAManagementSystem
//
//  Created by iOS on 2018/5/8.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMMiddleMenuView.h"

#import "YMMiddleMenuTableViewCell.h"

@interface YMMiddleMenuView ()
<UITableViewDelegate,
UITableViewDataSource>

/** 内容视图 */
@property (nonatomic, strong) UIView *contentView;
/** 透明视图 */
@property (nonatomic, strong) UIView *alertView;
/** list*/
@property (nonatomic, strong) UITableView *mTable;
/** 背景视图 */
@property (nonatomic, strong) UIImageView *imageV;

@end

@implementation YMMiddleMenuView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}

#pragma mark - config
- (void)configUI {
    [self addSubview:self.alertView];
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.imageV];
    [self.contentView addSubview:self.mTable];
}

#pragma mark - delegate && dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YMMiddleMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YMMiddleMenuTableViewCellId"];
    if (cell==nil) {
        cell = [[YMMiddleMenuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YMMiddleMenuTableViewCellId"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSDictionary *dict = self.titleArray[indexPath.row];
    cell.menuTitleLab.text = [dict objectForKey:@"filtratename"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = self.titleArray[indexPath.row];
    if (self.blockSelectedMenu) {
        self.blockSelectedMenu(indexPath.row, [dict objectForKey:@"filtratename"], [dict objectForKey:@"filtrateid"]);
    }
    [self animateRemoveView];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self animateRemoveView];
}

- (void)setTitleArray:(NSArray *)titleArray {
    //    NSLog(@"titleArray==%@", titleArray);
    _titleArray = titleArray;
    self.contentView.frame = self.tabFrame;
    if (titleArray.count > 6) {
        self.contentView.height = 6 * 45;
        self.imageV.height = 6 * 45;
        self.mTable.height = 6 * 45;
    } else {
        self.contentView.height = titleArray.count * 45;
        self.imageV.height = titleArray.count * 45;
        self.mTable.height = titleArray.count * 45;
    }
    [self.mTable reloadData];
}

#pragma mark - function
- (void)animateRemoveView {
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0.f;
        self.contentView.transform = CGAffineTransformMakeScale(0.001f, 0.001f);
        self.contentView.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - layzing
- (UITableView *)mTable {
    if (!_mTable) {
        _mTable = [[UITableView alloc] initWithFrame:CGRectMake(5, 0, 120, 91)
                                               style:UITableViewStylePlain];
        _mTable.delegate = self;
        _mTable.dataSource = self;
        _mTable.showsVerticalScrollIndicator = NO;
        _mTable.layer.cornerRadius = 6.0f;
        _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mTable;
}

- (UIView *)contentView {
    if (_contentView == nil) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(MainScreenWidth - 130, NavBarHeight - 12, 130, 100)];
    }
    return _contentView;
}

- (UIImageView *)imageV {
    if (_imageV == nil) {
        _imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 130, 100)];
        _imageV.image = [UIImage imageNamed:@"home_tk_bg"];
    }
    return _imageV;
}

- (UIView *)alertView {
    if (_alertView == nil) {
        _alertView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight)];
        _alertView.backgroundColor = [UIColor blackColor];
        _alertView.alpha = 0.05;
    }
    return _alertView;
}

@end
