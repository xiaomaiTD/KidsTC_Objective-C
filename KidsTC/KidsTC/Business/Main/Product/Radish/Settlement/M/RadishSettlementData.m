//
//  RadishSettlementData.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/6.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "RadishSettlementData.h"

NSString *const KRadishSettlementUserRemark = @"RadishSettlementUserRemark";

@implementation RadishSettlementData
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"place":[ServiceSettlementPlace class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    [self dataConversion:dic];
    return YES;
}

- (void)dataConversion:(NSDictionary *)dic {
    if (_minBuyNum<1) {
        _minBuyNum = 1;
    }
    if (_maxBuyNum<_minBuyNum) {
        _maxBuyNum = _minBuyNum;
    }
    _price = [NSString stringWithFormat:@"%@",@(_price.floatValue)];
    _orginalPrice = [NSString stringWithFormat:@"%@",@(_orginalPrice.floatValue)];
    _totalPrice = [NSString stringWithFormat:@"%@",@(_totalPrice.floatValue)];
}
@end
