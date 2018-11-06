//
//  YMWKWebView.m
//  ShareDoctor
//
//  Created by iOS on 2018/6/7.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "YMWKWebView.h"
#import "YMWeakScriptMessageDelegate.h"

static const CGFloat progressHeight = 1.0f;
@interface YMWKWebView ()
<WKNavigationDelegate,
WKUIDelegate,
WKScriptMessageHandler>

/** 进度条 */
@property (nonatomic,weak) CALayer *progressLayer;

@end

@implementation YMWKWebView

#pragma mark -- dealloc
- (void)dealloc {
    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.wkWebView.scrollView removeObserver:self forKeyPath:@"contentOffset"];
    NSLog(@"dealloc -- %@", [self class]);
}

#pragma mark -- init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self=[super initWithFrame:frame]) {
        // KVO监听
        [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        [self.wkWebView.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        [self addSubview:self.progressView];
    }
    return self;
}

#pragma mark - KVO回馈
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressLayer.opacity = 1;
        if ([change[@"new"] floatValue] <[change[@"old"] floatValue]) {
            return;
        }
        self.progressLayer.frame = CGRectMake(0, 0, self.frame.size.width*[change[@"new"] floatValue], progressHeight);
        if ([change[@"new"]floatValue] == 1.0) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progressLayer.opacity = 0;
                self.progressLayer.frame = CGRectMake(0, 0, 0, progressHeight);
            });
        }
    } else if ([keyPath isEqualToString:@"contentOffset"]) {
        CGFloat y = self.wkWebView.scrollView.contentOffset.y;
        NSLog(@"contentOffsetY===%f", y);
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [webView evaluateJavaScript:@"document.body.scrollHeight"
              completionHandler:^(id result, NSError *_Nullable error) {
        NSLog(@"result%@", result);
    }];
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString:@"HelloWorld"]) {
        [self HelloWorld];
        NSLog(@"self.helloWorld === %@",message.body);
    }
}

- (void)HelloWorld {
    
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
   
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

#pragma mark -- setter
- (void)setWebViewUrl:(NSString *)webViewUrl {
    _webViewUrl = webViewUrl;
    /* 加载服务器url的方法*/
    NSString *url = self.webViewUrl;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [_wkWebView loadRequest:request];
}

- (void)setWebViewBarTintColor:(NSString *)webViewBarTintColor {
    _webViewBarTintColor = webViewBarTintColor;
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, 0, progressHeight);
    layer.backgroundColor = [UIColor colorWithHexString:self.webViewBarTintColor].CGColor;
    [_progressView.layer addSublayer:layer];
    self.progressLayer = layer;
}

#pragma mark -- lazyLoad
- (WKWebView *)wkWebView {
    if (_wkWebView==nil) {
        [self deleteWebCache];
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
        //是否支持JavaScript
        preferences.javaScriptEnabled = YES;
        //不通过用户交互，是否可以打开窗口
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        config.preferences = preferences;
        
        // 原生调用js方法
        //        [_wkWebView evaluateJavaScript:@"getAgree" completionHandler:^(id _Nullable data, NSError * _Nullable error) {
        //            NSLog(@"我被调用了");
        //        }];
        
        // 原生调用js方法
        //[webview evaluateJavaScript:“JS语句” completionHandler:^(id _Nullable data, NSError * _Nullable error) {
        //    }];
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height) configuration:config];
        _wkWebView.navigationDelegate = self;
        _wkWebView.UIDelegate = self;
        // 允许手势返回上级页面
        _wkWebView.allowsBackForwardNavigationGestures = YES;
        _wkWebView.scrollView.bounces = NO;
        [self addSubview:_wkWebView];
    }
    return _wkWebView;
}

- (UIView *)progressView {
    if (_progressView == nil) {
        _progressView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth , 4)];
        _progressView.backgroundColor = [UIColor clearColor];
    }
    return _progressView;
}
@end
