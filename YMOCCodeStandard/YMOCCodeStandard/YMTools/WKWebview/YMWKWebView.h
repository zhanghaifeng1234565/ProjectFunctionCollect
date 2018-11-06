//
//  YMWKWebView.h
//  ShareDoctor
//
//  Created by iOS on 2018/6/7.
//  Copyright © 2018年 iOS. All rights reserved.
//

/*
 
 - (YMWKWebView *)wkWebView {
 if (_wkWebView==nil) {
 _wkWebView = [[YMWKWebView alloc] initWithFrame:CGRectMake(0, 45, MainScreenWidth-54, 433-51)];
 _wkWebView.wkWebView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 51, 0);
 _wkWebView.wkWebView.scrollView.showsHorizontalScrollIndicator = NO;
 _wkWebView.wkWebView.scrollView.showsVerticalScrollIndicator = NO;
 _wkWebView.webViewUrl = VISIT_PROTOCL_URL;
 _wkWebView.webViewBarTintColor = @"03abff";
 }
 return _wkWebView;
 }
 
 */

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface YMWKWebView : UIView

/** 网页加载控件 */
@property (nonatomic, strong) WKWebView *wkWebView;
/** url 地址 */
@property (nonatomic, copy) NSString *webViewUrl;
/* 进度条颜色设置 */
@property (nonatomic, copy) NSString *webViewBarTintColor;
/* 可以自定义进度条 */
@property (nonatomic, retain) UIView *progressView;

@end
