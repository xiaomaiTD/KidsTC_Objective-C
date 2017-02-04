//
//  FlashSettlementModel.m
//  KidsTC
//
//  Created by zhanping on 8/16/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "FlashSettlementModel.h"

@implementation FlashSettlementPayChannel

@end

@implementation FlashSettlementPriceConfig

@end

@implementation FlashSettlementData
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"priceConfigLs" : [FlashSettlementPriceConfig class]};
}
@end

@implementation FlashSettlementModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}
@end
