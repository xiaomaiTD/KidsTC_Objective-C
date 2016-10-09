//
//  BuryPointManager.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/8.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "BuryPointManager.h"
#import "MTA.h"
#import "MTAConfig.h"
#import "UMMobClick/MobClick.h"

@implementation BuryPointManager
singleM(BuryPointManager)

- (void)registerSdk {
    
    [self registerMta];
    
    [self registerUmeng];
}

- (void)registerMta {
    
    [MTA startWithAppkey:@"IGILB3C2N33P"];
    [[MTAConfig getInstance] setChannel:@"iphone"];
#ifdef DEBUG
    [[MTAConfig getInstance] setDebugEnable:YES];
    [[MTAConfig getInstance] setReportStrategy:MTA_STRATEGY_INSTANT];
#else
    [[MTAConfig getInstance] setDebugEnable:NO];
    [[MTAConfig getInstance] setReportStrategy:MTA_STRATEGY_BATCH];
    [[MTAConfig getInstance] setMinBatchReportCount:10];
#endif
}

- (void)registerUmeng {
    
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

- (void)trackBegin:(NSString *)pageId {
    if (pageId.length<1) return;
    [MTA trackPageViewBegin:pageId];
    [MobClick beginLogPageView:pageId];
}

- (void)trackEnd:(NSString *)pageId {
    if (pageId.length<1) return;
    [MTA trackPageViewEnd:pageId];
    [MobClick endLogPageView:pageId];
}

@end
