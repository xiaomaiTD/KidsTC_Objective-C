//
//  ProductDetailGetCouponModel.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/29.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailGetCouponModel.h"

@implementation ProductDetailGetCouponModel
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"data":[ProductDetailGetCouponItem class]};
}
@end
