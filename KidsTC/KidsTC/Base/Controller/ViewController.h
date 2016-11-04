//
//  ViewController.h
//  KidsTC
//
//  Created by 詹平 on 16/7/16.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReachabilityManager.h"
#import "FailureViewManager.h"

typedef enum : NSUInteger {
    NaviThemePink = 1,//默认粉色调
    NaviThemeWihte,//白色调调
} NaviTheme;

@interface ViewController : UIViewController
@property (nonatomic, strong) UIColor *naviColor;
@property (nonatomic, assign) long pageId;
@property (nonatomic, strong) NSString *pageUid;
@property (nonatomic, strong) NSDictionary *trackParams;
@property (nonatomic, strong) NSString *pageName;
@property (nonatomic, assign) CGFloat keyboardHeight;
@property (nonatomic, assign) NaviTheme naviTheme;
@property (nonatomic, assign) BOOL showFailurePage;
@property (nonatomic, copy) void(^failurePageActionBlock)();
- (void)back;
#pragma mark Notification
- (void)keyboardWillShow:(NSNotification *)noti;
- (void)keyboardWillDisappear:(NSNotification *)noti;
- (void)loadDataFailureAction:(BOOL)needCheckNetwork;
@end
