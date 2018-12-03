//
//  YMHomeViewController.m
//  YMDoctorClient
//
//  Created by iOS on 2018/6/14.
//  Copyright © 2018年 iOS. All rights reserved.
//
/**
 cocoaPod 好处。过滤冲突。


 一、命名规范
 
 基本原则：
 1.1 清晰
 
 命名应尽可能的清晰和简洁，但在 Objective-C 中，清晰比简洁更重要。
 XCode 会自动寻找类似的方法。
 
 1.2 一致性
 
 在同一模块下或者派生类的时候，要遵循其基类或整体模块的命名风格，保持
 命名风格一致性。
 
 1.3 使用前缀
 
 在命名某个类的时候应加上公司的前缀，在必要的时候可以加上个人的名字缩
 写【如果有需要的时候可以加上】。
 
 1.4 命名方法
 
 我们在方法命名的时候，尽可能的把方法详细的描述，便于自己或者他人
 review，所以一般采用驼峰命名，而且都采用英文，千万不要写拼音。
 - (void)getImage {
 ...
 }
 
 1.5 命名代理
 
 最标准的就是参考苹果的代理方法
 - (BOOL)tableView:(UITableView *)tableView shouldSelectRow:(NSInteger)row;
 
 分类方法加前缀 ym_method
 初始化方法把 init 分隔开 例如 initWithxxx; 否则会报错。
 
 1.6 命名属性
 
 属性的第一个字母小写，后续单词首字母大写【见 @interface 中】
 
 1.7 成员变量
 
 成员变量使用 _xxxXx【见 @implementation 中】
 
 1.8 命名变量
 
 左右空格
 int a = 10;
 double b = 5.5;
 
 1.9 宏的命名
 
 宏必须全部都为大写，并且用 _ 划分开
 @define SCREEN_WIDTH 320.0
 
 1.10 定义一个枚举
 typedef NS_ENUM(NSInteger, YMHomeVCXXX) { // XXX 为用途
 YMHomeVCXXXDefault = 0,
 YMHomeVCXXXX = 1,
 YMHomeVCXXXX = 2,
 }
 
 八、iOS 规范
 8.1 变量
 8.1.1 变量名必须使用驼峰格式
 
 类、协议使用大驼峰：
 HomeViewController.h
 <HeaderViewDelegate>
 方法
 
 对象、局部变量使用小驼峰
 NSString *nameStr = @"";
 
 8.1.2 变量的名称必须同时包含功能和类型
 
 UIButton *addBtn; // 添加按钮
 UILabel *nameLab; // 名字标签
 NSString *addressStr; // 地址字符串
 UIImageView *iconImageV; // 头像图片
 
 8.1.3 系统常用类作实例变量声明时加入后缀
 
 UIViewController     VC
 UIView               View
 UILabel              Lab
 UIButton             Btn
 UIImage              Img
 UIImageView          ImgV
 NSArray              Array
 NSMutableArray       Marray
 NSDictionary         Dict
 NSMutableDictionary  Mdict
 NSString             Str
 NSMutableString      Mstr
 NSSet                Set
 NSMutableSet         Mset
 
 8.2 常量
 8.2.1 常量以相关类名作为前缀
 推荐这样写：【主要是后缀体现功能】
 static const NSTimeInterval kFadeOutAnimationDuration = 0.4;
 不推荐这样写：
 static const NSTimeInterval fadeOutTime = 0.4;
 
 8.2.2 建议使用类型常量，不建议使用 #define 预处理命令
 首先比较一下两种声明常量的区别：
 8.2.2.1 预处理指令：简单的文本替换，不包括类型信息，并且可被任意修改
 8.2.2.2 类型常量：包括类型信息，并且可以设置其使用范围，而且不可被修改
 
 使用预处理虽然能达到替换文本的目的，但是本身还是有局限性的：
 8.2.2.3 不具备类型信息。
 8.2.2.4 可以被任意修改。
 
 8.2.3 对外公开某个常量
 
 如果我们需要发送通知，那么就需要在不同的地方拿到通知的“频道”字符串（通知的名称），
 那么显然这个字符串是不能被轻易更改，而且可以在不同的地方获取。这个时候就需要定义一
 个外界可见的字符串常量。
 
 推荐这样写：
 //头文件
 extern NSString *const YMHomeViewControllerDidClearCacheNotification;
 //实现文件
 static NSString *const kDidClearCacheNotification = @"YMHomeViewControllerDidClearCacheNotification";
 static const CGFloat ZOCImageThumbnailHeight = 50.0f;
 
 不推荐这样写：
 #define CompanyName @"Apple Inc."
 #define magicNumber 42
 
 8.3 宏
 8.3.1 宏、常量名都要使用大写字母，用下划线‘_’分割单词。
 #define URL_GAIN_QUOTE_LIST @"/v1/quote/list"
 #define URL_UPDATE_QUOTE_LIST @"/v1/quote/update"
 #define URL_LOGIN  @"/v1/user/login”
 
 8.3.2 宏定义中如果包含表达式或变量，表达式和变量必须用小括号括起来。
 #define MY_MIN(A, B)  ((A)>(B)?(B):(A))
 
 不要注释未被使用的代码，确定不会使用的代码就删除
 
 析构函数-(void)dealloc最好放到类最上
 
 
 二、运算符
 
 2.1 运算符与变量之间的间隔
 2.1.1 一元运算符与变量之间没有空格：
 
 !bVaule;
 ~bVaule;
 ++iCount;
 *strSource;
 &fSum;
 
 2.1.2 二元运算符和变量之间必须有空格
 
 fWidth = 5 + 5;
 fLength = fWidth * 2;
 fHeight = fLength + fWidth;
 for (int i = 0; i < 10; i++)
 
 2.1.2 三元运算符和变量之间必须有空格
 
 fHeight = fLength + (fWidth > 0 ? 100 : 200);
 
 2.2 多个不同的运算符同时存在时应该用括号来明确优先级
 
 在多个不同的运算符同时存在的时候应该使合理使用括号，不要盲目依赖操作符优先级。
 因为有的时候不能保证阅读你代码的人就一定了解你写的算式里面所有操作符的优先级。
 
 来看一下这个算式：2 << 2 + 1 * 3 - 4 这里的<<是移位操作直观上却很容易认为
 它的优先级很高，所以就把这个算式误认为：(2 << 2) + 1 * 3 - 4 但事实上，它
 的优先级是比加减法还要低的，所以该算式应该等同于：2 << (2 + 1 * 3 - 4)。所以
 在以后写这种复杂一点的算式的时候，尽量多加一点括号，避免让其他人误解（甚至是自己）。
 
 三、变量
 3.1 一个变量有且只有一个功能，尽量不要把一个变量用作多种用途
 3.2 变量在使用前应该初始化，避免未初始化的变量被使用
 3.3 局部变量应该尽量接近使用他的地方
 推荐这样写：
 void someFunction() {
     int index = ...;
     // do something
 
     int count = ...;
     // do something;
 }
 
 不推荐这样写：
 void someFunction() {
     int index = ...;
     int count = ...;
     // do something
 
     // do something;
 }
 
 四、if 语句
 4.1 必须列出所有分支（穷举作用情况），而且每个分支都必须给出明确的结果
 
 推荐这样写：
 NSString *hintStr = @"";
 if (count < 3) {
    hintStr = @"Good";
 } else {
    hintStr = @"";
 }
 
 不推荐这样写：
 NSString *hintStr = @"";
 if (count < 3) {
    hintStr = @"Good";
 }
 
 4.2 不要有过多的分支，要善于使用 return 来提前返回错误的信息
 
 推荐这样写：
 - (void)something {
     if (!goodCondition) {
        return;
     }
 }
 
 不推荐这样写：
 - (void)something {
     if (goodCondition) {
 
     }
 }
 
 // 举个例子
 - (id)initWithDictionary:(NSDictionary*)dict error:(NSError)err {
     // 方法1. 参数为nil
     if (!dict) {
     if (err) *err = [JSONModelError errorInputIsNil];
        return nil;
     }
 
     //方法2. 参数不是nil，但也不是字典
     if (![dict isKindOfClass:[NSDictionary class]]) {
     if (err) *err = [JSONModelError errorInvalidDataWithMessage:@"Attempt to initialize JSONModel object using initWithDictionary:error: but the dictionary parameter was not an 'NSDictionary'."];
        return nil;
     }
 
     // 方法3. 初始化
     self = [self init];
     if (!self) {
     //初始化失败
        if (err) *err = [JSONModelError errorModelIsInvalid];
        return nil;
     }
 
     // 方法4. 检查用户定义的模型里的属性集合是否大于传入的字典里的key集合（如果大于，则返回NO）
     if (![self __doesDictionary:dict matchModelWithKeyMapper:self.__keyMapper error:err]) {
        return nil;
     }
 
     // 方法5. 核心方法：字典的key与模型的属性的映射
     if (![self __importDictionary:dict withKeyMapper:self.__keyMapper validation:YES error:err]) {
        return nil;
     }
 
     // 方法6. 可以重写[self validate:err]方法并返回NO，让用户自定义错误并阻拦model的返回
     if (![self validate:err]) {
        return nil;
     }
 
     // 方法7. 终于通过了！成功返回model
     return self;
 }
 
 4.3 条件表达式如果很长，则需要将他们提取出来赋给一个 BOOL 值。
 
 推荐这样写
 // 名字是否已经编辑
 BOOL nameIsExist = ![self.nameLabel.text isEqualToString:@""];
 // 年龄是否已经编辑
 BOOL ageIsExist = ![self.ageLabel.text isEqualToString:@""];
 // 页面是否已经编辑
 BOOL pageIsEdit = nameIsExist || ageIsExist;
 if (pageIsEdit) {
    // do something
 }
 
 不推荐这样写
 if (![self.nameLabel.text isEqualToString:@""] || ![self.ageLabel.text isEqualToString:@""]) {
    // do something
 }
 
 4.4 条件语句的判断应该是变量在左，常量在右
 
 推荐这样写
 if (count == 6) {
 }
 
 if (object == nil) {
 }
 
 不推荐这样写
 if (6 == count) {
 }
 
 if (nil == count) {
 }
 
 4.5 每个分支的实现都必须被大括号包围
 
 推荐这样写：
 if (!error) {
    return success;
 }
 
 不推荐这样写
 if (!error) return success;
 
 if (!error)
    return success;
 
 4.6* 条件过多过长的时候应该换行。
 
 推荐这样写
 if (condition1 &&
     condition2 &&
     condition3 &&
     condition4) {
    // do something
 }
 
 不推荐这样写
 if (condition1 && condition2 && condition3 && condition4) {
    // do something
 }
 
 *****方法参数过多也推荐这样写。
 
 4.7 for 语句
 
 4.7.1、不可在 for 循环内修改循环变量，防止 for 循环失去控制。
 for (int i = 0; i < 10; i++) {
    change(i);
 }
 
 4.7.2、避免使用 continue 和 break
 continue 和 break 所描述的是“什么时候不做什么”，所以为了读懂二者所在的代码，
 我们需要在头脑里将他们取反。
 
 其实最好不要让这两个东西出现，因为我们的代码只要体现出来“什么时候做什么”就好了，
 而且通过适当的方法，是可以将这两个东西消灭掉的。
 
 4.7.2.1 如果出现了 continue，只需要把 continue 的条件取反即可。
 NSArray *array = @[@"name", @"age", @"height", @"badName", @"badAge", @"badHeight"];
 NSMutableArray *arrayM = [[NSMutableArray alloc] init];
 for (int i = 0; i < array.count; i++) {
     if ([array[i] hasPrefix:@"bad"]) {
        continue;
     }
     [arrayM addObject:array[i]];
 }
 NSLog(@"%@", arrayM);
 
 我们可以看到，通过判断字符串里是否含有 "bad"这个 prefix 来过滤掉一些值，其实
 我们可以通过取反来避免使用 continue.
 NSArray *array = @[@"name", @"age", @"height", @"badName", @"badAge", @"badHeight"];
 NSMutableArray *arrayM = [[NSMutableArray alloc] init];
 for (int i = 0; i < array.count; i++) {
     if (![array[i] hasPrefix:@"bad"]) {
        [arrayM addObject:array[i]];
     }
 }
 NSLog(@"%@", arrayM);
 
 4.7.2.2 消除 while 里的 break：将 break 的条件取反，并合并到主循环里。
 while (condition1) {
     ...
     if (condition2) {
        break;
     }
 }
 
 // 取反合并
 while (!condition1 && !condition2) {
    ...
 }
 
 五 Switch 语句
 
 5.1 每个分支必须用大括号括起来
 推荐这样写：
 switch (integer) {
     case 1 : {
     }
     break;
     case 2 : {
     }
     break;
     default : {
     }
 }
 
 5.2 使用枚举时，不能有 default 分支，除了使用枚举之外，都必须有 default 分支
 switch (menuType) {
     case XXXmenuTypeMain : {
     }
     break;
     case XXXmenuTypeShow : {
     }
     break;
     case XXXmenuTypeSchedule : {
     }
     break;
 }
 
 在 Switch 语句使用枚举类型的时候，如果使用了 default 分支，在将来就无法通过
 编译器来检查新增的枚举类型了
 
 六、函数
 6.1 一个函数的长度必须限制在 50【视实际情况而定】 行内
 
 通常来说在阅读一个函数的时候，如果需要跨过很长的垂直距离会非常影响代码的阅读体验。
 如果需要来回滚动眼球才能看全一个方法，就会影响思维的连贯性，对阅读代码的速度造成
 比较大的影响。最好的情况是在不滚动眼球或代码的情况下一眼就能将该方法全部代码映入
 眼帘。
 
 6.2 一个函数只做一件事情（单一原则）
 
 每个函数的职责都应该划分的明确（就像类一样）
 推荐这样写：
 - (void)dataConfiguration {
 }
 - (void)viewConfiguration {
 }
 
 不推荐这样写
 - (void)dataConfiguration {
    ...
    [self viewConfiguration];
 }
 
 6.3 对于有返回值值的函数（方法），每个分支都必须有返回值
 推荐这样写：
 - (int)function {
     if (condition1) {
        return count1;
     } else if (condition2) {
        return count2;
     } else if (condition3) {
        return count3;
     } else if (condition4) {
        return count4;
     } else {
        return defaultCount;
     }
 }
 不推荐这样写：
 - (int)function {
     if (condition1) {
         return count1;
     } else if (condition2) {
         return count2;
     } else if (condition3) {
         return count3;
     } else if (condition4) {
         return count4;
     }
 }
 
 6.4 对于输入参数的正确性和有效性进行检查，参数错误立即返回
 if ([self.titleString isEqualToString:@""]) {
     return;
 }
 
 6.5 如果在不同的函数内部有相同的功能，应该把相同的功能抽取出来单独
 作为另一个函数
 
 6.6 将函数内部比较复杂的逻辑提取出来作为单独的函数
 
 一个函数内的不清晰（逻辑判断比较多，行数较多）的那片代码，往往可以被提取出去，构成
 一个新的函数，然后在原来的地方调用他这样你就可以使用有意义的函数名来代替注释，增加
 程序的可读性
 
 6.7 避免使用全局变量，类成员（class member）来传递信息，尽量使用局部变量和参数
 
 在一个类里面，经常会有传递某些变量的情况。而如果需要传递的变量是某个全局变量或者
 属性的时候，有些朋友不喜欢将他们作为参数，而是在内部就直接访问了。
 
 七、注释
 
 优秀的代码大部分是可以自描述的，我们完全可以用成代码本身来表达它到底是在干什么。
 而不需要注释的辅助。但并不是说，一定不能写注释，有一下三种情况比较适合写注释：
 
 7.1 公共接口（注释要告诉阅读代码的人，当前类能实现什么功能）。
 7.2 涉及到比较深层专业知识的代码（注释要体现出实现原理和思想）。
 7.3 容易产生歧义的代码（但严格来说，容易让人产生歧义的代码是不允许存在的）
 
 除了上述这三种情况，如果别人只能依靠注释才能读懂你的代码的时候，就要反思代码出现
 了什么问题。 最后，对于注释的内容，相对于“做了什么”，更应该说明“为什么这么做”。
 
 Code Review
 
 换行、注释、方法长度、代码重复等这些是通过机器检查出来的问题，是无需通过人来做的。
 
 而且除了审查需求的实现的程度，bug 是否无处藏身以外，更应该关注代码的设计。比如类与
 类之间的耦合程度，设计的可扩展性，复用性，是否可以将某些方法抽出来作为接口等等。
 
 */

#import "YMHomeViewController.h"
#import "YMDataSaveSingleton.h"
#import "YMTouchMoveView.h"
#import "YMHomeModel.h"

#import "MVVMViewController.h"
#import "YMDataStoreViewController.h"

@interface YMHomeViewController ()

/** 标题 */
@property (nonatomic, copy, readwrite) NSString *titleString;
/** 标题 */
@property (nonatomic, copy) NSString *titleStr;
/** 显示的透明度 */
@property (nonatomic, assign, getter = isShowAlpha) BOOL showAlpha;
/** lable 宽度 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelWidthCons;

/** 测试视图 */
@property (nonatomic, strong) YMTouchMoveView *testView;

/** 滚动视图 */
@property (nonatomic, strong) UIScrollView *scrollView;
/** 内容视图 */
@property (nonatomic, strong) UIView *contentView;

/** 显示金额的标签 */
@property (nonatomic, strong) UILabel *moneyLabel;

/** 数据模型 */
@property (nonatomic, strong) YMHomeModel *model;

/// MVVM 按钮
@property (nonatomic, readwrite, strong) UIButton *mvvmBtn;
/// 数据库 按钮
@property (nonatomic, readwrite, strong) UIButton *dataBtn;

@end

@implementation YMHomeViewController {
    /** 当前页数 */
    int _currentPage;
    /** 总页数 */
    int _totalPage;
}

#pragma mark -- 销毁
- (void)dealloc {
    NSLog(@"%@ --- dealloc", [self class]);
}

#pragma mark --
- (void)keyboardShowNoti:(NSNotification *)noti {
    NSLog(@"键盘出来了");
}

- (void)keyboardHideNoti:(NSNotification *)noti {
    NSLog(@"键盘隐藏了");
}

#pragma mark -- init
- (instancetype)init {
	if (self =[super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShowNoti:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHideNoti:) name:UIKeyboardWillHideNotification object:nil];
	}
	return self;
}

#pragma mark -- lifeStyle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 加载导航
    [self loadNavData];
    /// MARK: 加载视图
    [self loadSubViews];
    /// MARK: 配置属性
    [self configProperty];
    /// MARK: 布局视图
    [self layoutSubviews];
    // MARK: 初始化数据
    [self initData];
}

#pragma mark - - 导航数据
- (void)loadNavData {
    self.navigationItem.title = @"首页";
    
    [UIButton ym_button:self.mvvmBtn title:@"MVVM" fontSize:15 titleColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.mvvmBtn];
    [self.mvvmBtn addTarget:self action:@selector(mvvmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [UIButton ym_button:self.dataBtn title:@"DataStore" fontSize:15 titleColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.dataBtn];
    [self.dataBtn addTarget:self action:@selector(dataBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark -- 加载视图
- (void)loadSubViews {
    [self.view addSubview:self.scrollView];
//    [self.scrollView addSubview:self.testView];
    [self.scrollView addSubview:self.moneyLabel];
}

#pragma mark -- 配置属性
- (void)configProperty {
    self.moneyLabel.textAlignment = NSTextAlignmentCenter;
    self.moneyLabel.textColor = [UIColor redColor];
    self.moneyLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

#pragma mark -- 布局视图
- (void)layoutSubviews {
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(15);
        make.right.mas_equalTo(self.view.mas_right).offset(-15);
        make.top.mas_equalTo(self.view.mas_top).offset(15 + YMSCROLLVIEW_TOP_MARGIN);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(- 15 - TabBarHeight);
    }];
    
//    self.testView.frame = CGRectMake(15, 15, MainScreenWidth - 60, MainScreenHeight - NavBarHeight - TabBarHeight - 60);
    self.moneyLabel.frame = CGRectMake(0, 15, MainScreenWidth - 30, 30);
    self.scrollView.contentSize = CGSizeMake(MainScreenWidth - 30, self.contentView.bottom);
}

#pragma mark -- 初始化数据
- (void)initData {

    [YMDataSaveSingleton shareManager].nameStr = @"张三";
    [YMDataSaveSingleton shareManager].ageStr = @"25";
    [YMDataSaveSingleton shareManager].heightStr = @"180cm";
    
    [[YMDataSaveSingleton shareManager].idMArr removeAllObjects];
    for (int i = 0; i < arc4random_uniform(100)+10; i++) {
        [[YMDataSaveSingleton shareManager].idMArr addObject:@(i).description];
    }
}

#pragma mark -- touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    // MARK: 金额
    self.moneyLabel.text = [NSString formatDecimalNumber:[NSString stringWithFormat:@"%lu", (long)arc4random_uniform(1000000000)]];
    
    self.moneyLabel.text = [self.moneyLabel.text stringByAppendingString:[NSString stringWithFormat:@" - %@", [self.moneyLabel.text stringByReplacingOccurrencesOfString:@"," withString:@""]]];
    
    // MARK: 打印网络请求后部分数据
    NSLog(@"active_url == %@", self.model.active_url);
    NSLog(@"active_introduce == %@", self.model.active_introduce);
    NSLog(@"active_title == %@", self.model.active_title);
    NSLog(@"active_img == %@", self.model.active_img);
    
    // MARK: 打印单例存储数据
    NSLog(@"YMHomeViewController -- name=%@ -- age=%@ -- height=%@ -- id=%@",
          [YMDataSaveSingleton shareManager].nameStr,
          [YMDataSaveSingleton shareManager].ageStr,
          [YMDataSaveSingleton shareManager].heightStr,
          [YMDataSaveSingleton shareManager].idMArr);
}

#pragma mark - - mvvmBtnClick
- (void)mvvmBtnClick {
    MVVMViewController *vc = [[MVVMViewController alloc] init];
    vc.title = @"MVVMDemo";
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark 数据库
- (void)dataBtnClick {
    YMDataStoreViewController *vc = [[YMDataStoreViewController alloc] init];
    vc.title = @"数据存储";
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - - lazyLoadUI
- (YMTouchMoveView *)testView {
    if (_testView == nil) {
        _testView = [[YMTouchMoveView alloc] init];
    }
    return _testView;
}

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
    }
    return _scrollView;
}

- (UIView *)contentView {
    if (_contentView == nil) {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}

- (UILabel *)moneyLabel {
    if (_moneyLabel == nil) {
        _moneyLabel = [[UILabel alloc] init];
    }
    return _moneyLabel;
}

- (UIButton *)mvvmBtn {
    if (_mvvmBtn == nil) {
        _mvvmBtn = [[UIButton alloc] init];
    }
    return _mvvmBtn;
}

- (UIButton *)dataBtn {
    if (_dataBtn == nil) {
        _dataBtn = [[UIButton alloc] init];
    }
    return _dataBtn;
}
@end
