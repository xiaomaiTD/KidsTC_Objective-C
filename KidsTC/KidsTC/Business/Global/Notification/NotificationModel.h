//
//  NotificationModel.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/9.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SegueModel.h"

typedef enum {
    RemindTypeNormol = 1,//常规推送
    RemindTypeSign,//萝卜签到提醒推送
    RemindTypeFlashBuy//闪购推送
}RemindType;

typedef enum {
    MessageTypeRemoteNotification = 1,//推送通知
    MessageTypeUserCenter,//个人中心-消息中心
}MessageType;

@interface NotificationAlert : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subTitle;
@property (nonatomic, strong) NSString *body;
@end

@interface NotificationAps : NSObject
@property (nonatomic, strong) NotificationAlert *alert;
@property (nonatomic, assign) NSUInteger badge;
@property (nonatomic, strong) NSString *sound;
@end

@interface NotificationModel : NSObject
@property (nonatomic, strong) NotificationAps *aps;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) NSInteger open;
@property (nonatomic, assign) SegueDestination linkType;
@property (nonatomic, strong) NSString *params;
@property (nonatomic, strong) NSString *pushId;
@property (nonatomic, strong) NSString *remindId;
@property (nonatomic, assign) RemindType remindType;
@property (nonatomic, strong) NSArray<NSString *> *tcMedias;

/**SelfDefine*/
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) NSString *imgLocalUrlStr;
@property (nonatomic, assign) MessageType messageType;
@property (nonatomic, strong) SegueModel *segueModel;
@end
