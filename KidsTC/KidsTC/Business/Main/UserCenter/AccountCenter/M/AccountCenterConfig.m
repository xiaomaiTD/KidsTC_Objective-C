//
//  AccountCenterConfig.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/8.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "AccountCenterConfig.h"

@implementation AccountCenterConfig
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"icons" : [NSString class],
             @"banners":[AccountCenterBanner class]};
}
@end
