//
//  RadishMallData.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/9.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "RadishMallData.h"

@implementation RadishMallData
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"icons":[RadishMallIcon class],
             @"topProducts":[RadishMallProduct class],
             @"hotProducts":[RadishMallProduct class],
             @"banners":[RadishMallBanner class]};
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    NSMutableArray *ary = [NSMutableArray array];
    //plant
    RadishMallProduct *plant = [RadishMallProduct new];
    plant.showType = RadishMallProductTypePlant;
    if (plant) [ary addObject:plant];
    //items
    NSUInteger iconsCount = self.icons.count;
    if (iconsCount>0) {
        RadishMallProduct *icon = [RadishMallProduct new];
        icon.showType = RadishMallProductTypeItems;
        if (icon) [ary addObject:icon];
    }
    //top
    [self.topProducts enumerateObjectsUsingBlock:^(RadishMallProduct *obj, NSUInteger idx, BOOL *stop) {
        obj.showType = RadishMallProductTypeLarge;
        if (obj) [ary addObject:obj];
    }];
    //hot
    if (self.hotProducts.count>0) {
        RadishMallProduct *hotTip = [RadishMallProduct new];
        hotTip.showType = RadishMallProductTypeHot;
        if (hotTip) [ary addObject:hotTip];
    }
    [self.hotProducts enumerateObjectsUsingBlock:^(RadishMallProduct *obj, NSUInteger idx, BOOL *stop) {
        obj.showType = RadishMallProductTypeSmall;
        if (obj) [ary addObject:obj];
    }];
    //banner
    if (self.banners.count>0) {
        RadishMallProduct *banner = [RadishMallProduct new];
        banner.banners = self.banners;
        banner.showType = RadishMallProductTypeBanner;
        if (banner) [ary addObject:banner];
    }
    self.showProducts = [NSArray arrayWithArray:ary];
    
    return YES;
}
@end
