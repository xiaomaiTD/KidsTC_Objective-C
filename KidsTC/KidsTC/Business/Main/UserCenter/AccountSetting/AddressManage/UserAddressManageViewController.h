//
//  UserAddressManageViewController.h
//  KidsTC
//
//  Created by zhanping on 8/4/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ViewController.h"
#import "UserAddressManageModel.h"

typedef enum : NSUInteger {
    UserAddressManageFromTypeAccountSetting=1,
    UserAddressManageFromTypeSettlement,
} UserAddressManageFromType;

@interface UserAddressManageViewController : ViewController
@property (nonatomic, assign) UserAddressManageFromType fromeType;
@property (nonatomic, copy) void (^pickeAddressBlock)(UserAddressManageDataItem *item);
@end
