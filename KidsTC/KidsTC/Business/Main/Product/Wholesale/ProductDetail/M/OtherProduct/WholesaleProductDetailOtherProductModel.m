//
//  WholesaleProductDetailOtherProductModel.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WholesaleProductDetailOtherProductModel.h"

@implementation WholesaleProductDetailOtherProductModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"data":[WholesaleProductDetailOtherProduct class]};
}
@end
