//
//  CouponListUnusedModel.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CouponListUnusedModel.h"

@implementation CouponListUnusedModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"data":[CouponListItem class]};
}
@end
