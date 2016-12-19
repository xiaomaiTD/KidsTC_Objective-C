//
//  ProductDetailFreeApplyShowModel.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/22.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserAddressManageModel.h"
#import "ProductDetailTime.h"
#import "ProductDetailStore.h"
#import "ProductDetailPlace.h"

@interface ProductDetailFreeApplyShowModel : NSObject
@property (nonatomic, assign) BOOL hidePen;
@property (nonatomic, strong) NSString *userPhone;
@property (nonatomic, strong) UserAddressManageDataItem *userAddress;
@property (nonatomic, strong) ProductDetailTime *activityDate;
@property (nonatomic, strong) ProductDetailStore *activityStore;
@property (nonatomic, strong) NSString *babyName;
@property (nonatomic, strong) NSDate   *babyBirth;
@property (nonatomic, assign) NSInteger babyAge;
@property (nonatomic, strong) NSDictionary *babySex;
@property (nonatomic, strong) NSString *parentName;
@property (nonatomic, assign) PlaceType placeType;
@property (nonatomic, assign) ProductDetailPlace *place;
@end
