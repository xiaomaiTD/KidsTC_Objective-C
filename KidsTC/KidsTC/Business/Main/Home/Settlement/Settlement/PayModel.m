//
//  PayModel.m
//  KidsTC
//
//  Created by zhanping on 8/14/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "PayModel.h"

@implementation PayInfo
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"payType":@"payChannel"};
}
@end

@implementation PayData
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"payType":@"payChannel"};
}
@end

@implementation PayModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}
@end
