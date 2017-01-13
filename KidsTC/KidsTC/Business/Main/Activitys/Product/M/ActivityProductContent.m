//
//  ActivityProductContent.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/13.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ActivityProductContent.h"

@implementation ActivityProductContent
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"tabItems":[ActivityProductTabItem class],
             @"couponModels":[ActivityProductCoupon class],
             @"productItems":[ActivityProductItem class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _segueModel = [SegueModel modelWithDestination:_linkType paramRawData:_params];
    return YES;
}
@end
