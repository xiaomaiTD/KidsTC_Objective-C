//
//  NearbyRecommendModel.m
//  KidsTC
//
//  Created by 童成mac-dev1 on 2017/2/15.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "NearbyRecommendModel.h"

@implementation NearbyRecommendModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"data":[NearbyItem class]};
}
@end
