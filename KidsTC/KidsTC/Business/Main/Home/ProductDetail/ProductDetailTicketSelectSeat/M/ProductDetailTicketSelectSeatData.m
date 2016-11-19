//
//  ProductDetailTicketSelectSeatData.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/18.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailTicketSelectSeatData.h"

@implementation ProductDetailTicketSelectSeatData
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"seatTimes":[ProductDetailTicketSelectSeatTime class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    if (_seatTimes.count>0) {
        _seatTimes.firstObject.selected = YES;
    }
    
    return YES;
}
@end
