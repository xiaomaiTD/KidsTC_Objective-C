//
//  ProductDetailTicketSelectSeatTime.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/18.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailTicketSelectSeatTime.h"
#import "NSString+Category.h"
#import "YYKit.h"

@implementation ProductDetailTicketSelectSeatTime
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"seats":[ProductDetailTicketSelectSeatSeat class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    [_seats enumerateObjectsUsingBlock:^(ProductDetailTicketSelectSeatSeat * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.maxBuyNum>=1) {
            obj.selected = YES;
            *stop = YES;
        }
    }];
    return YES;
}

@end
