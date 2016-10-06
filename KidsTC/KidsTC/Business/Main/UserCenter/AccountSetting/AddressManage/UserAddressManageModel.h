//
//  UserAddressManageModel.h
//  KidsTC
//
//  Created by zhanping on 8/5/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserAddressEditModel;
@interface UserAddressManageDataItem : NSObject
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, assign) NSInteger isDefault;//是否默认 1：是，2：否(可传)
@property (nonatomic, strong) NSString *useTime;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *peopleName;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *streetId;
@property (nonatomic, strong) NSString *streetName;
@property (nonatomic, strong) NSString *districtId;
@property (nonatomic, strong) NSString *districtName;
@property (nonatomic, strong) NSString *cityId;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *provinceId;
@property (nonatomic, strong) NSString *provinceName;
@property (nonatomic, strong) NSString *mobile;

@property (nonatomic, strong) NSString *addressDescription;
+(instancetype)itemWith:(UserAddressEditModel *)model;
@end

@interface UserAddressManageModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) NSArray<UserAddressManageDataItem *> *data;
@end
