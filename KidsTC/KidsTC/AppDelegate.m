//
//  AppDelegate.m
//  KidsTC
//
//  Created by 詹平 on 16/7/9.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "AppDelegate.h"

//ThirdPart
#import "SDWebImageManager.h"

//SDK
#import "iflyMSC/IFlyMSC.h"
#import "WeChatManager.h"
#import "KTCMapService.h"
#import "BuryPointManager.h"
#import <JSPatchPlatform/JSPatch.h>
#import "NotificationService.h"

#import "User.h"
#import "CookieManager.h"
#import "ReachabilityManager.h"
#import "SchemeManager.h"
#import "CoverManager.h"
#import "SynchronizeManager.h"

#import "TabBarController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self prepareForApplication];
    
    [NSThread sleepForTimeInterval:3];
    
    _window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    _window.backgroundColor = [UIColor whiteColor];
    _window.rootViewController = [TabBarController shareTabBarController];
    [_window makeKeyAndVisible];
    
    [[CoverManager shareCoverManager] showWelcome:^{
        [_window makeKeyAndVisible];
    }];
    
    return YES;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [SynchronizeManager synchronize];
    [[CoverManager shareCoverManager] showPoster:^{
        [_window makeKeyAndVisible];
    }];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [SynchronizeManager synchronize];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [SchemeManager openUrl:url];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    TCLog(@"AppDelegate---收到内存警告---！！！");
    [[SDImageCache sharedImageCache] clearMemory];
    [[SDWebImageManager sharedManager] cancelAll];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

#pragma mark - Notification

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [NotificationService didReceiveDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [NotificationService handleRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
}

- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [NotificationService resumeGt];
    completionHandler(UIBackgroundFetchResultNewData);
}

#pragma mark - private

- (void)prepareForApplication {
    
    [self JSPatchRemote:true];
    
    [self setupUserAgent];
    
    [[ReachabilityManager shareReachabilityManager] startMonitoring];
    
    [[User shareUser] checkLoginStatusFromServer];
    
    [[CookieManager shareCookieManager] setCookies];
    
    [SynchronizeManager synchronize];
    
    [WeChatManager sharedManager];
    
    [NotificationService regiterService];
    
    [BuryPointManager registerSdk];
    
    [[KTCMapService shareKTCMapService] startService];
    
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",@"57ea3553"];
    [IFlySpeechUtility createUtility:initString];
}

- (void)JSPatchRemote:(BOOL)remote{
    
    if (!remote) {
        [JSPatch testScriptInBundle];
    }else{
        [JSPatch setupLogger:^(NSString *msg) {
            TCLog(@"JSPatch-TCLog-:\n====\n\n%@\n\n=====", msg);
        }];
        [JSPatch startWithAppKey:@"20c782609295b915"];
#ifdef DEBUG
        [JSPatch setupDevelopment];
#endif
        [JSPatch sync];
    }
}


- (void)setupUserAgent {
    
    NSString *userAgent = [[UIWebView new] stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    TCLog(@"userAgent:%@",userAgent);
    NSString *extInfo = [NSString stringWithFormat:@"KidsTC/Iphone/%@", APP_VERSION];
    if ([userAgent rangeOfString:extInfo].location == NSNotFound) {
        NSString *newUserAgent = [NSString stringWithFormat:@"%@ %@", userAgent, extInfo];
        TCLog(@"newUserAgent:%@",newUserAgent);
        NSDictionary *dictionnary = [[NSDictionary alloc] initWithObjectsAndKeys:newUserAgent, @"UserAgent", nil];
        [USERDEFAULTS registerDefaults:dictionnary];
    }
}





@end
