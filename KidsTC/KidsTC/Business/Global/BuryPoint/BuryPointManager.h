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
+ (void)registerSdk;
+ (void)trackBegin:(NSString *)pageId;
+ (void)trackEnd:(NSString *)pageId;
@end
