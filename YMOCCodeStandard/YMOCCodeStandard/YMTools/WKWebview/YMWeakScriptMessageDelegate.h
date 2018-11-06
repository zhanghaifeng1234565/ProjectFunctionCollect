//
//  YMWeakScriptMessageDelegate.h
//  YMOCCodeStandard
//
//  Created by iOS on 2018/10/23.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface YMWeakScriptMessageDelegate : NSObject<WKScriptMessageHandler>

@property (nonatomic, weak) id<WKScriptMessageHandler> scriptDelegate;

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate;
@end

NS_ASSUME_NONNULL_END
