//
//  TCStoreDetailNearbyData.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/9.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "TCStoreDetailNearbyData.h"

@implementation TCStoreDetailNearbyData
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"nearStores":[TCStoreDetailNearbyStore class],
             @"nearProducts":[TCStoreDetailNearbyProduct class]};
}
@end
