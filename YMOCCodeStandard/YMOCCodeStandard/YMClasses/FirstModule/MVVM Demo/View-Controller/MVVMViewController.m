//
//  MVVMViewController.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/11/30.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "MVVMViewController.h"

#import "MVVMView.h"
#import "MVVMViewModel.h"

@interface MVVMViewController ()

/// view
@property (nonatomic, readwrite, strong) MVVMView *mvvmView;
/// viewModel
@property (nonatomic, readwrite, strong) MVVMViewModel *viewModel;


@end

@implementation MVVMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - - 加载视图
- (void)loadSubviews {
    [super loadSubviews];
    
    [self.view addSubview:self.mvvmView];
}

#pragma mark - - 配置视图
- (void)configSubviews {
    [super configSubviews];
    
    self.viewModel = [[MVVMViewModel alloc] init];
}

#pragma mark - - 布局视图
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.mvvmView.frame = CGRectMake(0, 0, MainScreenWidth, 100);
}

#pragma mark - - 加载数据
- (void)loadData {
    [super loadData];
    
    __weak typeof(&*self) wsSelf = self;
    [self.viewModel requestDataSuccess:^(MVVMViewModel * _Nonnull viewModel) {
        __strong typeof(&*wsSelf) self = wsSelf;
        
        self.mvvmView.viewModel = viewModel;
    }];
}

#pragma mark - - touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.mvvmView endEditing:YES];
}

#pragma mark - - lazyLoadUI
- (MVVMView *)mvvmView {
    if (_mvvmView == nil) {
        _mvvmView = [[MVVMView alloc] init];
    }
    return _mvvmView;
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
