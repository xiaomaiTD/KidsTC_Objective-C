//
//  RadishProductOrderListDeliver.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/6.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "RadishProductOrderListDeliver.h"
#import "NSString+Category.h"

@implementation RadishProductOrderListDeliver
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"items":[RadishProductOrderListDeliverItem class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSMutableString *string = [NSMutableString stringWithString:_deliverInfo];
    [_items enumerateObjectsUsingBlock:^(RadishProductOrderListDeliverItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.key isNotNull]) {
            NSRange range = [string rangeOfString:obj.key];
            [string replaceCharactersInRange:range withString:obj.value];
        }
    }];
    _deliverStr = [NSString stringWithString:string];
    return YES;
}
@end
