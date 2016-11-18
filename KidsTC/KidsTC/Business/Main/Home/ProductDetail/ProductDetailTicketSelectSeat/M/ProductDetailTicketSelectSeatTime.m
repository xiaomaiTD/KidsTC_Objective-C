//
//  ProductDetailTicketSelectSeatTime.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/18.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailTicketSelectSeatTime.h"

@implementation ProductDetailTicketSelectSeatTime
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"seats":[ProductDetailTicketSelectSeatSeat class]};
}
@end
