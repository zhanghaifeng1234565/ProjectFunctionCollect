//
//  YMWKWebViewViewController.h
//  YMUICommonlyUsedTools
//
//  Created by iOS on 2018/5/17.
//  Copyright © 2018年 iOS. All rights reserved.
//
/*
 
 YMDiseaseEncyclopediaRightModel *model = self.tableView.data[indexPath.row];
 YMDrugDisWKWebViewViewController *vc = [[YMDrugDisWKWebViewViewController alloc] init];
 vc.webViewUrl = model.linkurl;
 vc.webViewBarTintColor = @"ff3d3d";
 vc.itemId = model.itemid;
 vc.title = model.title;
 vc.titleNameStr = model.title;
 vc.shareThumb = model.thumb;
 vc.shareUrl = model.linkurl;
 vc.shareIntroduce = model.introduce;
 vc.type = @"2";
 [self.navigationController pushViewController:vc animated:YES];
 
 
 #import "YMWKWebViewViewController.h"
 
 @interface YMDrugDisWKWebViewViewController : YMWKWebViewViewController

 #pragma mark -- lifeStyle
 - (void)viewDidLoad {
 [super viewDidLoad];

 // js 调用 OC
 [self jsTransferOC];
 }
 
 #pragma mark -- js 调用 OC
 - (void)jsTransferOC
 {
 WS(ws);
 self.ymWKWebViewViewControllerJSBlock = ^(WKUserContentController *userContentController, WKScriptMessage *message) {
 if ([message.name isEqualToString:@"toGetData"]) {
 NSDictionary *result = [NSString dictionaryWithJsonString:message.body];
 if ([result[@"type"] intValue]==3) { // 药品详情的分享
 [[YMUMShareTools shareManger] shareTitle:ws.titleNameStr shareContent:ws.shareIntroduce imageUrl:ws.shareThumb shareUrl:ws.shareUrl currentVc:ws];
 }
 else if ([result[@"type"] intValue]==4) { // 收藏按钮点击调用
 //                [WDAlert showAlertWithMessage:[NSString stringWithFormat:@"%@", result[@"content"]] time:2.0f];
 }
 }
 };
 }
 
 */

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@class WKUserContentController,WKScriptMessage;

typedef void(^YMWKWebViewViewControllerJSBlock)(WKUserContentController *userContentController, WKScriptMessage *message);
@interface YMWKWebViewViewController : UIViewController<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler,UIScrollViewDelegate>

/** js 方法点击回调 */
@property (nonatomic, copy) YMWKWebViewViewControllerJSBlock ymWKWebViewViewControllerJSBlock;

/** 网页加载控件 */
@property (nonatomic, strong) WKWebView *wkWebView;
/** url 网址 */
@property (nonatomic, copy) NSString *webViewUrl;
/* 进度条颜色设置 */
@property (nonatomic, copy) NSString *webViewBarTintColor;
/* 可以自定义进度条 */
@property (nonatomic, retain) UIView *progressView;

@end
