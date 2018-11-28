//
//  YMMiddleMenuView.h
//  OAManagementSystem
//
//  Created by iOS on 2018/5/8.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BlockSelectedMenu)(NSInteger menuRow, NSString *filtratename, NSString *filtrateid);

@interface YMMiddleMenuView : UIView

/** 文字 */
@property (nonatomic, copy) NSArray *titleArray;
/** click */
@property (nonatomic, copy) BlockSelectedMenu blockSelectedMenu;
/** tableView 所在的位置 */
@property (nonatomic, assign) CGRect tabFrame;

@end
