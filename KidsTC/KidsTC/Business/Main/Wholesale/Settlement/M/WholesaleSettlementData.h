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
//shareObj
@property (nonatomic, assign) PayType payType;
@property (nonatomic, assign) NSInteger currentPlaceIndex;
@property (nonatomic, strong) CommonShareObject *shareObject;
@property (nonatomic, strong) NSArray<ServiceSettlementPlace *> *places;
@property (nonatomic, strong) NSArray<SettlementPickStoreDataItem *> *storeItems;
@end
