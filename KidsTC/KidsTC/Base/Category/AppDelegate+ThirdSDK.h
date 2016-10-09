//
//  AppDelegate+ThirdSDK.h
//  KidsTC
//
//  Created by ling on 16/7/15.
//  Copyright © 2016年 KidsTC. All rights reserved.
//

#import "AppDelegate.h"

#import "GeTuiSdk.h"

@interface AppDelegate (ThirdSDK) <GeTuiSdkDelegate, UIAlertViewDelegate>

-(void)registerGeTui;
@end
