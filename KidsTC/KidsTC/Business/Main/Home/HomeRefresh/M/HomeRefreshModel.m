//
//  HomeRefreshModel.m
//  KidsTC
//
//  Created by zhanping on 2016/9/20.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "HomeRefreshModel.h"

@implementation HomeRefreshData
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID":@"id"};
}
@end

@implementation HomeRefreshModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}
@end
