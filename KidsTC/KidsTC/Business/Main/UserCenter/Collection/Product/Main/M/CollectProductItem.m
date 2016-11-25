//
//  CollectProductItem.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/25.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectProductItem.h"

@implementation CollectProductItem
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"productCategory":[CollectProductCategory class]};
}
@end
