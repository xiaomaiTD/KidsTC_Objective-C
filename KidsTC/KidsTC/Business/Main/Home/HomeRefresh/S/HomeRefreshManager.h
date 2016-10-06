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
extern NSString *const kHomeRefreshNewDataNoti;
@interface HomeRefreshManager : NSObject
singleH(HomeActivityManager)
@property (nonatomic, strong) HomeRefreshModel *model;
- (void)synchronize;
- (void)checkHomeRefreshPageWithTarget:(UIViewController *)target resultBlock:(void(^)())resultBlock;
@end
