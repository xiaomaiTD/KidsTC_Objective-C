//
//  HomeActivityModel.m
//  KidsTC
//
//  Created by zhanping on 8/9/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "HomeActivityModel.h"

@implementation HomeActivityDataItem
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID":@"id"};
}
@end

@implementation HomeActivityModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}

@end
