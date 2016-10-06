//
//  KTCPushManager.m
//  KidsTC
//
//  Created by ling on 16/7/8.
//  Copyright © 2016年 KidsTC. All rights reserved.
//

#import "PushServiceManager.h"
#import "Request.h"
#import "User.h"
#define kDeviceToken (@"device_token")

@interface PushServiceManager()
@end

@implementation PushServiceManager 

singleM(PushServiceManager)

#pragma mark - read msg
- (void)readMessageWithIdentifier:(PushNotificationModel *)pushNotificationModel {

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:pushNotificationModel.identifier forKey:@"ids"];
    [params setObject:@(pushNotificationModel.remindType) forKey:@"remindType"];
    [params setObject:@(pushNotificationModel.messageType) forKey:@"messageType"];
    
    [Request startAndCallBackInChildThreadWithName:@"PUSH_USER_READ_MESSAGE" param:params success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        TCLog(@"Set read status succeed.");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        TCLog(@"Set read status failed.");
    }];
}

- (void)checkUnreadMessage:(void (^)(NSUInteger))succeed failure:(void (^)(NSError *))failure {
    
    [Request startAndCallBackInChildThreadWithName:@"PUSH_IS_UN_READ_MESSAGE" param:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        NSUInteger unreadCount = [self checkUnreadMessageSucceed:dic];
        if (succeed) {
            succeed(unreadCount);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (NSUInteger)checkUnreadMessageSucceed:(NSDictionary *)data {
    NSDictionary *countDic = [data objectForKey:@"data"];
    if (!data || ![data isKindOfClass:[NSDictionary class]]) {
        return 0;
    }
    NSUInteger count = [[countDic objectForKey:@"count"] integerValue];
    _unreadCount = count;
    //NSUInteger tabCount = [TabBarController shareTabBarController].viewControllers.count;
    if (count == 0) {
        //[[TabBarController shareTabBarController] setBadge:nil forTabIndex:tabCount - 1];
    } else {
        //        NSString *badgeString = [NSString stringWithFormat:@"%lu", (unsigned long)count];
        //[[TabBarController shareTabBarController] setBadge:@"" forTabIndex:tabCount - 1];
    }
    return count;
}
#pragma mark - 绑定账户
- (void)bindAccount:(BOOL)bind withClientId:(NSString *)clientId{//绑定账号
    
    NSUInteger type = 2;//解绑
    if (bind) {
        type = 1;//绑定
        // 绑定别名
        [GeTuiSdk bindAlias:[User shareUser].uid andSequenceNum:@"seq-1"];
    } else {
        [GeTuiSdk unbindAlias:[User shareUser].uid andSequenceNum:@"seq-1"];
    }
    
    if (clientId == nil) {
        clientId = @"";
    }
    self.clientId = clientId;
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:type], @"type", self.token, @"deviceId",@"2",@"deviceType",self.clientId,@"clientId",nil];
    [Request startAndCallBackInChildThreadWithName:@"PUSH_REGISTER_DEVICE" param:param success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
@end
