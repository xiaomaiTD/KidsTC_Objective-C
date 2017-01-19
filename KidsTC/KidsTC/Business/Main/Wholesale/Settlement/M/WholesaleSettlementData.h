//
//  WholesaleSettlementData.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/29.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WholesaleSettlementStore.h"
#import "WholesaleSettlementPlace.h"
#import "WholesaleSettlementShare.h"
#import "WholesaleSettlementPayChannel.h"
#import "CommonShareObject.h"
#import "PayModel.h"
#import "ServiceSettlementPlace.h"
#import "WholesalePickDateSKU.h"
#import "UserAddressEditModel.h"
#import "WholesaleSettlementTime.h"

@interface WholesaleSettlementData : NSObject
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *fightGroupPrice;
@property (nonatomic, strong) NSString *openGroupUserCount;
@property (nonatomic, strong) NSString *productImage;
@property (nonatomic, assign) PlaceType placeType;
@property (nonatomic, strong) NSString *flowUrl;
@property (nonatomic, strong) NSArray<WholesaleSettlementPlace *> *place;
@property (nonatomic, strong) WholesaleSettlementStore *store;
@property (nonatomic, strong) NSArray<WholesaleSettlementStore *> *stores;
@property (nonatomic, strong) WholesaleSettlementShare *share;
@property (nonatomic, strong) WholesaleSettlementPayChannel *appPayChannel;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *userMobile;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *productNo;
@property (nonatomic, strong) NSString *chId;
@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, strong) WholesalePickDateSKU *sku;
@property (nonatomic, strong) WholesaleSettlementTime *time;
@property (nonatomic, strong) NSString *fightGroupSysNo;
@property (nonatomic, strong) NSString *openGroupSysNo;
@property (nonatomic, assign) BOOL hasUserAddress;
@property (nonatomic, strong) UserAddressManageDataItem *userAddressInfo;
//shareObj
@property (nonatomic, assign) PayType payType;
@property (nonatomic, assign) NSInteger currentPlaceIndex;
@property (nonatomic, strong) CommonShareObject *shareObject;
@property (nonatomic, strong) NSArray<ServiceSettlementPlace *> *places;
@property (nonatomic, strong) NSArray<SettlementPickStoreDataItem *> *storeItems;
@end
