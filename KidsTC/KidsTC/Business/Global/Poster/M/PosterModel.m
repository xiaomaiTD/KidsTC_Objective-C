//
//  PosterModel.m
//  KidsTC
//
//  Created by zhanping on 7/25/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "PosterModel.h"

@implementation PosterAdsItem

@end

@implementation PosterData
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"ads":[PosterAdsItem class]};
}
@end

@implementation PosterModel
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"errNo":@"errno"};
}
@end
