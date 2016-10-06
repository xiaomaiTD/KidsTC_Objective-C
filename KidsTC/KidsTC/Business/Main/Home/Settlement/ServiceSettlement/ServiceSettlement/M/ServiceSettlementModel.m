//
//  ServiceSettlementModel.m
//  KidsTC
//
//  Created by zhanping on 8/11/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ServiceSettlementModel.h"

@implementation ServiceSettlementCouponItem

@end

@implementation ServiceSettlementPayType

@end

@implementation ServiceSettlementPromotion

@end

@implementation ServiceSettlementDataItem
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"coupon" : [ServiceSettlementCouponItem class]};
}
@end

@implementation ServiceSettlementModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"data" : [ServiceSettlementDataItem class]};
}
@end
