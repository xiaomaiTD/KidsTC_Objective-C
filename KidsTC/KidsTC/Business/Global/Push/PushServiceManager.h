//
//  KTCPushManager.h
//  KidsTC
//
//  Created by ling on 16/7/8.
//  Copyright © 2016年 KidsTC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GeTuiSdk.h"
#import "Single.h"
#import "PushNotificationModel.h"

@interface PushServiceManager : NSObject  //添加个推的回调

@property (nonatomic, copy) NSString *appId;
@property (nonatomic, copy) NSString *appKey;
@property (nonatomic, copy) NSString *appSecret;

@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *clientId;
@property (nonatomic, assign) NSUInteger unreadCount;

singleH(PushServiceManager)

//服务器交互
- (void)readMessageWithIdentifier:(PushNotificationModel *)pushNotificationModel;
- (void)checkUnreadMessage:(void(^)(NSUInteger unreadCount))succeed failure:(void(^)(NSError *error))failure;
- (void)bindAccount:(BOOL)bind withClientId:(NSString *)clientId;
@end
