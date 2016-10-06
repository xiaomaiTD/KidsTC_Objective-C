//
//  AddressModel.m
//  KidsTC
//
//  Created by zhanping on 8/4/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "AddressModel.h"

@implementation AddressDataItem
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID":@"id"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"subAddress" : [AddressDataItem class]};
}
+ (instancetype)itemWithID:(NSString *)ID address:(NSString *)address level:(NSInteger)level hasNext:(BOOL)hasNext{
    AddressDataItem *item = [[AddressDataItem alloc]init];
    item.ID = ID;
    item.address = address;
    item.level = level;
    item.hasNextLevelAddress = hasNext;
    return item;
}
@end

@implementation AddressModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"data" : [AddressDataItem class]};
}
@end
