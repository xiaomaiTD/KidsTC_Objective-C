//
//  ProductOrderFreeDetailLotteryModel.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/10.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderFreeDetailLotteryModel.h"

@implementation ProductOrderFreeDetailLotteryModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"data":[ProductOrderFreeDetailLotteryItem class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    [_data enumerateObjectsUsingBlock:^(ProductOrderFreeDetailLotteryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.index = idx;
    }];
    return YES;
}
@end
