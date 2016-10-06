//
//  AppDelegate+ThirdSDK.h
//  KidsTC
//
//  Created by ling on 16/7/15.
//  Copyright © 2016年 KidsTC. All rights reserved.
//

#import "AppDelegate.h"

#import "GeTuiSdk.h"
#import "MTA.h"
#import "MTAConfig.h"
#import "UMMobClick/MobClick.h"

@interface AppDelegate (ThirdSDK) <GeTuiSdkDelegate, UIAlertViewDelegate>

-(void)registerGeTui;
- (void)registerMTAAndUmeng;
@end
