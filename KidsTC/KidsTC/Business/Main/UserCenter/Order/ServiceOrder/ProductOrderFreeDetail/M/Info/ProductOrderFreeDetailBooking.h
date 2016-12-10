//
//  ProductOrderFreeDetailBooking.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/10.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductOrderFreeDetailBooking : NSObject
@property (nonatomic, assign) BOOL isOnlineBespeak;
@property (nonatomic, assign) NSInteger advanceDay;
@property (nonatomic, strong) NSString *advanceDayDesc;
@property (nonatomic, assign) BOOL isBabyName;
@property (nonatomic, assign) BOOL isBabyBirthday;
@property (nonatomic, assign) BOOL isBabySex;
@property (nonatomic, assign) BOOL isHouseholdName;
@property (nonatomic, assign) BOOL isDistrictId;
@property (nonatomic, assign) BOOL isBabyAge;
@property (nonatomic, assign) BOOL isUserPhone;
@property (nonatomic, assign) BOOL isUserAddress;
@end
