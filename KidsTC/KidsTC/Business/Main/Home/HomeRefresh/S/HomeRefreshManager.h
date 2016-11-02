//
//  HomeRefreshManager.h
//  KidsTC
//
//  Created by zhanping on 2016/9/20.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHeader.h"
#import "HomeRefreshModel.h"
#import "HomeRefreshViewController.h"
#import "HomeRefreshGuideView.h"

extern NSString *const kHomeRefreshNewDataNoti;
@interface HomeRefreshManager : NSObject
singleH(HomeRefreshManager)
@property (nonatomic, strong) HomeRefreshModel *model;
@property (nonatomic, assign) BOOL hasSuprise;
- (void)synchronize;
- (void)checkHomeRefreshPageWithTarget:(UIViewController *)target resultBlock:(void(^)())resultBlock;
- (void)checkHomeRefreshGuideWithTarget:(UIViewController *)target top:(CGFloat)top resultBlock:(void(^)())resultBlock;
@end
