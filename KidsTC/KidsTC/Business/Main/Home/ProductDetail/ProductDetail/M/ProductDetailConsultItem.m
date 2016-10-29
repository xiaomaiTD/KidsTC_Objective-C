//
//  ProductDetailConsultItem.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/29.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailConsultItem.h"

@implementation ProductDetailConsultItem
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"replies":[ProductDetailConsultItem class]};
}
@end
