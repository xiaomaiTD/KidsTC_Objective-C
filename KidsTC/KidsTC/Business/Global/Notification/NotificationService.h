//
//  NotificationService.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/9.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Single.h"

@interface NotificationService : NSObject
singleH(NotificationService)
+ (void)regiterService;
+ (void)didReceiveDeviceToken:(NSData *)deviceToken;
+ (void)handleRemoteNotification:(NSDictionary *)notiInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;
+ (void)resumeGt;
@end
