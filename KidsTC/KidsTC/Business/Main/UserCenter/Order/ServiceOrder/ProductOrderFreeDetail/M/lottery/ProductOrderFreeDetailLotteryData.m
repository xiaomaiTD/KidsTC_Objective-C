//
//  ProductOrderFreeDetailLotteryData.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/10.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderFreeDetailLotteryData.h"

@implementation ProductOrderFreeDetailLotteryData
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"ResultLists":[ProductOrderFreeDetailLotteryItem class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    [_ResultLists enumerateObjectsUsingBlock:^(ProductOrderFreeDetailLotteryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.index = idx;
    }];
    
    return YES;
}
@end
