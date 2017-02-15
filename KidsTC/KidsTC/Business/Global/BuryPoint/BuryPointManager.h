//
//  BuryPointManager.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/8.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Single.h"

//网络类型
typedef enum : NSUInteger {
    NetTypeNone = 0,
    NetTypeWIFI = 1,
    NetType2G = 2,
    NetType3G = 3,
    NetType4G = 4,
    NetType5G = 5,
} NetType;

@interface BuryPointManager : NSObject
singleH(BuryPointManager)

+ (void)startBuryPoint;

+ (void)trackBegin:(long)pageId
           pageUid:(NSString *)pageUid
          pageName:(NSString *)pageName
            params:(NSDictionary *)params;

+ (void)trackEnd:(long)pageId
         pageUid:(NSString *)pageUid
        pageName:(NSString *)pageName
          params:(NSDictionary *)params;

+ (void)trackEvent:(NSString *)eventName
          actionId:(long)actionId
            params:(NSDictionary *)params;

+ (NetType)NetworkStatusTo;

@end
