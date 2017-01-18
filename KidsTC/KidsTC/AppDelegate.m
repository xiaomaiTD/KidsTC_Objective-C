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
#import "WeChatManager.h"
#import "KTCMapService.h"
#import "BuryPointManager.h"
#import "JSPatch.h"
#import "NotificationService.h"
#import <Bugly/Bugly.h>

#import "User.h"
#import "CookieManager.h"
#import "ReachabilityManager.h"
#import "SchemeManager.h"
#import "CoverManager.h"
#import "SynchronizeManager.h"
#import "ScreenshotManager.h"
#import "TCTimer.h"

#import "TabBarController.h"

@interface AppDelegate ()

@end

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
    [SynchronizeManager synchronizeEnterForeground];
    [[CoverManager shareCoverManager] showPoster:^{
        [_window makeKeyAndVisible];
    }];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    UIViewController *topVC = [self topVC];
    if (topVC && [topVC respondsToSelector:@selector(viewDidAppear:)]) {
        [topVC viewDidAppear:YES];
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [SynchronizeManager synchronizeEnterBackground];
    UIViewController *topVC = [self topVC];
    if (topVC && [topVC respondsToSelector:@selector(viewDidDisappear:)]) {
        [topVC viewDidDisappear:YES];
    }
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [SchemeManager openUrl:url];
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    return self.window.rootViewController.supportedInterfaceOrientations;
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
    
    [self setupUserAgent];
    
    [self JSPatchRemote:YES];
    
    [Bugly startWithAppId:@"dcdb33fdf5"];
    
    [[ReachabilityManager shareReachabilityManager] startMonitoring];
    
    [[User shareUser] checkLoginStatusFromServer];
    
    [[CookieManager shareCookieManager] setCookies];
    
    [SynchronizeManager synchronizeEnterForeground];
    
    [WeChatManager sharedManager];
    
    [NotificationService regiterService];
    
    [BuryPointManager startBuryPoint];
    
    [[KTCMapService shareKTCMapService] startService];
    
    [[ScreenshotManager shareScreenshotManager] startService];
    
    [TCTimer shareTCTimer];
}

- (void)JSPatchRemote:(BOOL)remote{
    
    if (!remote) {
        [JSPatch testScriptInBundle];
    }else{
        [JSPatch setupLogger:^(NSString *msg) {
            TCLog(@"JSPatch-TCLog-:\n====\n\n%@\n\n=====", msg);
        }];
        [JSPatch startWithAppKey:@"5e2b0e78134a2551"];
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
        [USERDEFAULTS synchronize];
    }
}

// 获取当前处于activity状态的view controller
- (UIViewController *)topVC
{
    UIViewController* activityViewController = nil;
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if(window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow *tmpWin in windows)
        {
            if(tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    NSArray *viewsArray = [window subviews];
    if([viewsArray count] > 0)
    {
        UIView *frontView = [viewsArray objectAtIndex:0];
        
        id nextResponder = [frontView nextResponder];
        
        if([nextResponder isKindOfClass:[UIViewController class]])
        {
            activityViewController = nextResponder;
        }
        else
        {
            activityViewController = window.rootViewController;
        }
    }
    
    UIViewController *topVC = nil;
    
    if ([activityViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navi = (UINavigationController *)activityViewController;
        topVC = navi.topViewController;
        if (!topVC) {
            topVC = navi.visibleViewController;
        }
    }
    
    if (!topVC) {
        topVC = activityViewController.presentedViewController;
    }
    
    if (!topVC) {
        topVC = activityViewController;
    }
    
    return topVC;
}




@end
