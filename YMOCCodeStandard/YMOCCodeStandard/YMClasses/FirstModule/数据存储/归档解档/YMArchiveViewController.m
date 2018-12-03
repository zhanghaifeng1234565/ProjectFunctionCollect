//
//  YMArchiveViewController.m
//  YMOCCodeStandard
//
//  Created by iOS on 2018/12/3.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "YMArchiveViewController.h"

#import "YMPerson.h"

@interface YMArchiveViewController ()

/// 姓名
@property (nonatomic, readwrite, strong) YMLimitTextField *nameTextField;
/// 年龄
@property (nonatomic, readwrite, strong) YMLimitTextField *ageTextField;
/// 归档按钮
@property (nonatomic, readwrite, strong) UIButton *archiveBtn;

@end

@implementation YMArchiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - - 加载视图
- (void)loadSubviews {
    [super loadSubviews];
    
    [self.view addSubview:self.nameTextField];
    [self.view addSubview:self.ageTextField];
    [self.view addSubview:self.archiveBtn];
}

#pragma mark - - 配置属性
- (void)configSubviews {
    [super configSubviews];
    
    // title
    self.title = [NSString stringWithFormat:@"%@ - 点击空白清除缓存", self.title];
    
    // 名字
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 45)];
    [UILabel ym_label:nameLabel fontSize:15 textColor:[UIColor magentaColor]];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.text = @"名字：";
    [UITextField ym_textField:self.nameTextField leftView:nameLabel];
    [UITextField ym_view:self.nameTextField backgroundColor:[UIColor whiteColor] cornerRadius:3.0f borderWidth:0.5f borderColor:[UIColor magentaColor]];
    
    // 年龄
    UILabel *ageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 45)];
    [UILabel ym_label:ageLabel fontSize:15 textColor:[UIColor magentaColor]];
    ageLabel.textAlignment = NSTextAlignmentCenter;
    ageLabel.text = @"年龄：";
    [UITextField ym_textField:self.ageTextField leftView:ageLabel];
    [UITextField ym_view:self.ageTextField backgroundColor:[UIColor whiteColor] cornerRadius:3.0f borderWidth:0.5f borderColor:[UIColor magentaColor]];
    
    // 解档
    YMPerson *person = [YMPerson getPersonWithFileName:@"person.plist"];
    if (person.name) {
        self.nameTextField.text = person.name;
    }
    
    if (person.age) {
        self.ageTextField.text = [NSString stringWithFormat:@"%ld", (long)person.age];
    }
    
    // 归档按钮
    [UIButton ym_button:self.archiveBtn title:@"归档" fontSize:15 titleColor:[UIColor magentaColor]];
    [UIButton ym_view:self.archiveBtn backgroundColor:[UIColor whiteColor] cornerRadius:3.0f borderWidth:0.5f borderColor:[UIColor magentaColor]];
    [self.archiveBtn addTarget:self action:@selector(archiveBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - - 布局视图
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.nameTextField.frame = CGRectMake(15, 15, MainScreenWidth - 30, 45);
    self.ageTextField.frame = CGRectMake(15, self.nameTextField.bottom + 15, MainScreenWidth - 30, 45);
    self.archiveBtn.frame = CGRectMake(15, self.ageTextField.bottom + 30, MainScreenWidth - 30, 45);
}

#pragma mark - - touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    
    [YMPerson removeDocumentWithFileName:@"person.plist"];
    self.nameTextField.text = @"";
    self.ageTextField.text = @"";
}

#pragma mark - - 归档按钮点击调用
- (void)archiveBtnClick {
    YMPerson *person = [YMPerson new];
    person.name = self.nameTextField.text;
    person.age = [self.ageTextField.text integerValue];
    [YMPerson savePerson:person fileName:@"person.plist"];
}

#pragma mark - - lazyLoadUI
- (YMLimitTextField *)nameTextField {
    if (_nameTextField == nil) {
        _nameTextField = [[YMLimitTextField alloc] init];
    }
    return _nameTextField;
}

- (YMLimitTextField *)ageTextField {
    if (_ageTextField == nil) {
        _ageTextField = [[YMLimitTextField alloc] init];
    }
    return _ageTextField;
}

- (UIButton *)archiveBtn {
    if (_archiveBtn == nil) {
        _archiveBtn = [[UIButton alloc] init];
    }
    return _archiveBtn;
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
