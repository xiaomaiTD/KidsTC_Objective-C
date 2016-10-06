//
//  UserAddressEditModel.h
//  KidsTC
//
//  Created by zhanping on 8/4/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"
#import "UserAddressManageModel.h"
@interface UserAddressEditModel : NSObject
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSArray<AddressDataItem *> *area;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, assign) BOOL isDefaultAddressRecorde;

+(instancetype)modelWith:(UserAddressManageDataItem *)item;
@end
