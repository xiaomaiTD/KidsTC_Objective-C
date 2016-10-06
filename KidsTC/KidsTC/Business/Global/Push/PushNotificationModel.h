//
//  PushNotificationModel.h
//  KidsTC
//
//  Created by Altair on 11/30/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SegueModel.h"

typedef enum {
    PushNotificationStatusUnknow = 0,
    PushNotificationStatusHasRead,
    PushNotificationStatusUnread
}PushNotificationStatus;


typedef enum {
    MessageTypeRemoteNotification = 1,//推送通知
    MessageTypeUserCenter,//个人中心-消息中心
}MessageType;
typedef enum {
    RemindTypeNormol = 1,//常规推送
    RemindTypeSign,//签到提醒推送
    RemindTypeFlashBuy//闪购推送
}RemindType;



@interface PushNotificationModel : NSObject

@property (nonatomic, copy) NSString *identifier;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *createTimeDescription;

@property (nonatomic, copy) NSString *updateTimeDescription;

@property (nonatomic, assign) PushNotificationStatus status;

@property (nonatomic, strong) SegueModel *segueModel;

@property (nonatomic, assign) MessageType messageType;

@property (nonatomic, assign) RemindType remindType;

- (instancetype)initWithRawData:(NSDictionary *)data;

- (instancetype)initWithRemoteNotificationData:(NSDictionary *)data;

- (CGFloat)cellHeight;

@end
