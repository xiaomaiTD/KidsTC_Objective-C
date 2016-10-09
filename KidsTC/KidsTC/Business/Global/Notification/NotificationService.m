//
//  NotificationService.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/9.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NotificationService.h"

#import <UserNotifications/UserNotifications.h>
#import "GeTuiSdk.h"
#import "SDWebImageManager.h"

#import "GHeader.h"

#import "NSString+Category.h"
#import "UIAlertView+Category.h"

#import "NotificationModel.h"
#import "SegueMaster.h"
#import "TabBarController.h"

#ifdef DEBUG

static NSString *const appId = @"KdhK5MHOM57kadrvXU0Yp4";
static NSString *const appKey = @"HxAq4qojJp9VQLGUkatQ12";
static NSString *const appSecret = @"fLpjtBHcoK6q3SHcW6SMQ5";

//static NSString *const appId = @"sryMEjDUwEA6E2ABDgk2K1";
//static NSString *const appKey = @"ITwKdfkyuC9TedM9BjhwQ1";
//static NSString *const appSecret = @"LijC2jxi4z7tTsa9ZTM9j6";

#else

static NSString *const appId = @"sryMEjDUwEA6E2ABDgk2K1";
static NSString *const appKey = @"ITwKdfkyuC9TedM9BjhwQ1";
static NSString *const appSecret = @"LijC2jxi4z7tTsa9ZTM9j6";

#endif

@interface NotificationService ()<UNUserNotificationCenterDelegate,GeTuiSdkDelegate>
@property (nonatomic, strong) NSString *deviceToken;
@end

@implementation NotificationService
singleM(NotificationService)

+ (void) regiterService {
    
    [self registereGt];
    
    [self registerUserNotification];
}

+ (void)registereGt {
    
    [GeTuiSdk startSdkWithAppId:appId appKey:appKey appSecret:appSecret delegate:[NotificationService shareNotificationService]];
}

+ (void)registerUserNotification {
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    if (SYSTEM_VERSION >= 10.0){
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        UNAuthorizationOptions options = (UNAuthorizationOptionBadge   |
                                          UNAuthorizationOptionSound   |
                                          UNAuthorizationOptionAlert   |
                                          UNAuthorizationOptionCarPlay );
        [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                NSLog(@"用户授权成功");
            }else{
                NSLog(@"用户授权失败");
            }
        }];
        center.delegate = [NotificationService shareNotificationService];
    } else if (SYSTEM_VERSION >= 8.0) {
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        UIUserNotificationType types = (UIUserNotificationTypeAlert |
                                        UIUserNotificationTypeSound |
                                        UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    } else {
        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert |
                                                                       UIRemoteNotificationTypeSound |
                                                                       UIRemoteNotificationTypeBadge);
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
    }
#pragma clang diagnostic pop
}

+ (void)didReceiveDeviceToken:(NSData *)deviceToken {
    NSLog(@"deviceToken-:%@",deviceToken);
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"\n>>>[DeviceToken Success]:%@\n\n", token);
    
    [NotificationService shareNotificationService].deviceToken = token;
    [GeTuiSdk registerDeviceToken:token];
}
//在后台或者在杀死的情况下
+ (void)handleRemoteNotification:(NSDictionary *)notiInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [GeTuiSdk handleRemoteNotification:notiInfo];
    TCLog(@"handleRemoteNotification-:%@",notiInfo);
    NotificationModel *model = [NotificationModel modelWithDictionary:notiInfo];
    
    NSString *imgUrl = model.imgUrl;
    
    TCLog(@"NotificationService-开始下载图片-imgUrl-:%@",imgUrl);
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            TCLog(@"NotificationService-图片下载完毕:");
//            UIImage *image = [UIImage imageWithData:imageData];
//            if (image) {
//                TCLog(@"NotificationService-图片下载成功");
//                NSString *filePath = FILE_CACHE_PATH(imgUrl.lastPathComponent);
//                BOOL bWrite = [imageData writeToFile:filePath atomically:YES];
//                if (bWrite) {
//                    TCLog(@"NotificationService-图片写入成功");
//                    model.imgLocalUrlStr = filePath;
//                    [[NotificationService shareNotificationService] pushIOS10Noti:model];
//                }else{
//                    TCLog(@"NotificationService-图片写入失败");
//                }
//            }else{
//                TCLog(@"NotificationService-图片下载成功");
//            }
//        });
//    });
}

- (void)pushIOS10Noti:(NotificationModel *)model{
    
    UNMutableNotificationContent *content = [UNMutableNotificationContent new];
    if ([model.imgLocalUrlStr isNotNull]) {
        NSURL *url = [NSURL fileURLWithPath:model.imgLocalUrlStr];
        NSError *error = nil;
        UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:@"attachmentWithIdentifier" URL:url options:nil error:&error];
        if (!error && attachment) {
            content.attachments  = @[attachment];
        }
        TCLog(@"\n\nmodel.imgLocalUrlStr:%@ \n\nurl:%@ \n\nerror:%@ \n\nattachment:%@\n\n",model.imgLocalUrlStr,url,error,attachment);
    }
    content.badge = @(1);
    content.body = model.body;
    content.categoryIdentifier = @"categoryIdentifier";
    content.title = model.title;
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:1 repeats:NO];
    NSString *requestWithIdentifier = @"requestWithIdentifier";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestWithIdentifier content:content trigger:trigger];
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (!error) {
            NSLog(@"添加通知成功--requestWithIdentifier：%@",requestWithIdentifier);
        }
    }];
}

+ (void)resumeGt {
    [GeTuiSdk resume];
}

#pragma mark - UNUserNotificationCenterDelegate

//- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler  {
//    NSLog(@"userNotificationCenter-willPresentNotification-");
//    UNNotificationPresentationOptions options =
//    UNNotificationPresentationOptionBadge|
//    UNNotificationPresentationOptionSound|
//    UNNotificationPresentationOptionAlert;
//    completionHandler (options);
//    NSLog(@"userNotificationCenter-willPresentNotification-:\n\n===\n\n%@\n\n===\n\n",notification);
//    NSLog(@"userInfo-:\n\n===\n\n%@\n\n===\n\n",notification.request.content.userInfo);
//}
//
//- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler {
//    completionHandler ();
//    NSLog(@"userNotificationCenter-didReceiveNotificationResponse-:\n%@",response);
//}

#pragma mark - GeTuiSdkDelegate

/** SDK启动成功返回cid */
- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId {
    //个推SDK已注册，返回clientId
    TCLog(@"\n>>>[GeTuiSdk RegisterClient]:%@\n\n", clientId);
    [self bindAccount:YES withClientId:clientId];
}

/** SDK遇到错误回调 */
- (void)GeTuiSdkDidOccurError:(NSError *)error {
    TCLog(@"\n>>>[GexinSdk error]:%@\n\n", [error localizedDescription]);
}

/** SDK收到透传消息回调 */
- (void)GeTuiSdkDidReceivePayloadData:(NSData *)payloadData andTaskId:(NSString *)taskId andMsgId:(NSString *)msgId andOffLine:(BOOL)offLine fromGtAppId:(NSString *)appId {
    
    //收到个推消息
    NSString *payloadMsg = nil;
    if (payloadData) {
        payloadMsg = [[NSString alloc] initWithBytes:payloadData.bytes
                                              length:payloadData.length
                                            encoding:NSUTF8StringEncoding];
    }
    
    NSString *msg = [NSString stringWithFormat:@"taskId=%@,messageId:%@,payloadMsg:%@%@",taskId,msgId, payloadMsg,offLine ? @"<离线消息>" : @""];
    TCLog(@"\n>>>[GexinSdk ReceivePayload]:%@\n\n", msg);

    [GeTuiSdk sendFeedbackMessage:90001 andTaskId:taskId andMsgId:msgId];
    
    if (offLine) return;
    
    NSError *error = nil;
    NSDictionary *notiInfo = [NSJSONSerialization JSONObjectWithData:payloadData options:NSJSONReadingMutableContainers error:&error];
    if (!error) {
        NSLog(@"notiInfo-good:%@",notiInfo);
        if (notiInfo && [notiInfo isKindOfClass:[NSDictionary class]] && notiInfo.count>0) {
            NotificationModel *model = [NotificationModel modelWithDictionary:notiInfo];
            [self alertNotiModel:model];
        }
    } else {
        NSLog(@"payloadDic-error:%@",error);
    }
}

#pragma mark - GeTuiSdkDelegate helper



#pragma mark - 绑定账户

- (void)bindAccount:(BOOL)bind withClientId:(NSString *)clientId{//绑定账号
    
    NSUInteger type = 2;//解绑
    if (bind) {
        type = 1;//绑定
        [GeTuiSdk bindAlias:[User shareUser].uid andSequenceNum:@"seq-1"];
    } else {
        [GeTuiSdk unbindAlias:[User shareUser].uid andSequenceNum:@"seq-1"];
    }
    
    if (clientId == nil) {
        clientId = @"";
    }
    NSString *deviceId = self.deviceToken;
    if (![deviceId isNotNull]) {
        deviceId = @"";
    }
    NSDictionary *param = @{@"type":@(type),
                            @"clientId":clientId,
                            @"deviceId":deviceId,
                            @"deviceType":@"2"};
    [Request startWithName:@"PUSH_REGISTER_DEVICE" param:param progress:nil success:nil failure:nil];
}

#pragma mark - 阅读消息

- (void)readMessage:(NotificationModel *)model {
    NSDictionary *params = @{@"ids":model.ID,
                             @"remindType":@(model.remindType),
                             @"messageType":@(model.messageType)};
    [Request startWithName:@"PUSH_USER_READ_MESSAGE" param:params progress:nil success:nil failure:nil];
}

- (void)alertNotiModel:(NotificationModel *)model {
    [UIAlertView alertBlock:^(NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            [self deailWithNotiModel:model];
        }
    } Title:model.title message:model.body cancelButtonTitle:@"忽略" otherButtonTitles:@"立即查看", nil];
}

- (void)deailWithNotiModel:(NotificationModel *)model {
    [self readMessage:model];
    UINavigationController *navi = (UINavigationController *)[TabBarController shareTabBarController].selectedViewController;
    UIViewController *controller = navi.topViewController;
    controller.view.tag = NotificationSegueTag;
    [SegueMaster makeSegueWithModel:model.segueModel fromController:controller];
}

@end
