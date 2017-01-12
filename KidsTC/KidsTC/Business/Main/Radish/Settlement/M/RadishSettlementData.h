//
//  RadishSettlementData.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/6.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RadishSettlementChannel.h"
#import "UserAddressEditModel.h"
#import "PayModel.h"
#import "SettlementPickStoreModel.h"
#import "ServiceSettlementPlace.h"

extern NSString *const KRadishSettlementUserRemark;

@interface RadishSettlementData : NSObject
@property (nonatomic, assign) NSInteger buyNum;
@property (nonatomic, assign) NSInteger minBuyNum;
@property (nonatomic, assign) NSInteger maxBuyNum;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *radishSysNo;
@property (nonatomic, strong) NSString *chid;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *orginalPrice;
@property (nonatomic, strong) NSString *totalPrice;
@property (nonatomic, strong) RadishSettlementChannel *payChannel;
@property (nonatomic, strong) UserAddressManageDataItem *userAddressInfo;
@property (nonatomic, assign) BOOL hasUserAddress;
@property (nonatomic, strong) SettlementPickStoreDataItem *store;
@property (nonatomic, strong) NSString *totalRadishCount;
@property (nonatomic, strong) NSString *radishCount;
@property (nonatomic, assign) CGFloat transportationExpenses;
@property (nonatomic, assign) PlaceType placeType;
@property (nonatomic, strong) NSArray<ServiceSettlementPlace *> *place;
@property (nonatomic, strong) NSString *soleId;

//selfDefine
@property (nonatomic, assign) PayType payType;
@property (nonatomic, assign) NSInteger currentPlaceIndex;
@end
