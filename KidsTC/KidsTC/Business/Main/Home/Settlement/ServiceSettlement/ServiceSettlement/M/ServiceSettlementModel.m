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
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    if (_minBuyNum<1) {
        _minBuyNum = 1;
    }
    if (_maxBuyNum<_minBuyNum) {
        _maxBuyNum = _minBuyNum;
    }
    return YES;
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
