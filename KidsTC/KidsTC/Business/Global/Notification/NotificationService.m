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
@property (nonatomic, strong) NSString *clientId;
@end

@implementation NotificationService
singleM(NotificationService)

#pragma mark - publick

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
    TCLog(@"deviceToken-:%@",deviceToken);
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    TCLog(@"\n>>>[DeviceToken Success]:%@\n\n", token);
    
    [NotificationService shareNotificationService].deviceToken = token;
    [GeTuiSdk registerDeviceToken:token];
}

+ (void)handleRemoteNotification:(NSDictionary *)notiInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [GeTuiSdk handleRemoteNotification:notiInfo];
    TCLog(@"handleRemoteNotification-:%@",notiInfo);
    NotificationModel *model = [NotificationModel modelWithDictionary:notiInfo];
    [[NotificationService shareNotificationService] deailWithNotiModel:model];
    completionHandler (UIBackgroundFetchResultNewData);
}

+ (void)resumeGt {
    [GeTuiSdk resume];
}

#pragma mark - UNUserNotificationCenterDelegate

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler  {
    TCLog(@"userNotificationCenter-willPresentNotification-");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UNNotificationPresentationOptions options =
        UNNotificationPresentationOptionBadge|
        UNNotificationPresentationOptionSound|
        UNNotificationPresentationOptionAlert;
        completionHandler (options);
        TCLog(@"userNotificationCenter-willPresentNotification-:\n\n===\n\n%@\n\n===\n\n",notification);
        TCLog(@"userInfo-:\n\n===\n\n%@\n\n===\n\n",notification.request.content.userInfo);
    });
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler {
    completionHandler ();
    TCLog(@"userNotificationCenter-didReceiveNotificationResponse-:\n%@",response);
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    TCLog(@"response.notification.request.content.userInfo-:\n%@",userInfo);
    NotificationModel *model = [NotificationModel modelWithDictionary:userInfo];
    [self deailWithNotiModel:model];
}

#pragma mark - GeTuiSdkDelegate

/** SDK启动成功返回cid */
- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId {
    //个推SDK已注册，返回clientId
    TCLog(@"\n>>>[GeTuiSdk RegisterClient]:%@\n\n", clientId);
    self.clientId = clientId;
    [self bindAccount:YES];
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
            if (SYSTEM_VERSION >= 10.0) {
                [self foreground_ios_10_push_noti:model];
            }else{
                [self foreground_ios_08_push_noti:model];
            }
        }
    } else {
        NSLog(@"payloadDic-error:%@",error);
    }
}

#pragma mark - GeTuiSdkDelegate Helper - 绑定账户

- (void)bindAccount:(BOOL)bind{//绑定账号
    
    NSUInteger type = 2;//解绑
    if (bind) {
        type = 1;//绑定
        [GeTuiSdk bindAlias:[User shareUser].uid andSequenceNum:@"seq-1"];
    } else {
        [GeTuiSdk unbindAlias:[User shareUser].uid andSequenceNum:@"seq-1"];
    }
    
    if (_clientId == nil) {
        _clientId = @"";
    }
    NSString *deviceId = self.deviceToken;
    if (![deviceId isNotNull]) {
        deviceId = @"";
    }
    NSDictionary *param = @{@"type":@(type),
                            @"clientId":_clientId,
                            @"deviceId":deviceId,
                            @"deviceType":@"2"};
    [Request startWithName:@"PUSH_REGISTER_DEVICE" param:param progress:nil success:nil failure:nil];
}

#pragma mark - App在前台的时候_在iOS8的操作系统中_根据model发出通知

- (void)foreground_ios_08_push_noti:(NotificationModel *)model {
    [UIAlertView alertBlock:^(NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            [self deailWithNotiModel:model];
        }
    } Title:model.title message:model.body cancelButtonTitle:@"忽略" otherButtonTitles:@"立即查看", nil];
}

#pragma mark - App在前台的时候_在iOS10的操作系统中_根据model发出通知

- (void)foreground_ios_10_push_noti:(NotificationModel *)model{
    
    UNMutableNotificationContent *content = [self notiContent:model];
    [self getAttachments:model resuleBlock:^(NSArray<UNNotificationAttachment *> *attachments, NSString *logStr) {
#ifdef DEBUG
        content.body = [NSString stringWithFormat:@"%@%@",content.body,logStr];
#endif
        [self startPushContent:content];
    }];
}

- (UNMutableNotificationContent *)notiContent:(NotificationModel *)model{
    UNMutableNotificationContent *content = [UNMutableNotificationContent new];
    content.body = model.body;
    content.categoryIdentifier = @"categoryIdentifier";
    content.title = model.title;
    return content;
}

- (void)startPushContent:(UNMutableNotificationContent *)content{
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:1 repeats:NO];
    NSString *requestWithIdentifier = @"requestWithIdentifier";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestWithIdentifier content:content trigger:trigger];
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (!error) {
            TCLog(@"添加通知成功--%@",request);
        }else{
            TCLog(@"添加通知失败--%@",error);
        }
    }];
}

- (void)getAttachments:(NotificationModel *)model resuleBlock:(void(^)(NSArray<UNNotificationAttachment *> *attachments, NSString *logStr))resultBlock {
    NSArray<NSString *> *urlStrs = model.medias;
#ifdef DEBUG
    NSMutableString *totalLogStr = [NSMutableString stringWithString:@"\n\n\n【标注：以下全部为日志信息，只有在debug调试状态下才会出现】"];
    NSString *urlStrsInfo = @"urlStrs为空";
    if (urlStrs.count>0) {
        urlStrsInfo = [self jsonStr:urlStrs];
    }
    [totalLogStr appendFormat:@"\n\n【======媒体资源数组信息======】\n\n%@",urlStrsInfo];
#endif
    if (urlStrs.count>0) {
        [self downloadMedias:urlStrs resuleBlock:^(NSArray<UNNotificationAttachment *> *attachments, NSString *logStr) {
#ifdef DEBUG
            NSArray *identifiers = [attachments valueForKeyPath:@"_identifier"];
            [totalLogStr appendFormat:@"\n\n【======媒体资源排序信息======】\n\n%@",[self jsonStr:identifiers]];
            [totalLogStr appendFormat:@"\n\n【======媒体资源下载信息======】\n\n%@====================",logStr];
#endif
            if (resultBlock) resultBlock(attachments,totalLogStr);
        }];
    }else{
#ifdef DEBUG
        [totalLogStr appendFormat:@"\n\n【======暂无媒体资源信息======】\n\n"];
#endif
        if (resultBlock) resultBlock(nil,totalLogStr);
    }
}

- (void)downloadMedias:(NSArray<NSString *> *)urlStrs resuleBlock:(void(^)(NSArray<UNNotificationAttachment *> *attachments, NSString *logStr))resultBlock{
    NSMutableArray<UNNotificationAttachment *> *attachments = [NSMutableArray array];
    NSMutableString *totalLogStr = [NSMutableString string];
    NSUInteger totalCount = urlStrs.count;
    __block NSUInteger currentCount = 0;
    [urlStrs enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [totalLogStr appendFormat:@"第%zd个媒体资源开始下载......-->\n\n",(idx+1)];
        [self downloadMedia:obj index:idx resuleBlock:^(UNNotificationAttachment *attachment, NSString *logStr) {
            currentCount ++;
            if (attachment) [attachments addObject:attachment];
            if (logStr.length>0) [totalLogStr appendString:logStr];
            if (totalCount == currentCount) {
                [self finishDownload:attachments logStr:totalLogStr resuleBlock:resultBlock];
            }
        }];
    }];
}

- (void)finishDownload:(NSArray<UNNotificationAttachment *> *)attachments logStr:(NSString *)logStr resuleBlock:(void(^)(NSArray<UNNotificationAttachment *> *attachments, NSString *log))resultBlock{
    NSArray<UNNotificationAttachment *> *storedAtts =
    [attachments sortedArrayUsingComparator:^NSComparisonResult(UNNotificationAttachment *obj1, UNNotificationAttachment *obj2) {
        NSNumber *num1 = @(obj1.identifier.integerValue);
        NSNumber *num2 = @(obj2.identifier.integerValue);
        return [num1 compare:num2];
    }];
    if (resultBlock) resultBlock(storedAtts,logStr);
}

- (void)downloadMedia:(NSString *)urlStr index:(NSUInteger)index resuleBlock:(void(^)(UNNotificationAttachment *attachment, NSString *logStr))resuleBlock{
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:urlStr] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        UNNotificationAttachment *attachment = nil;
        NSMutableString *logStr = [NSMutableString string];
        [logStr appendFormat:@">>>第%zd个媒体资源下载完成-开头:-->\n",(index+1)];
        if (!error) {
            [logStr appendFormat:@"下载成功-->\n"];
            NSString *filePath = [self filePath:urlStr];
            BOOL bWrite = [data writeToFile:filePath atomically:YES];
            if (bWrite) {
                [logStr appendFormat:@"写入成功-->\n"];
                NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
                if (fileUrl) {
                    [logStr appendFormat:@"fileUrl有值(%@)-->\n",fileUrl];
                    NSString *identifier = [NSString stringWithFormat:@"%zd",index];
                    NSError *attError = nil;
                    attachment = [UNNotificationAttachment attachmentWithIdentifier:identifier URL:fileUrl options:nil error:nil];
                    if (!attError && attachment) {
                        [logStr appendFormat:@"attachment创建成功(attachment:%@)-->\n",attachment];
                    }else{
                        [logStr appendFormat:@"attachment创建失败(原因:%@)-->\n",attError];
                    }
                }else{
                    [logStr appendFormat:@"fileUrl无值-->\n"];
                }
            }else{
                [logStr appendFormat:@"写入失败-->\n"];
            }
        }else{
            [logStr appendFormat:@"下载失败(原因:%@)-->\n",[self jsonStr:error.userInfo]];
        }
        [logStr appendFormat:@"第%zd个媒体资源下载完成-结尾:--<\n\n",(index+1)];
        if (resuleBlock) {
            resuleBlock(attachment,logStr);
        }
    }];
    [task resume];
}

- (NSString *)filePath:(NSString *)urlStr {
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *fileName = urlStr.lastPathComponent;
    NSRange range = [fileName rangeOfString:@"?"];
    if (range.length>0) {
        fileName = [fileName substringToIndex:range.location];
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    fileName = [fileName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
#pragma clang diagnostic pop
    NSString *filePath = [cachePath stringByAppendingPathComponent:fileName];
    return filePath;
}

- (NSString *)jsonStr:(id)object {
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&error];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if (!error) {
        return str;
    }else{
        return [NSString stringWithFormat:@"json转换失败-->\n【object:%@】-->\n【error:%@】",object,error];
    }
}

#pragma mark - 处理通知的点击事件

- (void)deailWithNotiModel:(NotificationModel *)model {
    [self readMessage:model];
    UINavigationController *navi = (UINavigationController *)[TabBarController shareTabBarController].selectedViewController;
    UIViewController *controller = navi.topViewController;
    controller.view.tag = NotificationSegueTag;
    [SegueMaster makeSegueWithModel:model.segueModel fromController:controller];
}

#pragma mark - 阅读消息

- (void)readMessage:(NotificationModel *)model {
    NSDictionary *params = @{@"ids":model.ID,
                             @"remindType":@(model.remindType),
                             @"messageType":@(model.messageType)};
    [Request startWithName:@"PUSH_USER_READ_MESSAGE" param:params progress:nil success:nil failure:nil];
}

@end
