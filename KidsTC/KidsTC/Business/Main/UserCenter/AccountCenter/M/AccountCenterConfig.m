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
             @"banners":[AccountCenterBanner class],
             @"activityExhibitionHall":[AccountCenterActivity class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    CGFloat ratio = 140.0/320;
    if (_banners.count>0) {
        ratio = _banners.firstObject.Ratio;
    }
    _bannerHeight = ratio * SCREEN_WIDTH;
    
    return YES;
}
@end
