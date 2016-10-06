//
//  CashierDeskModel.m
//  KidsTC
//
//  Created by zhanping on 8/17/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "CashierDeskModel.h"

@implementation CashierDeskChangePayTypeData
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"payType":@"payChannel"};
}
@end

@implementation CashierDeskChangePayTypeModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}
@end

@implementation CashierDeskPayChannel

@end


@implementation CashierDeskOrder
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"payType":@"payChannel"};
}
@end

@implementation CashierDeskData

@end

@implementation CashierDeskModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}
@end
