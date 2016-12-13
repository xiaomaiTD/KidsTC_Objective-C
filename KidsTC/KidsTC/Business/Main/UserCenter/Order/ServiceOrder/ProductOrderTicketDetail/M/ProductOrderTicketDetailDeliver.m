//
//  ProductOrderTicketDetailDeliver.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderTicketDetailDeliver.h"
#import "NSString+Category.h"

@implementation ProductOrderTicketDetailDeliver
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"items":[ProductOrderTicketDetailDeliverItem class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSMutableString *string = [NSMutableString stringWithString:_deliverInfo];
    [_items enumerateObjectsUsingBlock:^(ProductOrderTicketDetailDeliverItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.key isNotNull]) {
            NSRange range = [string rangeOfString:obj.key];
            [string replaceCharactersInRange:range withString:obj.value];
        }
    }];
    _deliverStr = [NSString stringWithString:string];
    return YES;
}
@end
