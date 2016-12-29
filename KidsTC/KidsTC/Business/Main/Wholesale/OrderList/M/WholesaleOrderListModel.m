//
//  WholesaleOrderListModel.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/29.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WholesaleOrderListModel.h"

@implementation WholesaleOrderListModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"data":[WholesaleOrderListItem class]};
}
@end
