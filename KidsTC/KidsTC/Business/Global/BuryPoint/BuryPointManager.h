//
//  BuryPointManager.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/8.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Single.h"
@interface BuryPointManager : NSObject
singleH(BuryPointManager)

+ (void)startBuryPoint;

+ (void)trackBegin:(long)pageId
           pageUid:(NSString *)pageUid
          pageName:(NSString *)pageName;

+ (void)trackEnd:(long)pageId
        pageUid:(NSString *)pageUid
        pageName:(NSString *)pageName;

+ (void)trackEvent:(NSString *)eventName
          actionId:(long)actionId
            params:(NSDictionary *)params;
@end
