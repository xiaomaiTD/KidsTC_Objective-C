//
//  UserAddressEditModel.m
//  KidsTC
//
//  Created by zhanping on 8/4/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "UserAddressEditModel.h"

@implementation UserAddressEditModel
+(instancetype)modelWith:(UserAddressManageDataItem *)item{
    
    UserAddressEditModel *model = [[UserAddressEditModel alloc]init];
    model.ID = item.ID;
    model.name = item.peopleName;
    model.phone = item.mobile;
    model.address = item.address;
    model.isDefaultAddressRecorde = (item.isDefault==1);
    
    AddressDataItem *provinceItem = [AddressDataItem itemWithID:item.provinceId address:item.provinceName level:1 hasNext:YES];
    AddressDataItem *cityItem = [AddressDataItem itemWithID:item.cityId address:item.cityName level:2 hasNext:YES];
    AddressDataItem *districtItem = [AddressDataItem itemWithID:item.districtId address:item.districtName level:3 hasNext:YES];
    AddressDataItem *streetItem = [AddressDataItem itemWithID:item.streetId address:item.streetName level:4 hasNext:NO];
    model.area = @[provinceItem,cityItem,districtItem,streetItem];
    
    return model;
}
@end
