//
//  YMBaseTableView.m
//  YMOAManageSystem
//
//  Created by iOS on 2018/11/19.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "YMBaseTableView.h"


@interface YMBaseTableView ()

/** 没有数据时视图 */
@property (nonatomic, strong) YMBaseTableViewEmptyView *emptyView;

@end

@implementation YMBaseTableView

#pragma mark - - init
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        // MARK: 添加视图
        [self loadSubviews];
        // MARK: 配置属性
        [self configProperty];
    }
    return self;
}

#pragma mark - - 加载视图
- (void)loadSubviews {
    
    [self addSubview:self.emptyView];
    [self.emptyView bringSubviewToFront:self];
}

#pragma mark - - 配置属性
- (void)configProperty {
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    __weak typeof(&*self) ws = self;
    self.emptyView.noDataBtnBlock = ^(UIButton * _Nonnull sender) {
        if (ws.noDataBtnBlock) {
            ws.noDataBtnBlock(sender);
        }
    };
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.emptyView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    if (self.dataMarr.count > 0) {
        self.emptyView.hidden = YES;
    } else {
        self.emptyView.hidden = NO;
        self.emptyView.emptyDataStyle = self.emptyDataStyle;
    }
}

#pragma mark - - lazyLoadUI
- (YMBaseTableViewEmptyView *)emptyView {
    if (_emptyView == nil) {
        _emptyView = [[YMBaseTableViewEmptyView alloc] init];
    }
    return _emptyView;
}

#pragma mark - - lazyLoadData
- (NSMutableArray *)dataMarr {
    if (_dataMarr == nil) {
        _dataMarr = [[NSMutableArray alloc] init];
    }
    return _dataMarr;
}

@end


/** tableView 空视图 */
@interface YMBaseTableViewEmptyView ()

/** 没有数据按钮 */
@property (nonatomic, strong) UIButton *noDataBtn;

@end

@implementation YMBaseTableViewEmptyView

#pragma mark - - init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // MARK: 添加视图
        [self loadSubviews];
        // MARK: 配置属性
        [self configProperty];
    }
    return self;
}

#pragma mark - - 加载视图
- (void)loadSubviews {
    
    [self addSubview:self.noDataBtn];
}

#pragma mark - - 配置属性
- (void)configProperty {
    self.backgroundColor = [UIColor magentaColor];
    
    [self.noDataBtn addTarget:self action:@selector(noDataBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    switch (self.emptyDataStyle) {
        case YMBaseTableViewEmptyDataStyleDefault:
        {
            self.noDataBtn.backgroundColor = [UIColor whiteColor];
            self.noDataBtn.frame = CGRectMake(0, 0, 0, 0);
        }
            break;
        case YMBaseTableViewEmptyDataStyleXXX:
        {
            self.noDataBtn.backgroundColor = [UIColor blueColor];
            self.noDataBtn.frame = CGRectMake((self.frame.size.width - 100) / 2, (self.frame.size.height - 100) / 2, 100, 100);
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - - 没有数据按钮点击调用
- (void)noDataBtnClick:(UIButton *)sender {
    if (self.noDataBtnBlock) {
        self.noDataBtnBlock(sender);
    }
}

#pragma mark - - lazyLoadUI
- (UIButton *)noDataBtn {
    if (_noDataBtn == nil) {
        _noDataBtn = [[UIButton alloc] init];
    }
    return _noDataBtn;
}

@end
