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

//Category
#import "AppDelegate+ThirdSDK.h"

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

#pragma mark - private

- (void)prepareForApplication {
    
    [self setupUserAgent];
    
    [[ReachabilityManager shareReachabilityManager] startMonitoring];
    
    [[User shareUser] checkLoginStatusFromServer];
    
    [[CookieManager shareCookieManager] setCookies];
    
    [SynchronizeManager synchronize];
    
    [WeChatManager sharedManager];
    
    [self registerGeTui];
    
    [self registerMTAAndUmeng];
    
    [[KTCMapService shareKTCMapService] startService];
    
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
