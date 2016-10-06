//
//  ReachabilityManager.h
//  KidsTC
//
//  Created by zhanping on 2016/9/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Single.h"
#import "AFNetworkReachabilityManager.h"

extern NSString *const kReachabilityStatusChangeNoti;

@interface ReachabilityManager : NSObject
singleH(ReachabilityManager)
@property (nonatomic, assign) AFNetworkReachabilityStatus status;
- (void)startMonitoring;
@end
