//
//  TCStoreDetailFacility.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/8.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "TCStoreDetailFacility.h"

@implementation TCStoreDetailFacility
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"items":[TCStoreDetailFacilityItem class]};
}
@end
