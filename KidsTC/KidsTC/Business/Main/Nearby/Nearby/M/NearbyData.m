//
//  NearbyData.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NearbyData.h"

@implementation NearbyData
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"data":[NearbyItem class]};
}
@end
