//
//  YMWKWebViewViewController.m
//  YMUICommonlyUsedTools
//
//  Created by iOS on 2018/5/17.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMWKWebViewViewController.h"
#import <WebKit/WebKit.h>
#import "YMWeakScriptMessageDelegate.h"

@interface YMWKWebViewViewController ()

/** 进度条 */
@property (nonatomic,weak) CALayer *progressLayer;
/** 关闭按钮 */
@property (nonatomic,retain) UIBarButtonItem *closeButtonitem;
/** 返回按钮 */
@property (nonatomic,retain) UIBarButtonItem *customBackBarItem;

@end

@implementation YMWKWebViewViewController

#pragma mark -- dealloc
- (void)dealloc {
    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.wkWebView removeObserver:self forKeyPath:@"title"];
    [self.wkWebView.scrollView removeObserver:self forKeyPath:@"contentOffset"];
    NSLog(@"dealloc -- %@", [self class]);
}

#pragma mark -- lifeStyle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    // KVO监听
    [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.wkWebView.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    [self.wkWebView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    [self.view addSubview:self.progressView];
}

#pragma mark - KVO回馈
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    [self updataNavigationitems];
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressLayer.opacity = 1;
        if ([change[@"new"] floatValue] <[change[@"old"] floatValue]) {
            return;
        }
        self.progressLayer.frame = CGRectMake(0, 0, self.view.frame.size.width*[change[@"new"] floatValue], 3);
        if ([change[@"new"]floatValue] == 1.0) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progressLayer.opacity = 0;
                self.progressLayer.frame = CGRectMake(0, 0, 0, 3);
            });
        }
    } else if ([keyPath isEqualToString:@"title"]){
        self.title = change[@"new"];
    } else if ([keyPath isEqualToString:@"contentOffset"]) {
        CGFloat y = self.wkWebView.scrollView.contentOffset.y;
        NSLog(@"contentOffsetY===%f", y);
    }
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {
    if (self.ymWKWebViewViewControllerJSBlock) {
        self.ymWKWebViewViewControllerJSBlock(userContentController, message);
    }
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [webView evaluateJavaScript:@"document.body.scrollHeight" completionHandler:^(id result, NSError * _Nullable error) {
        NSLog(@"resultHeight=%@", result);
    }];
    
    [self.wkWebView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none';" completionHandler:^(id object, NSError * error) {
        
    }];
}

#pragma  mark - updata nav items
- (void)updataNavigationitems {
    if (self.wkWebView.canGoBack) {
        UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        [self.navigationItem setLeftBarButtonItems:@[self.closeButtonitem] animated:NO];
        
        // 弃用customBackBarItem，使用原生backButtonItem
        [self.navigationItem setLeftBarButtonItems:@[spaceButtonItem,self.customBackBarItem,self.closeButtonitem] animated:NO];
    } else {
        [self.navigationItem setLeftBarButtonItems:@[self.customBackBarItem] animated:NO];
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return nil;
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    //    DLOG(@"msg = %@ frmae = %@",message,frame);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [alertController addAction:([UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text?:@"");
    }])];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark -- 清除缓存
- (void)deleteWebCache {
    NSString *libraryDir = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,
                                                               NSUserDomainMask, YES)[0];
    NSString *bundleId = [[[NSBundle mainBundle] infoDictionary]
                          objectForKey:@"CFBundleIdentifier"];
    NSString *webkitFolderInLib = [NSString stringWithFormat:@"%@/WebKit",libraryDir];
    NSString *webKitFolderInCaches = [NSString
                                      stringWithFormat:@"%@/Caches/%@/WebKit",libraryDir,bundleId];
    NSString *webKitFolderInCachesfs = [NSString
                                        stringWithFormat:@"%@/Caches/%@/fsCachedData",libraryDir,bundleId];
    
    NSError *error;
    /* iOS8.0 WebView Cache的存放路径 */
    [[NSFileManager defaultManager] removeItemAtPath:webKitFolderInCaches error:&error];
    [[NSFileManager defaultManager] removeItemAtPath:webkitFolderInLib error:nil];
    
    /* iOS7.0 WebView Cache的存放路径 */
    [[NSFileManager defaultManager] removeItemAtPath:webKitFolderInCachesfs error:&error];
}

#pragma mark -- 返回按钮点击调用
- (void)customBackItemClicked {
    if ([self.wkWebView canGoBack]) {
        [self.wkWebView goBack];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark -- 关闭按钮点击调用
- (void)closeButtonClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- lazyLoad
- (WKWebView *)wkWebView {
    if (_wkWebView==nil) {
        
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        config.selectionGranularity = WKSelectionGranularityDynamic;
        config.allowsInlineMediaPlayback = YES;
        
        WKUserContentController *userController = [WKUserContentController new];
        NSString *js = @"$('meta[name=description]').remove(); $('head').append( '<meta name=\"viewport\" content=\"width=device-width, initial-scale=1,user-scalable=no\">' );";
        WKUserScript *script = [[WKUserScript alloc] initWithSource:js injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:NO];
        [userController addUserScript:script];
        /* 添加用户与js交互的方法
         name: 方法名（JS只能向原生传递一个参数，所以如果有多个参数需要传递，可以让JS传递对象或者JSON字符串即可。）
         */
        [userController addScriptMessageHandler:[[YMWeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"toGetData"];
        config.userContentController = userController;
        
        WKPreferences *preferences = [WKPreferences new];
        // 是否支持JavaScript
        preferences.javaScriptEnabled = YES;
        // 不通过用户交互，是否可以打开窗口
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        config.preferences = preferences;
        
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight - NavBarHeight) configuration:config];
        
        NSString *url = self.webViewUrl;
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        [_wkWebView loadRequest:request];
        _wkWebView.navigationDelegate = self;
        _wkWebView.UIDelegate = self;
        _wkWebView.scrollView.delegate = self;
        _wkWebView.scrollView.showsHorizontalScrollIndicator = NO;
        _wkWebView.scrollView.bounces = NO;
        // 允许手势返回上级页面
        _wkWebView.allowsBackForwardNavigationGestures = YES;
        [self.view addSubview:_wkWebView];
    }
    return _wkWebView;
}

- (UIView *)progressView {
    if (_progressView == nil) {
        _progressView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,MainScreenWidth , 3)];
        _progressView.backgroundColor = [UIColor clearColor];
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, 0, 3);
        layer.backgroundColor = [UIColor colorWithHexString:self.webViewBarTintColor].CGColor;
        [_progressView.layer addSublayer:layer];
        self.progressLayer = layer;
    }
    return _progressView;
}

// 返回按钮
-(UIBarButtonItem*)customBackBarItem {
    if (!_customBackBarItem) {
        UIImage *backItemImage = [[UIImage imageNamed:@"fanhui"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        UIButton* backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton setTitleColor:self.navigationController.navigationBar.tintColor forState:UIControlStateNormal];
        [backButton setTitleColor:[self.navigationController.navigationBar.tintColor colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
        [backButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
        [backButton setImage:backItemImage forState:UIControlStateNormal];
        
        [backButton addTarget:self action:@selector(customBackItemClicked) forControlEvents:UIControlEventTouchUpInside];
        _customBackBarItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    }
    return _customBackBarItem;
}

#pragma mark -- 关闭
- (UIBarButtonItem *)closeButtonitem {
    if (_closeButtonitem == nil) {
        UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [closeButton setTitle:@"关闭" forState:UIControlStateNormal];
        [closeButton setTitleColor:self.navigationController.navigationBar.tintColor forState:UIControlStateNormal];
        [closeButton setTitleColor:[self.navigationController.navigationBar.tintColor colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
        [closeButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [closeButton addTarget:self action:@selector(closeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _closeButtonitem = [[UIBarButtonItem alloc] initWithCustomView:closeButton];
    }
    return _closeButtonitem;
}
@end
