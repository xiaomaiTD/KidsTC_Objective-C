//
//  RecommendProductModel.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/20.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RecommendProductModel.h"

@implementation RecommendProductModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"data":[RecommendProduct class]};
}
@end
