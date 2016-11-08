//
//  AccountCenterHotProduct.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/8.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "AccountCenterHotProduct.h"

@implementation AccountCenterHotProduct
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"productLs" : [AccountCenterHotProductItem class]};
}
@end
