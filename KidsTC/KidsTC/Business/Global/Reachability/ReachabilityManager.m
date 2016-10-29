//
//  ReachabilityManager.m
//  KidsTC
//
//  Created by zhanping on 2016/9/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ReachabilityManager.h"

NSString *const kReachabilityStatusChangeNoti = @"ReachabilityStatusChangeNoti";

@interface ReachabilityManager ()
@property (nonatomic, strong) AFNetworkReachabilityManager *nrm;
@end

@implementation ReachabilityManager
singleM(ReachabilityManager)

- (void)startMonitoring {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _nrm = [AFNetworkReachabilityManager sharedManager];
        [_nrm startMonitoring];
        WeakSelf(self)
        [_nrm setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            StrongSelf(self)
            self.status = status;
            [NotificationCenter postNotificationName:kReachabilityStatusChangeNoti object:@(status)];
        }];
    });
}


@end
