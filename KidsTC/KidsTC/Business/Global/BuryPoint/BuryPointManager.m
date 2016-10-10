//
//  BuryPointManager.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/8.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "BuryPointManager.h"
#import "UMMobClick/MobClick.h"

@implementation BuryPointManager
singleM(BuryPointManager)

+ (void)registerSdk {
    
    [self registerUmeng];
}

+ (void)registerUmeng {
    UMConfigInstance.appKey = @"57625e6f67e58ea042003764";
    UMConfigInstance.channelId = @"App Store";
    [MobClick setAppVersion:APP_VERSION];
    [MobClick startWithConfigure:UMConfigInstance];
#ifdef DEBUG
    [MobClick setLogEnabled:YES];
#else
    [MobClick setLogEnabled:NO];
#endif
}

+ (void)trackBegin:(NSString *)pageId {
    if (pageId.length<1) return;
    [MobClick beginLogPageView:pageId];
}

+ (void)trackEnd:(NSString *)pageId {
    if (pageId.length<1) return;
    [MobClick endLogPageView:pageId];
}

+ (void)trackEvent:(NSString *)event attributes:(NSDictionary *)attributes{
    [MobClick event:event attributes:attributes];
}

@end
