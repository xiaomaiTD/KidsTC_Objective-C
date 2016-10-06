//
//  AppDelegate+ThirdSDK.m
//  KidsTC
//
//  Created by ling on 16/7/15.
//  Copyright © 2016年 KidsTC. All rights reserved.
//

#import "AppDelegate+ThirdSDK.h"
#import <objc/runtime.h>

#import "PushNotificationModel.h"
#import "PushServiceManager.h"
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

const char *key = "payloadKey";
@implementation AppDelegate (ThirdSDK)

#pragma mark-
#pragma mark 属性
-(void)setPayload:(NSDictionary *)payload{
    
    objc_setAssociatedObject(self, key, payload, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSDictionary *)payload{
    
    return objc_getAssociatedObject(self, key);
}

#pragma mark-
#pragma mark public
-(void)registerMTAAndUmeng{
    
    //注册友盟
    UMConfigInstance.appKey = @"57625e6f67e58ea042003764";
    UMConfigInstance.channelId = @"App Store";
    [MobClick setAppVersion:APP_VERSION];
    [MobClick startWithConfigure:UMConfigInstance];
    
    //注册MTA
    [MTA startWithAppkey:@"IGILB3C2N33P"];
    [[MTAConfig getInstance] setChannel:@"iphone"];

#ifdef DEBUG
    [[MTAConfig getInstance] setDebugEnable:YES];
    [[MTAConfig getInstance] setReportStrategy:MTA_STRATEGY_INSTANT];
    [MobClick setLogEnabled:YES];
#else
    [[MTAConfig getInstance] setDebugEnable:NO];
    [[MTAConfig getInstance] setReportStrategy:MTA_STRATEGY_BATCH];
    [[MTAConfig getInstance] setMinBatchReportCount:10];
    [MobClick setLogEnabled:NO];
#endif
}

-(void)registerGeTui{
    
    // 通过个推平台分配的appId、 appKey 、appSecret 启动SDK，注：该方法需要在主线程中调用
    [GeTuiSdk startSdkWithAppId:appId appKey:appKey appSecret:appSecret delegate:self];
    
    // 注册APNS
    [self registerUserNotification];
    //NSLog(@"option:%@",option);
    
    //注册通知
    [NotificationCenter addObserver:self selector:@selector(clearBadgeCount) name:UIApplicationDidBecomeActiveNotification object:nil];

}

#pragma mark - 复写appDelegate方法
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler{//杀死状态下 或 后台进入都会走此方法
    // 处理APNs代码，通过userInfo可以取到推送的信息（包括内容，角标，自定义参数等）。如果需要弹窗等其他操作，则需要自行编码。
    NSLog(@"\n>>>[Receive RemoteNotification - Background Fetch]:%@\n\n",userInfo);
    [self handleReceivedNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    TCLog(@"deviceToken--:%@",deviceToken);
    [self connectGeTuiWithToken:deviceToken];
    
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err{
    
    NSLog(@"注册远程通知失败:%@",err.description);
    [MTA trackError:err.description];
}

- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    /// Background Fetch 恢复SDK 运行
    [GeTuiSdk resume];
    completionHandler(UIBackgroundFetchResultNewData);
}



#pragma mark-
#pragma mark 远程通知

-(void)connectGeTuiWithToken:(NSData *)deviceToken{
    
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"\n>>>[DeviceToken Success]:%@\n\n", token);
    
    //向个推服务器注册deviceToken
    [GeTuiSdk registerDeviceToken:token];
    
    [PushServiceManager sharePushServiceManager].token = token;
}

-(void)registerUserNotification{ //注册APNS
    
#ifdef __IPHONE_8_0
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        
        UIUserNotificationType types = (UIUserNotificationTypeAlert |
                                        UIUserNotificationTypeSound |
                                        UIUserNotificationTypeBadge);
        
        UIUserNotificationSettings *settings;
        settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        
    } else {
        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert |
                                                                       UIRemoteNotificationTypeSound |
                                                                       UIRemoteNotificationTypeBadge);
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
    }
#else
    UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert |
                                                                   UIRemoteNotificationTypeSound |
                                                                   UIRemoteNotificationTypeBadge);
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
#endif
}

#pragma mark-
#pragma mark GeTui回调
#pragma mark-
#pragma mark 个推debug
/** SDK启动成功返回cid */
- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId {
    //个推SDK已注册，返回clientId
    TCLog(@"\n>>>[GeTuiSdk RegisterClient]:%@\n\n", clientId);
    [[PushServiceManager sharePushServiceManager] bindAccount:YES withClientId:clientId];
}

/** SDK遇到错误回调 */
- (void)GeTuiSdkDidOccurError:(NSError *)error {
    //个推错误报告，集成步骤发生的任何错误都在这里通知，如果集成后，无法正常收到消息，查看这里的通知。
    TCLog(@"\n>>>[GexinSdk error]:%@\n\n", [error localizedDescription]);
}

/** SDK收到透传消息回调 */
- (void)GeTuiSdkDidReceivePayloadData:(NSData *)payloadData andTaskId:(NSString *)taskId andMsgId:(NSString *)msgId andOffLine:(BOOL)offLine fromGtAppId:(NSString *)appId {
    
    if (offLine) return; //如果为离线消息 一律在个推回调里不处理
    //收到个推消息
    NSDictionary *payDic = nil;
    if (payloadData) {
        //转字典
        payDic = [NSJSONSerialization JSONObjectWithData:payloadData options: NSJSONReadingAllowFragments error:NULL];
    }
    TCLog(@"GeTuiDic:%@",payDic);
    
    //赋值给alertView
    if (![payDic isKindOfClass:[NSDictionary class]]) return;
    
    self.payload = payDic;
    TCLog(@"payload-----%@",self.payload);
    NSString *title = [payDic objectForKey:@"title"] ? [payDic objectForKey:@"title"] : @"消息";
    NSString *content = [payDic objectForKey:@"content"] ? [payDic objectForKey:@"content"] : @"您有新的消息!";
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:content delegate:self cancelButtonTitle:@"忽略" otherButtonTitles:@"立即查看", nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alertView show];
    });
    
}

#pragma mark-
#pragma mark delegate
//alertView代理
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        
        [self launchWithPushPayload:self.payload];
        self.payload = nil;
        
    }
}
#pragma mark-
#pragma mark 通知
- (void)clearBadgeCount{
    
    //把通知的badgeNumber设置为0
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];

}
#pragma mark-
#pragma mark private
- (void)handleReceivedNotification:(NSDictionary *)userInfo {//apns传递远程消息后 调用
    
    self.payload = userInfo;
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if([app.window.rootViewController isKindOfClass:[TabBarController class]]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self launchWithPushPayload:userInfo];
        });
    } else {
        //程序正在启动
        double delayInSeconds = 0.5;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self launchWithPushPayload:userInfo];
        });
    }
    
}


-(void)launchWithPushPayload:(NSDictionary *)payload{//页面跳转方法 点击查看远程消息 或 点击弹框调用
    
    PushNotificationModel *model = [[PushNotificationModel alloc] initWithRemoteNotificationData:payload];
    
    if (!model || model.segueModel.destination == SegueDestinationNone) {
        return;
    }
    
    [[PushServiceManager sharePushServiceManager] readMessageWithIdentifier:model];
    
    [self didRecievedRemoteNotificationWithModel:model];
    
    self.payload = nil;
    
}

- (void)didRecievedRemoteNotificationWithModel:(PushNotificationModel *)model {//跳转方法
    
    if (!model) return;
    
    TabBarController *tabVC = [TabBarController shareTabBarController];
    UINavigationController *navi = tabVC.viewControllers[tabVC.selectedIndex];
    UIViewController *vc = navi.topViewController;
    if (vc) {
        vc.view.tag = NotificationSegueTag;
        //展示消息跳转页面
        [SegueMaster makeSegueWithModel:model.segueModel fromController:vc];
    }
}

#pragma mark-
#pragma mark dealloc
-(void)dealloc{
    [NotificationCenter removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}
@end
