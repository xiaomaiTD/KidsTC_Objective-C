//
//  UserAddressManageModel.m
//  KidsTC
//
//  Created by zhanping on 8/5/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "UserAddressManageModel.h"
#import "UserAddressEditModel.h"
#import "NSString+Category.h"

@implementation UserAddressManageDataItem
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID":@"id"};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic{
    [self setupAddressDesc];
    return YES;
}
- (void)setupAddressDesc{
    NSMutableString *addressDescription = [NSMutableString string];
    if ([_provinceName isNotNull]) [addressDescription appendString:_provinceName];
    if ([_cityName isNotNull]) [addressDescription appendString:_cityName];
    if ([_districtName isNotNull]) [addressDescription appendString:_districtName];
    if ([_streetName isNotNull]) [addressDescription appendString:_streetName];
    if ([_address isNotNull]) [addressDescription appendString:_address];
    _addressDescription = addressDescription;
}

+(instancetype)itemWith:(UserAddressEditModel *)model{
    
    UserAddressManageDataItem *item = [[UserAddressManageDataItem alloc]init];
    
    item.ID = model.ID;
    item.peopleName = model.name;
    item.mobile = model.phone;
    item.address = model.address;
    item.isDefault = model.isDefaultAddressRecorde?1:2;//是否默认 1：是，2：否(可传)
    
    NSArray<AddressDataItem *> *area = model.area;
    item.provinceId = area[0].ID;
    item.cityId = area[1].ID;
    item.districtId = area[2].ID;
    item.streetId = area[3].ID;
    item.provinceName = area[0].address;
    item.cityName = area[1].address;
    item.districtName = area[2].address;
    item.streetName = area[3].address;
    
    [item setupAddressDesc];
    
    return item;
}
@end

@implementation UserAddressManageModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"data" : [UserAddressManageDataItem class]};
}
@end
