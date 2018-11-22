//
//  YMGifImageView.h
//  YMOAManageSystem
//
//  Created by iOS on 2018/11/21.
//  Copyright © 2018 iOS. All rights reserved.
//
/*
 // 通过 json
 NSString *jsonStr = [[NSBundle mainBundle] pathForResource:@"OARefreshHeader" ofType:@"json"];
 NSData *data = [[NSData alloc] initWithContentsOfFile:jsonStr];
 NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
 [self.gifImageV setAnimationJsonDict:jsonDict];
 
 // 通过本地文件
 [self.gifImageV setAnimationFileName:@"OARefreshHeader"];
 
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YMGifImageView : UIView

/**
 通过文件名字设置

 @param fileName 文件名
 */
- (void)setAnimationFileName:(NSString *)fileName;


/**
 通过 json 设置

 @param jsonDict jsonDict
 */
- (void)setAnimationJsonDict:(NSDictionary *)jsonDict;


@end

NS_ASSUME_NONNULL_END
